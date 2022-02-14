create database TravelOnTheGo;
use TravelOnTheGo;

create table PASSENGER (
Passenger_name varchar(50), 
Category varchar(50), 
Gender varchar(1), 
Boarding_City varchar(50),
Destination_City varchar(50),
Distance int,
Bus_Type varchar(20)
);

create table PRICE (
Bus_Type varchar(20),
 Distance int,
 Price int);

insert into passenger
(passenger_name,category,gender,boarding_city,destination_city,distance,bus_type)
values
('sejal','ac','f','bengaluru','chennai',350,'sleeper'),
('anmol','non-ac','m','mumbai','hyderabad',700,'sitting'),
('pallavi','ac','f','panaji','bengaluru',600,'sleeper'),
('khusboo','ac','f','chennai','mumbai',1500,'sleeper'),
('udit','non-ac','m','trivandrum','panaji',1000,'sleeper'),
('ankur','ac','m','nagpur','hyderabad',500,'sitting'),
('hemant','non-ac','m','panaji','mumbai',700,'sleeper'),
('manish','non-ac','m','hyderabad','bengaluru',500,'sitting'),
('piyush','ac','m','pune','nagpur',700,'sitting');


insert into price
(Bus_Type,Distance,Price)
values
('Sleeper',350,770),
('Sleeper',500,1100),
('Sleeper',600,1320),
('Sleeper',700,1540),
('Sleeper',1000,2200),
('Sleeper',1200,2640),
('Sleeper',1500,2700),
('Sitting',500,620),
('Sitting',600,744),
('Sitting',700,868),
('Sitting',1000,1240),
('Sitting',1200,1488),
('Sitting',1500,1860);

/* Qun 3 --- Passengers travelled for a minimum distance of 600 KM s*/
select gender as Gender,count(Gender) as COUNT from passenger where distance>=600 group by gender;

/*Qun 4--- minimum ticket price for Sleeper Bus*/
select bus_type as BUS_TYPE,min(price) as MIN_TKT_PRICE from price where Bus_Type="sleeper";

/*Qun 5--- passenger names whose names start with character 'S'*/
select * from passenger where passenger_name like "s%";

/*Qun 6 ---Calculate price charged for each passenger*/
select ps.passenger_name,ps.boarding_city,ps.destination_city,ps.distance,ps.bus_type,pc.price
from passenger ps
inner join price pc 
on ps.bus_type=pc.bus_type
and ps.distance=pc.distance;

/*Qun 7---Passenger ticket price who travelled in the Sitting bus for a distance of 1000 KM s*/
select ps.passenger_name,pc.price
from passenger ps, price pc 
where ps.bus_type=pc.bus_type 
and ps.distance=pc.distance
and ps.bus_type="sitting" and ps.distance=1000;

/*Qun 8---Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji*/
select ps.passenger_name,ps.destination_city as Boarding_City,ps.boarding_city as Destination_city,pc.bus_type,pc.price
from price pc , passenger ps
where ps.distance=pc.distance
and ps.passenger_name="Pallavi";

/*Qun 9--List the distances from the "Passenger" table which are unique (*/
select distinct(distance) from passenger order by distance desc;

/*Qun 10---Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers*/
select passenger_name,
distance * 100 / (select count(distance) from passenger)  AS percentage
from passenger
group by passenger_name;

/*Qun 11---Display the distance, price in three categories in table Price*/
select distance,price,
CASE
	when price >1000 then "Expensive"
	when price <1000 or price>500 then "Average Cost"
	else "Cheap"
end as Type
from price;
