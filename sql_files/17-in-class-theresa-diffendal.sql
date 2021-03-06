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

#does not visible skew racially? doesn't seem to
select p.race, count(*)
from fars.person p join fars.nmcrash nm on p.st_case=nm.st_case
where nm.mtm_crsh = 19
and (p.per_typ != 1 or p.per_typ != 2 or p.per_typ != 3 or p.per_typ != 4 or p.per_typ != 9)
group by p.race;

#in what type of intersection did crashes happen most frequently?
#of the intersections, the most crashes were cateloged in four-way intersections. I wonder if this is impacted by the frequency of each type of intersection or is mainly due to the design.
select typ_int, count(*)
from fars.accident
group by typ_int;

#was a crash more likely to happen on the road, the side of/close to the road or elsewhere?
#on road had greatest amount, more than double the second highest "near road"
#great to see that not reported (8) and unknown (99) are low, hopefully making this reliable data from which to draw a conclusion
select if(rel_road = 1, "on road", if(rel_road = 2 or rel_road = 3 or rel_road = 4, "near road", rel_road)) as relation, count(*)
from fars.accident
group by relation;

/* https://www.nbcmiami.com/news/local/Florida-Is-The-Deadliest-State-for-Pedestrians-Study-Says-504758081.html
This story detailed a study which made use of the FARS database to calculate a "pedestrian danger index" and concluded Florida is the least safe state for pedestrians. Possibly used something like below, might have filtered pbtype.pedctype*/
select state, count(*)
from fars.accident 
where peds > 0
group by state
order by state asc;

/*https://www.thenewspaper.com/news/52/5250.asp
article that used FARS to prove an NHTSA document wrong about speeding in fatal collisions, as NHTSA included speeding as when speed.rel > 0, as opposed to just exceeded speed limit (speed.rel = 3). For comparison, just "yes" had 593 incidents compared to 363 where speeding was listed as the cause. That significantly shifts the percentage.
Yes, exceeded speed limit had 363 incidents compared to 4622 where speeding did not play a role, which, as the article says, is only about 8 percent, not the 24 percent figure NHTSA wrote. */

select speedrel, count(*)
from fars.vehicle
group by speedrel;
