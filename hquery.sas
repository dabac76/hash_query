/* DEBUG 
filename mprint '/folders/myfolders/.sasstudio/snippets/gen_code.sas';
options linesize=100 mlogic symbolgen mprint mfile;
*/
/*  *****+++++++**************
        MAIN MACRO : BEGIN
    ****++++++++************* */
%macro hquery() /parmbuff;
    
    /* Scope everything local to prevent collisions with global sym table */
    %local buffer pos len startpos smccount exprID main_table token_len;
    %local set_statement prev_pos prev_len cnt lookup_table out_dsn;
    %local libr dsn format_statement ;
    %local aggr_num_list aggr_chr_list aggr_chr2num_list definedata;
    %local aggr_num_exist aggr_chr_exist aggr_chr2num_exist;

    %put buffer holds: &syspbuff;

    /* SYSPBUFF looks like quoted by default, keep it quoted for further processing */
    %let buffer     = %qsubstr(&syspbuff, 2, %length(&syspbuff)-2);
    %let smccount   = %sysfunc(countc(&buffer,%str(;)));

    /* *** EXTRACT 1ST ARGUMENT: MAIN TABLE : BEGIN *** */
    %let exprID         = %sysfunc(prxparse(/(\b(?:out|by|aggr|having|opt|_clcvar_)\b\s*=)/is));
    %let startpos       = 1;
    %let pos            = 1;
    %let len            = 0;
    /* Take argument token (everything between two consecutive semi-cols) */ 
    %let main_table     = %qscan(&buffer, 1, %str(;));
    /* Extract set_statement - advance with prxnext, take preceding text */
    %let token_len      = %length(&main_table);
    %syscall prxnext(exprID, startpos, token_len , main_table, pos, len);
    %let set_statement = %qsubstr(&main_table, 1, &pos-1);
    /* Extract rest - advance with prxnext, take preceding interval */
    %do %while (&pos >0);
        %let prev_pos = &pos;
        %let prev_len = &len;
        %syscall prxnext(exprID, startpos, token_len, main_table, pos, len);
        /* Dynamic macro variable naming  */        
        %if &pos > 0 %then %do;
            %local %substr(&main_table, &prev_pos, &prev_len-1); 
            %let   %substr(&main_table, &prev_pos, &prev_len-1) 
                    = %qsubstr(&main_table, &prev_pos+&prev_len, &pos-(&prev_pos+&prev_len)); 
        %end;
        %else %do; 
            %local %substr(&main_table, &prev_pos, &prev_len-1);
            %let   %substr(&main_table, &prev_pos, &prev_len-1)
                    = %qsubstr(&main_table, &prev_pos+&prev_len); 
        %end;
    %end;
    /* Flush */
    %syscall prxfree(exprID);
    /* *** EXTRACT 1ST ARGUMENT: MAIN TABLE : END *** */
    
    /* EXTRACT REST OF THE ARGUMENTS: LOOKUP TABLES : BEGIN */
    %let exprID = %sysfunc(prxparse(/(\b(?:key|data|find|out|opt)\b\s*=)/is));
    %do cnt = 1 %to &smccount;
        %let startpos   = 1;
        %let pos        = 1;
        %let len        = 0; 
        /* Take argument token (everything between two consecutive semi-cols) */
        %let lookup_table       = %qscan(&buffer, &cnt+1, %str(;));
        /* Extract set_statement - advance with prxnext, take preceding text */
        %let token_len          = %length(&lookup_table);
        %syscall prxnext(exprID, startpos, token_len, lookup_table, pos, len);
        %local set_statement&cnt; 
        %let set_statement&cnt = %qsubstr(&lookup_table, 1, &pos-1);
        /* Extract rest within current lookup table
            - advance with prxnext, take preceding interval between two finds*/
        %do %while (&pos >0);
            %let prev_pos = &pos;
            %let prev_len = &len;
            %syscall prxnext(exprID, startpos, token_len, lookup_table, pos, len);
            /* Dynamic variable naming with iterating suffix  */
            %if &pos > 0 %then %do;
                %local %sysfunc(catx(%str(), %substr(&lookup_table, &prev_pos, &prev_len-1), &cnt)); 
                %let   %sysfunc(catx(%str(), %substr(&lookup_table, &prev_pos, &prev_len-1), &cnt))
                        = %qsubstr(&lookup_table, &prev_pos+&prev_len, &pos-(&prev_pos+&prev_len)); 
            %end;
            %else %do;
                %local %sysfunc(catx(%str(), %substr(&lookup_table, &prev_pos, &prev_len-1), &cnt)) ;
                %let   %sysfunc(catx(%str(), %substr(&lookup_table, &prev_pos, &prev_len-1), &cnt))
                        = %qsubstr(&lookup_table, &prev_pos+&prev_len); 
            %end;
        %end;  
    %end;
    /* Flush */
    %syscall prxfree(exprID);
    /* EXTRACT REST OF THE ARGUMENTS: LOOKUP TABLES : END */

    /* PARSE PARTS OF EXCTRACTED ARGUMENTS FOR LATER USE IN THE CODE : BEGIN */
    /* !Blank character inside %str in %scan counts as part of separator char class! */
    /* But in %index it counts as part of a phrase! So it won't match "libref.name(keep=...)" case! */
    %let out_dsn     = %scan(&out, 1 , %str( %() );
    %let out_dsopts  = %qsubstr(&out, %index(&out, %str(%() ));

    /* Parse main table's opt statement:  take join condition (left/inner_join/_rej)  */
    /* Currently this is the only opt parametar */
    %if %symlocal(opt) %then %let opt_join = %upcase(&opt);

    %do cnt = 1 %to &smccount;
        /* Parse lookup's data list for usage in join operation: 
            - remove single/double quotes (for use in call routine missing(...))
            - remove all appearances of key names in list (they should not be wiped)*/
        /* If user input is all: "yes" phrase, take all col names from dict tables excluding keys */
        %let libr = %upcase(%scan(%scan(&&set_statement&cnt, 1, %str( %()), 1,.));
        %let dsn  = %upcase(%scan(%scan(&&set_statement&cnt, 1, %str( %()), 2,.));
        proc sql noprint;
            select  name into :data_list&cnt separated by ',' from dictionary.columns 
            where   libname = "&libr" 
                    and memname = "&dsn" 
        %if %sysfunc(find(&&data&cnt, %str("yes"))) or %sysfunc(find(&&data&cnt, %str('yes'))) %then %do;
                    and upcase(name) not in (%upcase(&&key&cnt)) 
        %end; %else %do;
                    and upcase(name) not in (%upcase(&&key&cnt)) 
                    and upcase(name)     in (%upcase(&&data&cnt))
        %end; 
        ;
        quit;
        
        /* Shave off all chars except: alpha-numeric, space, comma
        %let   data_list&cnt = %sysfunc(compress(&&data&cnt, %str(,) ,kns));*/

        /* Parse lookup's opt statement : multidata (default: off)*/
        %local multi&cnt;
        %let   multi&cnt = 0;
        %if %symlocal(opt&cnt) %then %do;
            %if %sysfunc(find(%upcase(&&opt&cnt), MULTIDATA)) 
                %then %let  multi&cnt = 1;
        %end;
    %end;

    /*  - Copy source formats
        - Classify type of aggregated variables 
        - Prepare variable list (space separated, double quoted col names)
            for hbygroup hash table DefineData statement */
    %if %symlocal(aggr) %then %do;
        data _null_;
            /* Load descriptor from main_table argument */
            if 0 then set %unquote(&set_statement);
            array allnum _numeric_;
            array allchr _character_;
            length aggr_num_exist     $1;
            length aggr_chr_exist     $1;
            length aggr_chr2num_exist $1;
            /* MAX number of aggregated columns: 128 */
            length aggr              $4096;
            length format_statement  $4096;
            length aggr_num_list     $4096;
            length aggr_chr_list     $4096;
            length aggr_chr2num_list $4096;
            /* MAX nnumber of columns in main table: 1024 */
            length definedata        $32767;
            
            aggr = "&aggr";
            aggr_num_exist     = '0';
            aggr_chr_exist     = '0';
            aggr_chr2num_exist = '0';

            /* Variable list for hbygroup hash table */           
            do over allnum;
                definedata = catx(',', definedata, '"'||vname(allnum)||'"');    
            end;
            do over allchr;
                definedata = catx(',', definedata, '"'||vname(allchr)||'"');    
            end;

            do cnt = 1 to countw(aggr, ,'s');
                /* Summary functions which do not preserve source format: NMISS, CNT(D), FREQ */
                if not(upcase(scan(scan(aggr, cnt, , 's'), 2, '_')) in ('NMISS', 'CNT', 'CNTD', 'FREQ')) then 
                    /* Copy source formats */
                    format_statement = 
                        catx(' ', format_statement, scan(aggr, cnt, , 's'), vformatx(scan(scan(aggr, cnt, , 's'), 1, '_')));
                /* Classify types */
                if vtypex(scan(scan(aggr, cnt, , 's'), 1, '_')) = 'N' then do;
                    aggr_num_exist = '1'; 
                    aggr_num_list  = catx(' ', aggr_num_list, scan(aggr, cnt, , 's'));
                end;
                else do;
                    /* Summary function which when applied to CHAR vars give NUM results */
                    if upcase(scan(scan(aggr, cnt, , 's'), 2, '_')) in ('NMISS', 'CNT', 'CNTD', 'FREQ') then do;
                        aggr_chr2num_exist = '1';
                        aggr_chr2num_list  = catx(' ', aggr_chr2num_list, scan(aggr, cnt, , 's'));
                    end;
                    else do;
                        aggr_chr_exist     = '1';
                        aggr_chr_list      = catx(' ', aggr_chr_list, scan(aggr, cnt, , 's'));
                    end;
                end;
            end;
            
            format_statement = cat('format ', format_statement);
            /*  Contrary to documentation, symputx is giving log note on numeric2char conversion.
                Even a faulty one because all variables passed to macro are of character type. 
                Unexpected behavior happens only when optional var scope argument is used. 
                So, instead of giving scope through optional 3rd arg, variables are declared 
                previously. */
            call symputx('format_statement', format_statement);
            call symputx('definedata', definedata);
            call symputx('aggr_num_list',  aggr_num_list);
            call symputx('aggr_num_exist', aggr_num_exist);
            call symputx('aggr_chr_list',  aggr_chr_list); 
            call symputx('aggr_chr_exist', aggr_chr_exist);           
            call symputx('aggr_chr2num_list', aggr_chr2num_list); 
            call symputx('aggr_chr2num_exist', aggr_chr2num_exist);
            stop;
        run;
    %end;
    /* PARSE PARTS OF EXCTRACTED ARGUMENTS FOR LATER USE IN THE CODE : END */

/*  ************************************
        MAIN DATA STEP INJECTION : BEGIN
    ************************************ */
data &out 
%if %symlocal(opt_join) %then %do;
    %if %scan(&opt_join, 3, _) = REJ %then %do;
        &out_dsn._rej %unquote(&out_dsopts)
    %end;
%end;
;

drop _:;

%if %symlocal(aggr) %then %do;
    /* Create arrays from main table columns and expose its descriptor to object comp. interface */
    /* !NO VARIABLES ARE ALLOWED TO BE DECLARED BEFORE THIS!  */
    if 0 then set %unquote(&set_statement);
    %if &aggr_num_exist %then array allnum[*] _numeric_;;
    %if &aggr_chr_exist or &aggr_chr2num_exist %then array allchr[*] _character_;;
%end;

/* Load all LOOKUP TABLES */
%if &smccount > 0 %then %do;
    length _rjind 3;
    %do cnt = 1 %to &smccount;
        /* Host all lookup data to pdv */
        if 0 then set %unquote(&&set_statement&cnt);
        length _rc&cnt 3;
        _rc&cnt = 0;
    %end;
    _rjind     = 1;
    _keycount  = 1;
    _keyinc    = 1;
    if _n_ = 1 then do;
        %do cnt = 1 %to &smccount;
            dcl hash lookup&cnt    (dataset: "%unquote(&&set_statement&cnt)", 
                                    %if &&multi&cnt %then multidata: "y",; 
                                    keysum: "_keycount", 
                                    suminc: "_keyinc", 
                                    ordered: "a");
            lookup&cnt..DefineKey  (%unquote(&&key&cnt));
            lookup&cnt..DefineData (%unquote(&&data&cnt));
            lookup&cnt..DefineDone ();
        %end;
    end;
%end;

%if %symlocal(aggr) %then %do;
    length _hbygroup_key 8 _keycount 3 _keyinc 3 _varpos 3 _varname $32 _cntnmiss 8; 
    %if &aggr_num_exist %then length _nvalue 8 _len_num 3 _sumall 8 _avg 8;;
    %if &aggr_chr_exist or &aggr_chr2num_exist %then length _cvalormd5 $16 _len_chr 3;;

    /*  Preserve source format for new aggregated vars */ 
    &format_statement;
    
     %if &aggr_num_exist %then retain _len_num _len_nsumf;;
     %if &aggr_chr_exist or &aggr_chr2num_exist %then retain _len_chr _len_csumf;;
 
    %if &aggr_num_exist     %then array keyw_aggr_num[*]     &aggr_num_list;;
    %if &aggr_chr_exist     %then array keyw_aggr_chr[*]     &aggr_chr_list;;
    %if &aggr_chr2num_exist %then array keyw_aggr_chr2num[*] &aggr_chr2num_list;;
     
     /* Need the position of elem in array because of non-sequential access to members by using name ! */
     /* CHANGE ARRAY LENGTH WHEN NEW SUMMARY FUNCTION IS ADDED */
     %if &aggr_num_exist %then array _nsumfpos[13] _temporary_;;
     %if &aggr_chr_exist or &aggr_chr2num_exist %then array _csumfpos[6]  _temporary_;;
     
     %if &aggr_num_exist     %then call missing (of keyw_aggr_num[*], of _nsumfpos[*]);;
     %if &aggr_chr_exist     %then call missing (of keyw_aggr_chr[*], of _csumfpos[*]);;
     %if &aggr_chr2num_exist %then call missing (of keyw_aggr_chr2num[*], of _csumfpos[*]);;

    /* define 4 hash tables: 1- accumulates all cols, 2- works with num vars, 3-works with char vars optionally uses md5  */
    /*                       4- store key_aggr var names and each elem position for non-sequential array access by var name */
    if _n_ = 1 then do;

        /* INITs */
        _keycount  = 1;
        _keyinc    = 1;
        %if &aggr_num_exist %then _len_num   = dim(allnum);;
        %if &aggr_num_exist %then _len_nsumf = dim(_nsumfpos);;
        %if &aggr_chr_exist or &aggr_chr2num_exist %then _len_chr   = dim(allchr);;
        %if &aggr_chr_exist or &aggr_chr2num_exist %then _len_csumf = dim(_csumfpos);;

        /* HASH TABLE 1 : store instance of by-group from source dataset */
        /* This avoids avoid double dow loop = two data passes. */
        /* First loop feeds the group to hash to catch distinct values */
        /* second one would calculate aggregates. Instead aggregates will be */
        /* calculated from the hash table to avoid costly I/O for two reads */
        /* All this is unavoidable if one wants to implement DISTINCT version */
        /* of sql summary functions. */
        /* Only one by group is fed to hash since main table can be unpredictably huge */
        /* Default ordering is NO (undefined order) as wanted */
        dcl hash   hbygroup  ();
        dcl hiter  ihbygroup ("hbygroup");
        hbygroup.DefineKey   ("_hbygroup_key");
        hbygroup.DefineData  (&definedata);
        hbygroup.DefineDone  ();

        /* HASH TABLE 4 : Store keyw_aggr_num element NAMES and their positions in keyw_aggr_num for non-sequential array access */
        /* Use binary tree  */
        dcl hash map_aggr   (ordered: "a", hashexp: 0);
        map_aggr.DefineKey  ("_varname");
        map_aggr.DefineData ("_varpos");
        map_aggr.DefineDone ();

        /* HASH TABLE 2 : temp place for each num variable in by group for calc summary funcs */
        /* Iterate through each numerical column of hbygroup() */
        /* Assign numeric column as key to one-column numaggr() hash  */
        /* Calculate summary functions and clear the hash to be ready for */
        /* the next numeric columm */
        %if &aggr_num_exist %then %do;
            dcl hash  numaggr  (ordered: "a", keysum: "_keycount", suminc: "_keyinc");
            dcl hiter inumaggr ("numaggr");
            numaggr.DefineKey  ("_nvalue");
            numaggr.DefineData ("_nvalue");
            numaggr.DefineDone ();
            /* Load hash4 with aggr num array */
            _varpos = 0;
            do _n_ = 1 to dim(keyw_aggr_num);
                _varname = upcase(vname(keyw_aggr_num[_n_]));
                _varpos+1;
                map_aggr.ref();
            end;
        %end;
        /* HASH TABLE 3 : temp place for each char variable in by group for calc summary funcs */
        /* Iterate through each character column of hbygroup() */
        /* Assign character column as key to one-column charaggr() hash  */
        /* Calculate summary functions and clear the hash to be ready for */
        /* the next character columm */
        %if &aggr_chr_exist or &aggr_chr2num_exist %then %do;
            dcl hash  charaggr  (ordered: "a", keysum: "_keycount", suminc: "_keyinc");
            dcl hiter icharaggr ("charaggr");
            charaggr.DefineKey  ("_cvalormd5");
            charaggr.DefineData ("_cvalormd5");
            charaggr.DefineDone ();
            
            %if &aggr_chr_exist %then %do;
                /* Load hash4 with aggr char arrays */
                _varpos = 0;
                do _n_ = 1 to dim(keyw_aggr_chr);
                    _varname = upcase(vname(keyw_aggr_chr[_n_]));
                    _varpos+1;
                    map_aggr.ref();
                end;
            %end;
            %if &aggr_chr2num_exist %then %do;
                _varpos = 0;
                do _n_ = 1 to dim(keyw_aggr_chr2num);
                    _varname = upcase(vname(keyw_aggr_chr2num[_n_]));
                    _varpos+1;
                    map_aggr.ref();
                end;
            %end;
        %end;
    end;
%end;

/* Load additional oneliner in case transformed variable has to be used for joining */
%if %symlocal(_clcvar_) %then _clcvar_ = %unquote(&_clcvar_);;

/* MAIN DOW LOOP (if aggregation requested) or MAIN SET STATEMENT (if not) */
%if %symlocal(by) %then %do;
    _hbygroup_key = 0;
	do until (last.%scan(&by, -1, %str( )));;
        set %unquote(&set_statement) END=EOF NOBS=_OBSTOTAL;
        /* Demands source to be sorted by that condition */
        /* either explicitely (proc contents/sort info) or implicitely */
        by &by;
        
        /* Fill HASH TABLE 1 */
        _hbygroup_key+1;
        %if %symlocal(aggr) %then hbygroup.add();;
    end;
%end;
%else %do;
    set %unquote(&set_statement) END=EOF;
%end;

%if %symlocal(aggr) %then %do;
%if &aggr_num_exist %then %do;
    /* Traverse all numeric columns from hbygroup */
    _cntnmiss = 0;
    do _n_ = 1 to _len_num;

        /* Do all below only if you find 'vname(allnum[_n_])_*' in keyw_aggr_num[], i.e. map_aggr table'  */
        call missing (of _nsumfpos[*]);
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_NMISS')) then _nsumfpos[1]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_CNTD'))  then _nsumfpos[2]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_CNT'))   then _nsumfpos[3]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_SUM'))   then _nsumfpos[4]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_SUMD'))  then _nsumfpos[5]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_MIN'))   then _nsumfpos[6]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_MAX'))   then _nsumfpos[7]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_RNG'))   then _nsumfpos[8]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_PROD'))  then _nsumfpos[9]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_PRODD')) then _nsumfpos[10] = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_FREQ'))  then _nsumfpos[11] = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_AVG'))   then _nsumfpos[12] = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allnum[_n_])), '_VAR'))   then _nsumfpos[13] = _varpos;
        
        if cmiss(of _nsumfpos[*]) = _len_nsumf then continue;

        /* Traverse hbygroup data & fill its nth numeric data column as keys to numaggr*/
        do  _rc = ihbygroup.first() by 0 while (_rc = 0);
            _nvalue = allnum[_n_];
            if missing(_nvalue) & (cmiss(_nsumfpos[1], _nsumfpos[3], _nsumfpos[12], _nsumfpos[13]) < 4) then
                _cntnmiss = sum(_cntnmiss, 1);
            else 
                /*  SAS ISSUE: ref()/check() methods are NOT incrementing key summary as documented. 
                    At this moment only find() method is. When issue gets solved one  simple ref() call 
                    will be enough */
                /* numaggr.ref(); */ 
                if numaggr.find() then do; _keycount=1; numaggr.add(); end;
            _rc = ihbygroup.next();
        end;

        /* Calculate summary functions */
        
        /* NMISS */
        if not(missing(_nsumfpos[1])) then do;
            keyw_aggr_num[_nsumfpos[1]] = _cntnmiss;
        end;
        /* COUNT DISTINCT not nulls */
        if not(missing(_nsumfpos[2])) then do;
            keyw_aggr_num[_nsumfpos[2]] = numaggr.NUM_ITEMS;
        end;
        /* COUNT ALL not nulls */
        if not(missing(_nsumfpos[3])) then do;
            keyw_aggr_num[_nsumfpos[3]]  = hbygroup.NUM_ITEMS - _cntnmiss;
        end;
        /* SUM */
        if cmiss(_nsumfpos[4], _nsumfpos[12]) < 2 then do;
            do _rc = inumaggr.first() by 0 while (_rc = 0);
                _sumall = sum(_sumall, _keycount * _nvalue);
                _rc = inumaggr.next();
            end;
            if not(missing(_nsumfpos[4])) then keyw_aggr_num[_nsumfpos[4]] = _sumall;
        end;
        /* SUM DISTINCT */
        if not(missing(_nsumfpos[5])) then do;
            do _rc = inumaggr.first() by 0 while (_rc = 0);
                keyw_aggr_num[_nsumfpos[5]] = sum(keyw_aggr_num[_nsumfpos[5]], _nvalue);
                _rc = inumaggr.next();
            end;    
        end;
        /* MIN */
        if not(missing(_nsumfpos[6])) then do;
            _rc = inumaggr.first();
            keyw_aggr_num[_nsumfpos[6]] = _nvalue;
            /* Point iterator to null, to be able to clear table */
            _rc = inumaggr.prev();
        end;
        /* MAX */
        if not(missing(_nsumfpos[7])) then do;
            _rc = inumaggr.last();
            keyw_aggr_num[_nsumfpos[7]] = _nvalue;
            /* Point iterator to null, to be able to clear table */
            _rc = inumaggr.next();
        end;
        /* RANGE */
        if not(missing(_nsumfpos[8])) then do;
            _rc = inumaggr.first();
            _temp1 = _nvalue;
            _rc = inumaggr.last();
            _temp2 = _nvalue;
            keyw_aggr_num[_nsumfpos[8]] = abs(_temp2 - _temp1);
            _rc = inumaggr.next();
        end;        
        /* PRODUCT */
        if not(missing(_nsumfpos[9])) then do;
            keyw_aggr_num[_nsumfpos[9]] = 1;
            do _rc = inumaggr.first() by 0 while (_rc = 0);
                keyw_aggr_num[_nsumfpos[9]] = keyw_aggr_num[_nsumfpos[9]] * _keycount * _nvalue;
                _rc = inumaggr.next();
            end;    
        end;
        /* PRODUCT DISTINCT */
        if not(missing(_nsumfpos[10])) then do;
            keyw_aggr_num[_nsumfpos[10]] = 1;
            do _rc = inumaggr.first() by 0 while (_rc = 0);
                keyw_aggr_num[_nsumfpos[10]] = keyw_aggr_num[_nsumfpos[10]] * _nvalue;
                _rc = inumaggr.next();
            end;    
        end;
        /* FREQUENCY def: relative freq of particular "by group" */
        /* This aggregation will give the same value for any chosen column. */
        /* It is a property of a given "by group" not a column */
        if not(missing(_nsumfpos[11])) then do;
            keyw_aggr_num[_nsumfpos[11]] =  hbygroup.NUM_ITEMS / _OBSTOTAL;
        end;
        /* ARITHMETIC AVERAGE excluding nulls */
        if cmiss(_nsumfpos[12], _nsumfpos[13]) < 2 then do;
            _avg = _sumall / (hbygroup.NUM_ITEMS - _cntnmiss);
            if not(missing(_nsumfpos[12])) then keyw_aggr_num[_nsumfpos[12]] = _avg;
        end;
        /* VARIANCE : E(X^2) - (E(X))^2 */
        if not(missing(_nsumfpos[13])) then do;
            do _rc = inumaggr.first() by 0 while (_rc = 0);
                _avgsq = sum(_avgsq, (_keycount * _nvalue)**2);
                _rc = inumaggr.next();
            end;
            keyw_aggr_num[_nsumfpos[13]] =  _avgsq - (_avg)**2;
        end;

        /* Flush */
        numaggr.clear();
    end;
%end;

%if &aggr_chr_exist or &aggr_chr2num_exist %then %do;
    /* Traverse all character columns from hbygroup */
    _cntnmiss = 0;
    do _n_ = 1 to _len_chr;

        /* Do all below only if you find 'vname(allnum[_n_])_*' in keyw_aggr_num[], i.e. map_aggr table'  */
        call missing (of _csumfpos[*]);
        if not map_aggr.find(key: cats(upcase(vname(allchr[_n_])), '_NMISS')) then _csumfpos[1]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allchr[_n_])), '_CNTD'))  then _csumfpos[2]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allchr[_n_])), '_CNT'))   then _csumfpos[3]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allchr[_n_])), '_FIRST')) then _csumfpos[4]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allchr[_n_])), '_LAST'))  then _csumfpos[5]  = _varpos;
        if not map_aggr.find(key: cats(upcase(vname(allchr[_n_])), '_FREQ'))  then _csumfpos[6]  = _varpos;

        if cmiss(of _csumfpos[*]) = _len_csumf then continue;

        /* Traverse all hbygroup data */
        do  _rc = ihbygroup.first() by 0 while (_rc = 0);
            _cvalormd5 = allchr[_n_];
            if missing(_cvalormd5) & (cmiss(_csumfpos[1], _csumfpos[3]) < 2) then
                _cntnmiss = sum(_cntnmiss, 1);
            else
                /*  SAS ISSUE: ref()/check() methods are NOT incrementing key summary as documented. 
                    At this moment only find() method is. When issue gets solved one  simple ref() call 
                    will be enough */
                /* charaggr.ref(); */ 
                if charaggr.find() then do; _keycount=1; charaggr.add(); end;
            _rc = ihbygroup.next();
        end;

        /* Calculate summary functions */
        %if &aggr_chr2num_exist %then %do;
            /* NMISS */
            if not(missing(_csumfpos[1])) then do;
                keyw_aggr_chr2num[_csumfpos[1]] = _cntnmiss;
            end;
            /* COUNT DISTINCT not nulls */
            if not(missing(_csumfpos[2])) then do;
                keyw_aggr_chr2num[_csumfpos[2]] = charaggr.NUM_ITEMS;
            end;
            /* COUNT ALL not nulls */
            if not(missing(_csumfpos[3])) then do;
                keyw_aggr_chr2num[_csumfpos[3]] = hbygroup.NUM_ITEMS - _cntnmiss;
            end;
            /* FREQUENCY */         
            if not(missing(_csumfpos[6])) then do;
                keyw_aggr_chr2num[_csumfpos[6]] =  hbygroup.NUM_ITEMS / _OBSTOTAL;
            end;
        %end;
        %if &aggr_chr_exist %then %do;
            /* FIRST element in ascending charaggr table order */
            if not(missing(_csumfpos[4])) then do;
                _rc = icharaggr.first();
                keyw_aggr_chr[_csumfpos[4]] = _cvalormd5;
                _rc = icharaggr.prev();
            end;
            /* LAST element in ascending charaggr table order */
            if not(missing(_csumfpos[5])) then do;
                _rc = icharaggr.last();
                keyw_aggr_chr[_csumfpos[5]] = _cvalormd5;
                _rc = icharaggr.next();
            end;        
        %end;

        /* Flush */
        charaggr.clear();
    end;
%end;
%end;

%if %symlocal(aggr) and %symlocal(having) and not %symlocal(opt_join) %then %do;
    /* HAVING CLAUSE IMPLEMENTATION */
    /* Having clause demands 2nd pass through by group */
    /* This can be achieved either with another DOW loop that opens second pointer */
    /* to the same data set, which means two reads, or much faster, with */
    /* 2nd iteration through hbygroup, since by group is already in a hash table. */
    do _rc = ihbygroup.first() by 0 while (_rc = 0);
        if %unquote(&having) then output &out_dsn;
        _rc = ihbygroup.next();
    end;
%end;

/* JOIN IMPLEMENTATION : BEGIN */
%if %symlocal(opt_join) %then %do;
/* Join code is enclosed in one more outer loop if HAVING clause is present  */
%if %symlocal(aggr) and %symlocal(having) %then %do;
    do _rc = ihbygroup.first() by 0 while (_rc = 0);
        if %unquote(&having) then do;
%end;

    %local joinblock joinblock_upper joinblock_lower joinblock_middle and_expr;
    %let joinblock_upper =;
    %let joinblock_lower =;
    %let and_expr =;
    /* INNER JOIN - NEW IMPLEMENTAION */
     %if %scan(&opt_join, 1, _) = INNER %then %do;
        %if %scan(&opt_join, 3, _) = REJ 
            %then %let joinblock_middle = %str(if _rjind = 1 then _rjind = 0; output &out_dsn; );
            %else %let joinblock_middle = %str(output &out_dsn; );
        /* Build nested part of statement string */
        %do cnt = 1 %to &smccount;
            %if &&multi&cnt
                %then %let joinblock_upper = &joinblock_upper.%str(do while (not(lookup&cnt..do_over(&&find&cnt))); );
                %else %let joinblock_upper = &joinblock_upper.%str(if not(lookup&cnt..find(&&find&cnt)) then do; );        
            %let           joinblock_lower = &joinblock_lower.%str(end; );
        %end;    
        /* Concatenate statement parts */
        %let joinblock = &joinblock_upper.&joinblock_middle.&joinblock_lower;
        /* Print statement block */
        %unquote(&joinblock);
        %if %scan(&opt_join, 3, _) = REJ %then %do;
            /* Main table rejects */
            %do cnt = 1 %to &smccount;
                call missing(&&data_list&cnt);
            %end;
                if _rjind then output &out_dsn._rej;
        %end;
     %end;
    /* INNER JOIN - NEW IMPLEMENTAION */

    /* LEFT JOIN - NEW IMPLEMENTAION */
    %if %scan(&opt_join, 1, _) = LEFT %then %do;
        %if %scan(&opt_join, 3, _) = REJ 
            %then %let joinblock_middle = %str(_rjind+1; output &out_dsn; );
            %else %let joinblock_middle = %str(output &out_dsn; );
        %do cnt = 1 %to &smccount;
            %let and_expr = &and_expr.%str( & _rc&cnt );
            call missing(&&data_list&cnt);
            %if not(&&multi&cnt) %then %do;
                /* Only multidata OFF lookups */
                _rc&cnt = lookup&cnt..find(&&find&cnt);
            %end;
            %else %do;
                /* Only multidata ON lookups */
                %let joinblock_upper = &joinblock_upper.%str(_rc&cnt = lookup&cnt..find(&&find&cnt); do until(lookup&cnt..do_over(&&find&cnt)); );
                %let joinblock_lower = &joinblock_lower.%str(end; );
            %end;
        %end;
        /* Concatenate statement parts */
        %let joinblock = &joinblock_upper.&joinblock_middle.&joinblock_lower;
        /* Print statement block */
        %unquote(&joinblock);
        %if %scan(&opt_join, 3, _) = REJ %then %do;
            if _rjind <= 2 &and_expr then output &out_dsn._rej; 
        %end;
    %end;
    /* LEFT JOIN - NEW IMPLEMENTAION */

/* Join code is enclosed in one more outer loop if having clause is present  */
%if %symlocal(aggr) and %symlocal(having) %then %do;
        end;
        _rc = ihbygroup.next();
    end;
%end;

    /* LOOKUPS REJECTS */
    %if %scan(&opt_join, 3, _) = REJ %then %do;
        %do cnt = 1 %to &smccount;
            if EOF then lookup&cnt..output(dataset: "&&out&cnt (where=(_keycount = 0))");
        %end;
    %end;
    /* JOIN IMPLEMENTATION : END */
%end;

%if %symlocal(aggr) %then %do;
     /* Point iterator to null to release */
    _rc = ihbygroup.last();
    _rc = ihbygroup.next();
    /* Flush BY group */
    hbygroup.clear();
%end;

run;
    /*  *****+++++++**********************
        MAIN DATA STEP INJECTION : END
    ****++++++++********************** */
    %* ;

    /* DEBUG */
    %put _local_;
%mend;
