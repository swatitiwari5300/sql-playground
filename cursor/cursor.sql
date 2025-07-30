-- using cursor and attributes to update the age in the table

do $$
declare 
 rowCount integer;
begin
	update employees set age = age + 10;
	if found then
		GET DIAGNOSTICS rowCount := row_count;
	end if;
	raise notice 'rows affected: %', rowCount;
end;
$$;

---- explicit cursor implementation

do $$
declare 
 emp_cursor cursor for
 	select name, id from employees order by id desc; 
 v_name employees.name%type;
 v_id integer;
 row_count integer := 0;
begin
	open emp_cursor;
	loop
		fetch emp_cursor into v_name, v_id;
		exit when not found;
		
		row_count := row_count + 1;
		raise notice '%',row_count;
		raise notice 'name,: %, id, %', v_name, v_id;
	end loop;
	close emp_cursor;
end;
$$;