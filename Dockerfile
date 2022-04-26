FROM python:3.9-slim

RUN pip install \
    mlflow \
    psycopg2-binary \
    boto3

CMD mlflow server \
  --backend-store-uri ${BACKEND_URI} \
  --default-artifact-root ${ARTIFACT_URI} \
  --host 0.0.0.0