select distinct e.emp_id, e.name from
employee e, (select std.emp_id, sup.codename from
               standard std, supervisor sup
               where std.emp_id = sup.emp_id) newSup
where e.emp_id = newSup.emp_id