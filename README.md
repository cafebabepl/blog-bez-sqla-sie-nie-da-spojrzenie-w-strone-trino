# “Bez SQLa się nie da” - spojrzenie w stronę Trino

```shell
git clone https://github.com/cafebabepl/blog-bez-sqla-sie-nie-da-spojrzenie-w-strone-trino.git
cd blog-bez-sqla-sie-nie-da-spojrzenie-w-strone-trino
git checkout czesc-2
docker-compose -p blog up -d
```

```shell
docker exec -it blog_mongodb_1 mongosh
```

```
db.clients.find({"id": "MT_001"}).pretty()
```

```shell
docker exec -it blog_trino_1 trino
```

```sql
select id, address.city, address.street from clients c where lower(address.city) like 'ponte de%';
```

```sql
select count(1) from cassandra.eld.value_by_client_id_time;
select round(sum(value / 4) / 1000000, 3) as GWh from cassandra.eld.value_by_client_id_time;
```

```sql
select
  c.segment,
  round(sum(v.value/4) / 1000000, 3) as GWh
from 
  cassandra.eld.value_by_client_id_time v, 
  mongodb.eld.clients c
where v.client_id = c.id
group by c.segment
order by 1;
```