-- This function return the maximum value of the NUMBER primary key

create or replace function return_max(p_table varchar2,p_column varchar2 )
return number
IS
v_num number := 0;
Begin
    execute immediate 'select max(' || p_column || ') from ' || p_table into v_num ;
    return v_num;
End;
show errors



