## Synopsis

Macro script `hquery.sas` is a data step / hash table implementation of SQL SELECT statement with added property of outputting non-matched records in their own tables - functionality commonly seen in etl tools. Only INNER|LEFT JOIN operations are currently supported. Script takes arbitrary number of calling arguments, where only the first one - imagined as _main_ table is processed via data step loop, all others - imagined as _lookups_ are loaded in-memory. Macro expects common SAS data step options / statements / functions syntax in calling arguments. Following aggregation functions are supported: 

|Suffix		|Description|Type|
|--- 		|---|---|
|_NMISS | Number of missing records in group.|N/C|
|_CNT   | Number of non-missing records in group.|N/C|
|_CNTD  | Number of distinct non-missing records in group.|N/C|
|_SUM   | Sum of non-missing records in group.|N|
|_SUMD  | Sum of only distinct non-missing records in group.|N|
|_PROD  | Product of non-missing records in group.|N|
|_PRODD | Product of only distinct non-missing records in group. |N|
|_MIN   | Smallest value in group. |N|
|_MAX   | Largest value in group.|N|
|_RNG   | Difference between largest and smallest value within group.|N|
|_FREQ  | Frequency of group relative to total number of records.|N/C|
|_AVG   | Average value of non-missing records in group.|N|
|_VAR   | Variance of non-missing records in group.|N|
|_FIRST | First value in alphabetically sorted group of character column type. |C|
|_LAST  | Last value in alphabetically sorted group of character column type. |C|

(N is numeric type column, C is character type column)

To apply summary functions main table has to be previously sorted by column(s) identifying by-group. All other arguments (lookups) need not to be sorted.  Resulting summary columns preserve source column formats. Script accepts non-unique keys in lookups with `multidata` option and will perform join. Script allows creation of one additional variable in pdv (user inputs arbitrary sas expression) to cover the case when key has to be transformed prior to join operation. In just _one_ I/O pass through tables script is able to perform: filtering columns / rows, aggregation including having clause and join with arbitrary number of lookup tables that don't need previous sorting. 

## Tests

Best place to start is to run demo scripts and see how invocation looks like. Run in this exact order: `demo_data.sas` script to create test data in work library, then resolve and compile macro script: `hquery.sas` and finally run tests in `demo_tests.sas`.

## Code Example

General case for macro invocation:

```
%hquery (
    SAS-data-set 	<( data-set-options )>
        OUT         = SAS-data-set 	<( data-set-options )>
       <BY          = <DESCENDING> variable-1 <... variable-n>
        AGGR        = variable-1_summary-function-suffix <...variable-n_summary-function-suffix>
       <HAVING      = sas-boolean-expression> >
       <_CLCVAR_    = sas-right-hand-side-expression>
       <OPT         = <INNER|LEFT>_JOIN<_REJ>
    <;
    SAS-data-set-1 	<( data-set-options )>
        KEY         = 'variable-1', <... 'variable-n',>
        DATA        = 'variable-1', <... 'variable-n',> | all:"yes"
        FIND        = KEY: keyvalue-1|variable-1, <...KEY: keyvalue-n|variable-n>
       <OUT         = SAS-data-set>
       <OPT         = MULTIDATA>
    ...;>        
);
```
Example invocation:
```
%hquery(
    work.dsin ( drop  = col1 col2 
    			where = (col3='some...text' and col4>12784) 
    			rename= (col5=newcol5 col6=newcol6) )
        OUT           = work.result (keep = newcol5 col2_avg 
        							 where= (col1_max='01-04-2016'dt))
        BY            = descending col1
        AGGR          = col1_cntd col1_max col2_avg col3_last col8_first
        HAVING        = col2 > col2_avg
        _CLCVAR_      = datepart(col1)
        OPT           = LEFT_JOIN_REJ
    ;
    work.lkp1 (	keep = fkey1 fkey2 col11 data1 data2 
    			where= (filter in ('a','b',"c")) )
        KEY          = 'fkey1', 'fkey2', 'col11'
        DATA         = 'data1', 'data2'
        FIND         = key: 'some...literal...', key: _clcvar_, key: col11
        OUT          = work.lkp1_rejects
        OPT          = MULTIDATA
    ;
    work.lkp2 ( keep = fkey3 fkey4 data3 data4 
    			where= (filter in ('d','e',"f")) )
        KEY          = 'fkey3', 'fkey4'
        DATA         = all: "yes"
        FIND         = key: newcol5, key: 500
        OUT          = work.lkp2_rejects
);
```
## Instructions

- Do not use semicolon after last argument or in case of only one argument.
- If you supply join in OPT option, you have to list at least one lookup table
- If OPT option contains \_REJ switch then you have to supply OUT option in every lookup table. Those table(s) will contain non-matched records after join operation.
- In lookup's OUT option sas-data-set-options are _not_ allowed.
- HAVING clause is executed before key lookup (join) is performed (if there is any join specified), therefore its sas-boolean-expression may contain only variables present in main table and variables calculated by summary functions.
- FIND option has to be supplied even when variable in main table and corresponding key variable in lookup share the same name. 
- Option ordering is irrelevant.

Option list for main table:

|Option		|Description|
|--- 		|---|
|OUT		| Use [set] statement syntax excluding options part. Data-set-options are allowed, but options are not. Define here name for the result table. In case of `_rej` join option, provided name will be suffixed with "\_rej" to give name to additional rejects table. That table will inherit all data-set-options given here as well.|
|BY			| Use [by] statement syntax. |
|AGGR		| Enter space separated case-insensitive list of column names suffixed with summary function name. Suffix instructs what aggregation will be applied and at the same time gives a name to newly created variable. Formats are preserved from source variable. You may reference this new variable in subsequent options (having, \_clcvar\_, find)
|HAVING		| Enter any valid sas logical expression. You may reference only variables from main table, not lookup tables. This is intended to be used as a row filter condition after aggregation, so that expression can reference resulting fields from aggregation. |
|\_CLCVAR\_| Enter any valid sas right hand side expression. This expression is used as right hand side of an assignment operation to a variable called \_clcvar\_. You may reference this new variable in subsequent find options. It is intended to be used in case when a key variable from main table has to be transformed previous to join operation. It is automatically dropped and not included in result. 
|OPT		| Only in a case when join operation is intended, you may enter here: `inner_join`, `left_join`, `inner_join_rej`, `left_join_rej`. Suffix `_rej` switches on additional output tables for all non-matched records after join. If present, then code expects OUT option for each lookup table from which it takes the name of rejects table. For the main table's rejects, code will take the name as provided in main table's OUT option and suffixed it with additional "\_rej". 

Option list for lookup tables:

|Option		|Description|
|--- 		|---|
|KEY		|Use syntax from [DefineKey] method of sas hash object. Phrase "all":yes is not allowed.|
|DATA		|Use syntax from [DefineData] method of sas hash object. Phrase "all":yes is allowed.|
|FIND		|Use syntax from [find] method of sas hash object.|
|OUT		|If \_rej switch was used in join option, then provide here a name for the rejects table. Sas data set options are not allowed.|
|OPT		|Supply this option with value `multidata` if lookup table has a non-unique key combination and duplicate key values are to be preserved for joining. Otherwise only last appearing key value will be added to lookup hash table.|

## Motivation

Aim was to demonstrate practical coding patterns in sas data step & macro programming like:

- DOW loop and explicit output with multiple exit points.
- Dynamic programming with proc contents / dictionary tables, e.g. code is taking source formats without user intervention.
- Macro quoting, macro variable lists.
- Regex parsing of macro parameters.
- Properties and methods of hash table / hash table iterator.
- SAS arrays (to implement summary functions code uses helper hash table to access array members by member name instead of its position)
- Bridging functions like symputx(), %sysfunc().

## License

MIT License 2016.

[set]: http://support.sas.com/documentation/cdl/en/lrdict/64316/HTML/default/viewer.htm#a000173782.htm
[by]: http://support.sas.com/documentation/cdl/en/lrdict/64316/HTML/default/viewer.htm#a000202968.htm
[DefineKey]: http://support.sas.com/documentation/cdl/en/lecompobjref/69740/HTML/default/viewer.htm#n0idnipdo4awyun1q8zv7427r23f.htm
[DefineData]: http://support.sas.com/documentation/cdl/en/lecompobjref/69740/HTML/default/viewer.htm#n02pzusloev8uan154o0frscuzur.htm
[find]: http://support.sas.com/documentation/cdl/en/lecompobjref/69740/HTML/default/viewer.htm#p0v7y0he52atdan1iwtpwryes1dw.htm