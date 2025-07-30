--- add 2 numbers using function

create or replace function add_numbers(a integer, b integer)
returns integer LANGUAGE plpgsql
as $$
Declare
	c integer;
begin
	c := a+b;
	return c;
end;
$$;

select add_numbers(10,20);

-- fetching count from the table using function
create or replace function total_count()
returns integer LANGUAGE plpgsql
as $$
Declare
	c integer;
begin
	select count(*) into c from employees;
	return c;
end;
$$;

do $$
declare 
	count_emp integer;
begin
count_emp := total_count();
raise notice 'count: %',count_emp;
end;
$$;

---------- sum of salry of few emp

create or replace function get_sum_sal(v_id integer)
returns integer LANGUAGE plpgsql
as $$
Declare
	c integer;
begin
	select sum(salary) into c from employees where id > v_id;
	return c;
end;
$$;

do $$
declare 
	count_emp integer;
begin
count_emp := get_sum_sal(5);
raise notice 'count: %',count_emp;
end;
$$;