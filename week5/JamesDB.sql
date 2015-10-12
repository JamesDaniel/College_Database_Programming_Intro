set serveroutput on;

create or replace trigger dname_to_upper
Before insert or update of dname on dept
for each row
Declare
begin
:new.DNAME := upper(:new.DNAME);	
End;

DROP TRIGGER dname_to_upper;

create or replace trigger is_upper_case
Before insert or update of dname on dept
for each row
Declare
dname_l varchar2(15);
begin
dname_l := upper(:new.dname);	
if NOT (dname_l = :new.dname) then 		raise_application_error(-20240,'job not in capitals');	
end if;
--works to send a message
--to change value use a before trigger 
End;

CREATE OF REPLACE TRIGGER msg_for_dept_delete
BEFORE DELETE ON DEPT
FOR EACH ROW
DECLARE
BEGIN
dbms_output.put_line('DELETING:');
dbms_output.put_line(:OLD.DNAME );
dbms_output.put_line('DELETING:');
dbms_output.put_line(:OLD.LOC );
dbms_output.put_line('DELETING:');
dbms_output.put_line(:OLD.DEPTno );
END;

create or replace trigger msg_dept_location_change
BEFORE UPDATE of loc on dept
for each row
declare
l_loc varchar2(15);
begin
l_loc := :old.loc;
if not (l_loc = :new.loc) then
    raise_application_error(-20239,'new loc is not different');	
else
    :new.loc := upper(:new.loc);
    dbms_output.put_line('the location has been changed from '||:old.loc||' to '||:new.loc||' on '||sysdate);
end if;
end;