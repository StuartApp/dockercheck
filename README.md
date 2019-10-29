# dockercheck - check and expose containers health

`dockercheck` will inspect all the running containers on the system, looking for containers labelled with `com.docker.compose.project` (default value, can be adjusted via an environment variable). It will then return the proper HTTP status on the `/health` endpoint.

### Prometheus client

At the same time, `dockercheck` exposes a Prometheus clients with the statuses of all the containers matching the label. It exports a single metric (controlled by `DOCKERCHECK_PROM_METRIC`) with two labels attached:

* container `name`
* container `role`

 using a different TCP port and on the `/` path. The metrics get updated everytime the `/health` endpoint is accessed (sorry, no dedicated updating thread atm `¯\_(ツ)_/¯`).

## Configuration parameters

The program is customizable via environment variables

|ENV VAR |Default value |Meaning|
|-|-|-|
|DOCKERCHECK_HTTP_PORT|8080|Port used for the healthcheck status|
|DOCKERCHECK_PROM_HTTP_PORT|9150|Port used for the Prometheus client|
|DOCKERCHECK_LABEL|"com.docker.compose.project"|Label used to filter containers. It can be just a label name or label=value|
|DOCKERCHECK_PROM_METRIC|"container_status"|The name of the metric exposed by the Prometheus client|

## Health calculation logic

![Diagram showing the health calculation logic](dockercheck-logic.png)
