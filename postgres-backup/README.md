# postgres-backup
k8s cronjob to backup postgresql to s3.

# Contents
```
┣ postgres-backup
┣ bot-backtest-backup/
┣ quant-staging-backup/
┣ Dockerfile
┣ skaffold.yaml
┣ README.md


```

**Requirements**
```
1. Build and push psql-backup-image
```
skaffold run -d hk-prem-docker-registry:32000

```

Inside xxx-backup folder

2. encode database password by base64:

    echo 'hostname:port:database:username:password' | base64

paste to secret
```

```
3. edit cronjobname, database info and s3 path in postgresql-backup-cron-job.yaml
```


### Deploy
```
skaffold run

```
if you want the job start immediately

```
kubectl create job --from=cronjob/postgresql-backup-cron-job postgresql-backup-cron-job

```

### Restore DB
```
pg_restore -Fc -j 8 -h $DBHOST -U $DBUSER -d DBNAME -v backup-$date.dump
```
