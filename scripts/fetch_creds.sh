#!/bin/env bash

SECRET="$(aws secretsmanager get-secret-value \
    --secret-id "$REDSHIFT_CREDS_SECRET_ID" \
    --region "$AWS_REGION")"

export SECRET_REDSHIFT_USER=$(jq -r '.SecretString | fromjson.username' <<< "$SECRET")
export SECRET_REDSHIFT_PW=$(jq -r '.SecretString | fromjson.password' <<< "$SECRET")
