create or replace procedure add_seq_tgr_on_pks
IS
    CURSOR all_seq IS
        select * from user_sequences;
        
        
    CURSOR all_pks IS
            select cols.table_name as tname ,  cols.column_name as cname  , c.data_type  from user_constraints const
            join user_cons_columns cols on cols.constraint_name = CONST.CONSTRAINT_NAME 
                                                        and cols.table_name = const.table_name
                                                        and CONST.CONSTRAINT_TYPE = 'P' 
            join user_tab_cols c on c.table_name = cols.table_name and c.column_name = cols.column_name
           where cols.table_name not in (select table_name from user_cons_columns where position > 1);             
                  
   v_start_with number;
   v_inc_by number;
   v_char_value varchar2(50) ;
Begin
    
    -- To delete all the sequences of the user
    FOR seq IN all_seq LOOP
        execute immediate 'drop sequence ' || seq.sequence_name ;
    END LOOP;



    -- To loop on all columns that are primary keys in all user tables
    
    FOR pk_row IN all_pks LOOP
    
    
    
        IF pk_row.data_type = 'NUMBER' THEN
            
            -- Store the values of the sequence
            v_start_with := return_max(pk_row.tname, pk_row.cname) + get_seq_order(pk_row.tname, pk_row.cname) ;
            v_inc_by := get_seq_order(pk_row.tname, pk_row.cname) ;
                        
           -- Create the sequence 
            execute immediate 'create sequence ' || pk_row.tname || '_seq
                start with ' ||  v_start_with  ||
                ' increment by ' || v_inc_by ;
            
            -- Create the trigger using the created sequence
            execute immediate ' create or replace trigger ' || pk_row.tname || '_trigger' ||
            ' before insert on ' || pk_row.tname ||
            ' for each row
              Begin
             :new.' || pk_row.cname || ' := ' || pk_row.tname || '_seq.nextval ;
              end ;' ;
          
        ELSE              
                
            -- Create the sequence 
            execute immediate 'create sequence ' || pk_row.tname || '_seq
                start with 1
                 increment by 1'  ;
        
        
      
            -- Create the trigger using the created sequence
            
            execute immediate ' create or replace trigger ' || pk_row.tname || '_trigger' ||
            ' before insert on ' || pk_row.tname ||
            ' for each row
              Begin
             :new.' || pk_row.cname || ' := '   || pk_row.tname || '_seq.nextval     ; end ; '  ;
            
        END IF;
    
    END LOOP; 
    
End;
show errors
