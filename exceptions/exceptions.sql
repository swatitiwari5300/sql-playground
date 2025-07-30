-- exception hadling for too many rows
too_many_rowsdo $$
declare 
 v_name employees.name%type;
begin
	select name into strict v_name from employees where id > 2;
	raise notice 'name: %', v_name;
	exception 
	when too_many_rows then
		raise notice 'too_many_rows';
end;
$$;

-- handling more exceptions together

do $$
declare 
 v_name employees.name%type;
begin
	select name into strict v_name from employees where id = 11;
	raise notice 'name: %', v_name;
	exception 
	when too_many_rows then
		raise notice 'too_many_rows';
	when no_data_found then
		raise notice 'no data found';
end;
$$;