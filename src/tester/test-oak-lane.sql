drop table if exists tmp_addresses cascade;
create temporary table tmp_addresses (id serial not null primary key, addr text);
insert into tmp_addresses (addr) values ('123 oak ln e n mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east n mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e north mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e n st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east n st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e north st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e n saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east n saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e north saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln new marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, n mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east, n mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, north mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e n, mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east n, mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e north, mycity ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, n st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east, n st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, north st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, n saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east, n saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, north saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east, st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane east, saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln e, saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln, st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane, st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln, st marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln, saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak lane, saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln, saint marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln, marie ny usa');
insert into tmp_addresses (addr) values ('123 oak ln, new marie ny usa');
insert into tmp_addresses (addr) values ('123 b & o railroad ln e n st marie ny usa');
insert into tmp_addresses (addr) values ('123 b & o railroad depot ln e n st marie ny usa');
insert into tmp_addresses (addr) values ('123 b & o railroad crossing ln e n st marie ny usa');
insert into tmp_addresses (addr) values ('123 b & o rail road ln e n st marie ny usa');
select id, addr, (as_standardize(addr, (select grammar from as_config where countrycode='us'), (select lexicon from as_config where countrycode='us'), 'en_US', (select filter from as_config where countrycode='us'))).* from tmp_addresses order by id;
