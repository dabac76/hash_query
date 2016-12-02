/* TEST1: Aggregation with having clause, no joins. _clcvar_ will be automatically dropped */
%hquery(

    work.cars (     keep   = origin make type model drivetrain invoice horsepower mpg_city length
                    where  = (origin in ('Asia', 'USA')) 
                    rename = (mpg_city = consum_city))
        out         = work.test1 (drop = length drivetrain origin model horsepower mpg_city)
        by          = make type
        aggr        = invoice_cnt invoice_avg horsepower_max 
        having      = invoice > invoice_avg
        _clcvar_    = date()

);

/* TEST2: Simple join multiple lookups, no aggregation, without rejects output  */
%hquery(

    work.cars     (   keep   = origin make type model drivetrain invoice
                      where  = (origin = 'USA'))
        out         = work.test2(keep = origin make type 
                                        model invoice horsepower length)
        opt         = inner_join
    ;   
    work.carslkp1 (   keep = make type model horsepower 
                      where = (make = 'Buick'))
        key         = 'make', 'type', 'model'
        data        = all: "yes"
        find        = key: 'Buick', key: type, key: model
    ;
    work.carslkp2 (   keep = make type model length 
                      where = (make = 'Buick'))
        key         = 'make', 'type', 'model'
        data        = 'length'
        find        = key: make, key: type, key: model
);

/* TEST3: Multidata inner join with rejects, no aggregation. */
%hquery(

    work.cars ( keep   = origin make type model horsepower
                where  = (make in ('Buick', 'Cadillac')))
        out   = work.test3 (keep = origin make type model horsepower mpg_city)
        opt   = inner_join_rej
    ;   
    work.cars ( keep = make type model mpg_city 
                where = (make in ('Buick', 'Chevrolet')))
        key   = 'make', 'type'
        data  = all: "yes"
        find  = key: make, key: type
        out   = test3lkp1_rej
        opt   = multidata
    ;
    work.cars ( keep = make type model mpg_city 
                where = (make in ('Buick', 'Dodge')))
        key   = 'make', 'type'
        data  = all: "yes"
        find  = key: make, key: type
        out   = test3lkp2_rej
        opt   = multidata
);

/* TEST4: Multidata left join with rejects, no aggregation. */
%hquery(

    work.cars ( keep   = origin make type model horsepower
                where  = (make in ('Buick', 'Cadillac')))
        out   = work.test4 (keep = origin make type model horsepower mpg_city)
        opt   = left_join_rej
    ;   
    work.cars ( keep = make type model mpg_city 
                where = (make in ('Buick', 'Chevrolet')))
        key   = 'make', 'type'
        data  = 'make', 'type', 'model'
        find  = key: make, key: type
        out   = test4lkp_rej
        opt   = multidata
);

/* TEST5: Aggregation with having clause, simple join with reject, multiple lookups */
%hquery(

    work.cars     ( drop   = enginesize cylinders wheelbase weight drivetrain 
                    where  = (origin in ('Asia', 'USA')))
        out         = work.test5 (keep = make type model invoice horsepower length)
        by          = make type
        aggr        = invoice_avg
        having      = invoice > invoice_avg
        opt         = inner_join_rej
    ;   
    work.cars     ( keep  = origin make type model horsepower 
                    where = (origin in ('Europe', 'USA')))
        key         = 'make', 'type', 'model'
        data        = 'horsepower'
        find        = key: make, key: type, key: model
        out         = work.test5lkp1_rej
    ;
    work.cars     ( keep  = origin make type model length 
                    where = (origin in ('Asia', 'USA')))
        key         = 'make', 'type', 'model'
        data        = 'length'
        find        = key: make, key: type, key: model
        out         = work.test5lkp2_rej
);
