create table thesaurus(
    id serial primary key,
    entity_id int not null,
    entity_type text not null,
    name text not null,
    note text,
    unique (entity_id, entity_type)
);

alter table thesaurus owner to kinohod;

create table platforms(
    uuid uuid not null default uuid_generate_v4() primary key,
    name text not null unique,
    type int not null,
    is_active boolean not null default false
);

alter table platforms owner to kinohod;

create table events(
    uuid uuid not null default uuid_generate_v4() primary key,
    platform_uuid uuid not null references platforms(uuid) on delete restrict,
    name text not null,
    ts_created timestamp without time zone not null default now()::timestamp without time zone,
    ts_start timestamp without time zone not null,
    duration int not null,
    ticket_price numeric not null,
    is_active boolean default false
);

alter table events owner to kinohod;

create table orders(
    uuid uuid not null default uuid_generate_v4() primary key,
    status int not null,
    event_uuid uuid not null references events(uuid) on delete restrict,
    ticket_count int not null check( ticket_count > 1 and ticket_count < 7 ),
    ticket_price numeric not null,
    order_cost  numeric not null
);

alter table orders owner to kinohod;

create table users(
    uuid uuid not null default uuid_generate_v4() primary key,
    login text not null,
    pass text not null,
    salt text not null
);

alter table users owner to kinohod;

create table roles(
    uuid uuid not null default uuid_generate_v4() primary key,
    name text not null
);

alter table roles owner to kinohod;

create table user_roles(
    user_uuid uuid not null references users(uuid) on delete restrict,
    role_uuid uuid not null references roles(uuid) on delete restrict,
    primary key(user_uuid, role_uuid)
);

alter table user_roles owner to kinohod;


