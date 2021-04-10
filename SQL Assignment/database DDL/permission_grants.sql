-- Test
select * from lkpeter.beer;

-- Tables1
grant select on drivers to lkpeter;
grant insert on drivers to lkpeter;
grant update on drivers to lkpeter;
grant delete on drivers to lkpeter;

grant select on constructors to lkpeter;
grant insert on constructors to lkpeter;
grant update on constructors to lkpeter;
grant delete on constructors to lkpeter;

grant select on laps to lkpeter;
grant insert on laps to lkpeter;
grant update on laps to lkpeter;
grant delete on laps to lkpeter;

grant select on races to lkpeter;
grant insert on races to lkpeter;
grant update on races to lkpeter;
grant delete on races to lkpeter;

grant select on drivers_log to lkpeter;
grant insert on drivers_log to lkpeter;
grant update on drivers_log to lkpeter;
grant delete on drivers_log to lkpeter;

grant select on results to lkpeter;
grant insert on results to lkpeter;
grant update on results to lkpeter;
grant delete on results to lkpeter;

-- Views

grant select on FASTEST_LAPS_OF_CONSTRUCTORS_WITH_PILOTS to lkpeter;
grant insert on FASTEST_LAPS_OF_CONSTRUCTORS_WITH_PILOTS to lkpeter;
grant update on FASTEST_LAPS_OF_CONSTRUCTORS_WITH_PILOTS to lkpeter;
grant delete on FASTEST_LAPS_OF_CONSTRUCTORS_WITH_PILOTS to lkpeter;

grant select on ITALIAN_DRIVERS to lkpeter;
grant insert on ITALIAN_DRIVERS to lkpeter;
grant update on ITALIAN_DRIVERS to lkpeter;
grant delete on ITALIAN_DRIVERS to lkpeter;

grant select on POL_POSITION_DRIVERS_ON_HUNGARORING to lkpeter;
grant insert on POL_POSITION_DRIVERS_ON_HUNGARORING to lkpeter;
grant update on POL_POSITION_DRIVERS_ON_HUNGARORING to lkpeter;
grant delete on POL_POSITION_DRIVERS_ON_HUNGARORING to lkpeter;

-- Procedure & Function
grant execute on GENERATE_CODE to lkpeter;
grant execute on HUNGARORING_FILTER to lkpeter;
