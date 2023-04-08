-- This function return the sequence order of the NUMBER primary key
-- IF there is only one row in a table it will set the sequence order to one

create or replace function get_seq_order(p_table varchar2 , p_column varchar2)
return number
IS
v_first number;
v_second number;
v_result number;
Begin

    execute immediate 'select max(' || p_column || ') from ' || p_table into v_first ;
    
    execute immediate 'select min(' || p_column || ') from 
    ( select ' || p_column || ' from ' || p_table ||
    ' where rownum <= 2
    order by ' || p_column || ' desc
    )'
    into v_second ;
    
    v_result := v_first - v_second;
    
    IF v_result = 0 THEN
        return 1;
    ELSE
        return v_result;
    END IF;
End;
show errors 





