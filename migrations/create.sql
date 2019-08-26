create user kinohod with password '123456';

create database kinohod
  with owner = kinohod
       encoding = 'UTF8'
       tablespace = pg_default
       lc_collate = 'en_US.UTF-8'
       lc_ctype = 'en_US.UTF-8'
       template template0
       connection limit = -1;
grant connect, temporary on database kinohod to public;

grant all on database kinohod to kinohod;

\connect kinohod;

create extension "uuid-ossp";
