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


## Future plans

* Proper production deployment using gunicorn.
* OpenShift deployment.
