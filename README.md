# Mlflow server with postgres as backend store and minio as artifact store

Inspired by [this](https://github.com/bubulmet/mlflow-postgres-minio) repo.

## Deploy

- go to server where you want to deploy mlflow
- clone repository and move into it:
```sh
git clone git@github.com:antklen/mlflow-server.git
cd mlflow-server
```
- build docker image (only for the first time): `sh build_mlflow.sh`
- define environment variables with ports (could be any free ports, values here are just for example):
```sh
export MLFLOW_PORT=5000
export MINIO_API_PORT=9010
export MINIO_CONSOLE_PORT=9011
```
- run docker-compose: `docker-compose up`
- for the first time go to minio console `http://{host}:{MINIO_CONSOLE_PORT}` and create bucket with name `mlflow`

## Usage

For logging experiments in python:
```python
import os
import mlflow

os.environ['MLFLOW_S3_ENDPOINT_URL'] = 'http://{host}:{MINIO_API_PORT}'
os.environ['AWS_ACCESS_KEY_ID'] = 'mlflow'  # defined in docker-compose.yml
os.environ['AWS_SECRET_ACCESS_KEY'] = 'mlflow_pass'  # defined in docker-compose.yml

mlflow.set_tracking_uri('http://{host}:{MLFLOW_PORT}')
```

Go to `http://{host}:{MLFLOW_PORT}` to see mlflow UI.