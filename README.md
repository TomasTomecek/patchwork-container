# Patchwork in a container

This is a containerized version of [patchwork](https://github.com/getpatchwork/patchwork).


## State

First prototype built. Unsuitable for production. Suggestions are welcome.


## Requirements

* Docker engine is running.
* Ansible is installed.


## Usage

```
$ make run
```

```
$ xdg-open http://0.0.0.0:8000
```


## More info

The deployment utilizes Ansible playbook to deploy patchwork:

1. The container image is created from the supplied Dockerfile.
   * This is done using Ansible module `docker_image`.
2. postgresql is used as a database, namely `centos/postgresql-96-centos7`


### Loading custom data into postgres

There are multiple ways of doing this: ideally, the playbook would support this
(which it does not right now).

In the meantime, you can create an interactive shell in the postgres container,
copy the file with sql commands in the data dir and execute from within the
container:

```console
$ sudo printf "SELECT 1;\n" >./db_data/load.sql

$ docker exec -ti patchwork-db bash

bash-4.2$ cat /var/lib/pgsql/data/load.sql | psql
 ?column?
----------
        1
(1 row)
```

You can also run `psql` interactively and check on the database:

```
bash-4.2$ psql
psql (9.6.5)
Type "help" for help.

postgres=# \c patchwork
You are now connected to database "patchwork" as user "postgres".
patchwork=# \dt
                           List of relations
 Schema |                   Name                    | Type  |   Owner
--------+-------------------------------------------+-------+-----------
 public | auth_group                                | table | patchwork
 public | auth_group_permissions                    | table | patchwork
 public | auth_permission                           | table | patchwork
 public | auth_user                                 | table | patchwork
 public | auth_user_groups                          | table | patchwork
 public | auth_user_user_permissions                | table | patchwork
 public | authtoken_token                           | table | patchwork
 public | django_admin_log                          | table | patchwork
 public | django_content_type                       | table | patchwork
 public | django_migrations                         | table | patchwork
 public | django_session                            | table | patchwork
 public | django_site                               | table | patchwork
 public | patchwork_bundle                          | table | patchwork
 public | patchwork_bundlepatch                     | table | patchwork
 public | patchwork_check                           | table | patchwork
 public | patchwork_comment                         | table | patchwork
 public | patchwork_coverletter                     | table | patchwork
 public | patchwork_delegationrule                  | table | patchwork
 public | patchwork_emailconfirmation               | table | patchwork
 public | patchwork_emailoptout                     | table | patchwork
 public | patchwork_event                           | table | patchwork
 public | patchwork_patch                           | table | patchwork
 public | patchwork_patchchangenotification         | table | patchwork
 public | patchwork_patchtag                        | table | patchwork
 public | patchwork_person                          | table | patchwork
 public | patchwork_project                         | table | patchwork
 public | patchwork_series                          | table | patchwork
 public | patchwork_seriespatch                     | table | patchwork
 public | patchwork_seriesreference                 | table | patchwork
 public | patchwork_state                           | table | patchwork
 public | patchwork_submission                      | table | patchwork
 public | patchwork_tag                             | table | patchwork
 public | patchwork_userprofile                     | table | patchwork
 public | patchwork_userprofile_maintainer_projects | table | patchwork
(34 rows)
```


## Future plans

* Proper production deployment using gunicorn.
* OpenShift deployment.
