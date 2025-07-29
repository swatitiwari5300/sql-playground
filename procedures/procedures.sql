
create or replace procedure employee_details (name varchar, id int) language plpgsql
as $$
begin
	raise notice 'id: %, name: %', id, name;
end;
$$;

CALL employee_details('swati', 1);

-- inserting into table using stored procedures

create or replace procedure insert_emp (name varchar, id int) language plpgsql
as $$
begin
	insert into employees(id, name) values (id, name);
end;
$$;

CALL insert_emp('swati', 100);

-- out parameter example in plsql stored procedure
create or replace procedure max_val (x int, y int, z out int) language plpgsql
as $$
begin
	if(x > y) then
		z := x;
	else
		z := y;
	end if;
end;
$$;

do $$
declare
	z integer;
begin
	CALL max_val(10, 20, z);
	raise notice 'max value: %', z;
end;
$$;

-- INOUT parameter in stored procedure

create or replace procedure square (x in out int) language plpgsql
as $$
begin
	x := x * x;
end;
$$;

do $$
declare
	z integer := 10;
begin
	CALL square(z);
	raise notice 'square value: %', z;
end;
$$;
