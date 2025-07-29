
create or replace procedure employee_details (name varchar, id int) language plpgsql
as $$
begin
	raise notice 'id: %, name: %', id, name;
end;
$$;

CALL employee_details('swati', 1);

