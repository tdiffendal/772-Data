#Theresa Diffendal, session 17 in-classlkp_clt_tway_route
 
SET SQL_MODE='only_full_group_by';

select * from fars.accident;		#crash info, environmental conditions; one record/crash
select * from fars.cevent; 		#events of crash in chronology, vehicles involved, one record/event
select * from fars.distract;		#driver distractions, one record/distraction
select * from fars.drimpair;		#driver physical impairments, one record/impairment
select * from fars.factor;			#vehicle circumstances which maybe impacted crash, one record/factor
select * from fars.maneuver;	#actions taken by driver to avoid, one record/maneuver
select * from fars.nmcrash;		#improper actions of people not in cars, one record/action
select * from fars.nmimpair;	#psychical impairments of non-motor vehicle people, one record/impairment
select * from fars.nmprior;		#actions of non-mv occupants at time of crash, one record/action
select * from fars.parkwork;	#info about parked or working vehicles involved in crash, one record/vehicle
select * from fars.pbtype;		#crash information for vehicle-peds situations, one record/pedestrian
select * from fars.person;		#describes all persons involved in crash, both drivers and peds; one record/person
select * from fars.safetyeq;		#safety equipment used by non-vehicle ppl, one record/equipment item
select * from fars.vehicle;		#describes vehicle and driver of vehicle in crash, one record/vehicle
select * from fars.vevent;		#sequence events for each separate vehicle involved in crash, one record/event/vehicle
select * from fars.violatn;			#violations charged to drivers, one record/violation
select * from fars.vision;			#vision obscuring circumstances, one record/obstruction
select * from fars.vsoe;			#simplified vevent data file

#Possible values to join on: idno, st_case_year, state, st_case

#Lookup tables
select *
from fars.lkp_day_of_week;

select *
from fars.lkp_state;

#what's the most impacted part of the other vehicle/object in accidents
#majority of events were non-harmful or did not involved a motor vehicle (codes 55 and 77); otherwise, code 12 has the highest count, which makes sense as codes 1-12 are clock points and 12 is head-on; likewise, code 6 has the fourth highest count, indicating rear-ends
select count(*)
from fars.cevent
group by AOI2;

#what are some of the big causes of vehicle-pedestrian accidents?
#Crosswalks? Unsurprisingly, when no crosswalk was noted the majority of incidents occured (407 compared to 94 yes, 7 unknowns)
select pbcwalk, count(*)
from fars.pbtype
group by pbcwalk;

#what kinds of people don't use a crosswalk? what were they doing?
#Majority of ped prior actions are null, followed by doing nothing improper, followed by a tie for failure to yield right-of-way and not visible
select nm.mtm_crsh, count(*)
from fars.pbtype pb join fars.nmcrash nm on pb.st_case=nm.st_case
where pb.pbcwalk = "1"
group by nm.mtm_crsh;

#is not visible skew racially? doesn't seem to
select p.race, count(*)
from fars.person p join fars.nmcrash nm on p.st_case=nm.st_case
where nm.mtm_crsh = 19
and (p.per_typ != 1 or p.per_typ != 2 or p.per_typ != 3 or p.per_typ != 4 or p.per_typ != 9)
group by p.race;

#are people with prior convictions more likely to be involved in accidents?