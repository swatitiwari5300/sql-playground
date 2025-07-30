create or replace function audit_log()
returns trigger as $$
begin
	insert into audit(tableName, transactionname, username, transactiondate)
	values(TG_TABLE_NAME, TG_OP, current_user, current_date);
end;
$$ LANGUAGE plpgsql;

create trigger employee_update
after update on employees
for each row
execute function audit_log();

insert into employees(id, name, age, address)
values (233, 'swati', 22, '234 GM road')
