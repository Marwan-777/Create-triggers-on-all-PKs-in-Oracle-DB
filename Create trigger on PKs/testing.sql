

Begin
add_seq_tgr_on_pks();
End;

insert into departments(department_name)
values('testing dept');

delete from departments
where department_name = 'testing dept' ;

insert into jobs(job_title)
values('Data analyst');

delete from jobs
where job_title ='Data analyst';

insert into locations(city)
values('cairo');

delete locations
where city = 'cairo';

insert into employees(last_name, email, hire_date, job_id)
values('marwan','rvwan@email.com',sysdate,'AD_PRES');

delete employees 
where last_name = 'marwan';