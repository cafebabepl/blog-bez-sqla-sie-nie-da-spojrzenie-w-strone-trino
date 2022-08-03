# “Bez SQLa się nie da” - spojrzenie w stronę Trino

```shell
git clone https://github.com/cafebabepl/blog-bez-sqla-sie-nie-da-spojrzenie-w-strone-trino.git
cd blog-bez-sqla-sie-nie-da-spojrzenie-w-strone-trino
git checkout czesc-1
docker-compose -p blog up -d
```

```shell
wget -c https://archive.ics.uci.edu/ml/machine-learning-databases/00321/LD2011_2014.txt.zip
unzip LD2011_2014.txt.zip -x __* 
./import2.sh
tar -czvf LD2011_2014-T.tar.gz LD2011_2014-T.csv
```

```shell
env LC_ALL=en_US.UTF-8 printf "%'d\n" $(wc -l < LD2011_2014-T.csv)
```

```shell
docker ps
docker exec -it blog_cassandra_1 cqlsh -u cassandra -p cassandra
```

```shell
java -jar trino-cli-391-executable.jar --server http://localhost:8080
```

```shell
docker ps
docker exec -it blog_trino_1 trino 
```

```cassandraql
USE eld;
SELECT count(*) FROM value_by_client_id_time;

select time, value / 4 as kwh
from value_by_client_id_time 
where client_id = 'MT_017' 
  and time > '2012-07-28 00:00:00' and time <= '2012-07-29 00:00:00';


create or replace function year(input timestamp)
    returns null on null input
    returns int
    language java as
    '
        Calendar c = Calendar.getInstance();
        c.setTime(input);
        return c.get(Calendar.YEAR);
    ';

-- 2011
select sum(value / 4) from value_by_client_id_time
where client_id = 'MT_270'
  and time > '2011-01-01 00:00:00.000' and time <= '2012-01-01 00:00:00.000';
```

```sql
SELECT count(*) FROM value_by_client_id_time;

select
    try(year(time - interval '15' minute)) as rok,
    sum(value / 4) as zuzycie
from value_by_client_id_time
group by 1
order by 1;
```

```shell
cat /opt/bitnami/cassandra/conf/cassandra.yaml | grep -P '^(?!#).*timeout'
```
