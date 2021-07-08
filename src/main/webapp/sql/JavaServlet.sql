
--  Creacion de tablas -- 

--  se crea la tabla matchs-- 

create table if not exists matchs( id integer, event_id integer, date varchar(100), team_1 varchar(100),team_2 varchar(100),winner varchar(100));

--  tabla creada, ahora se inserta los datos de la tabla results-- 

insert into matchs (select distinct match_id, event_id,date,team_1,team_2,match_winner from results order by match_id);

--  se crea la tabla events

create table if not exists events ( id integer, name varchar(255));

--  tabla creada, ahora se inserta los datos desde la tabla players-- 

insert into events ( select distinct event_id,event_name  from players);

delete from matchs where event_id not in (select id from events);

delete from results where match_id not in (select id from matchs);

delete from players where match_id not in (select id from matchs);


-- Alteracion tablas preexistentes -- 

start TRANSACTION;
alter table players drop column if exists best_of;
COMMIT;
start TRANSACTION;
alter table players drop column if exists map_1;
COMMIT;
start TRANSACTION;
alter table players drop column if exists map_2;
COMMIT;
start TRANSACTION;
alter table players drop column if exists map_3;
COMMIT;
start TRANSACTION;
alter table players drop column if exists event_id;
COMMIT;
start TRANSACTION;
alter table players drop column if exists event_name;
COMMIT;
start TRANSACTION;
alter table players drop column if exists date;
COMMIT;

start TRANSACTION;
alter table results drop column if exists starting_ct;
COMMIT;
start TRANSACTION;
alter table results drop column if exists ct_1;
COMMIT;
start TRANSACTION;
alter table results drop column if exists t_2;
COMMIT;
start TRANSACTION;
alter table results drop column if exists t_1;
COMMIT;
start TRANSACTION;
alter table results drop column if exists ct_2;
COMMIT;
start TRANSACTION;
alter table results drop column if exists event_id;
COMMIT;
start TRANSACTION;
alter table results drop column if exists date;
COMMIT;


--  Constraints -- 

-- matchs -- 
alter table matchs
add constraint match_event_id foreign key (event_id) references events(id);

alter table matchs
add constraint match_pk primary key (id);

-- events -- 
alter table events
add constraint event_pk primary key (id);

-- players -- 
alter table players
add constraint player_match_id foreign key (match_id) references matchs(id);

alter table players
add constraint players_pk primary key(id);

-- results -- 
alter table results
add constraint result_match_id foreign key (match_id) references matchs(id);

alter table results
add constraint results_pk primary key(id);


-- Indices -- 

CREATE INDEX abraham ON players(player_name) USING HASH

-- Vistas -- 

-- Crea una vista que indica el nombre de jugador
-- su equipo, equipo contra el que juega
-- y ganador

create view PlayerTeamMatches as
  select p.player_name, m.team_1 as PWteam, m.team_2
  from matchs m, players p
  where m.id = p.match_id
  and m.winner = '1'
  and m.team_1 = p.team
  union
  select p.player_name, m.team_2 as PWteam, m.team_1
  from matchs m, players p
  where m.id = p.match_id
  and m.winner = '2'
  and m.team_2 = p.team

-- Vista que tiene AdvancedStats de un jugador en los equipos que ha jugado

CREATE VIEW PlayerAdvancedStats as
  SELECT player_name,team,FLOOR(AVG(kills)) AS mean_kills,
  FLOOR(AVG(assists)) AS mean_assist,
  FLOOR(AVG(deaths)) AS mean_deaths,
  FLOOR(AVG(hs)) AS mean_headshots,
  ROUND(cast(SUM(kills)+SUM(assists) as decimal)/SUM(deaths),3) as kdaJugador
  FROM players
  GROUP BY player_name,team;