CONNECT TO COMP421 USER "cs421g02" USING "uPy90#Bh4";
export to 'query1_output.csv'
of del
select E.emp_id, E.name, count(case
                                   when current_date - date(M.start_time) < 30  then 1
    end) as number_of_meetings
from EMPLOYEE E
         inner join ATTENDS A on E.emp_id = A.emp_id
         inner join MEETING M on M.meeting_id = A.meeting_id
group by E.emp_id, E.name
having count(case
                 when current_date - date(M.start_time) < 30 then 1
    end) < 5
union
(select E.emp_id, E.name, 0 as number_of_meetings
 from EMPLOYEE E
     minus
 select E.emp_id, E.name, 0 as number_of_meetings
 from EMPLOYEE E
     inner join ATTENDS A on E.emp_id = A.emp_id
     inner join MEETING M on M.meeting_id = A.meeting_id)
order by number_of_meetings desc;
connect reset;