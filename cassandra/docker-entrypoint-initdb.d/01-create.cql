create keyspace eld with replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

create table eld.value_by_client_id_time
(
    client_id text,
    time      timestamp,
    value     double,
    primary key (client_id, time)
);

