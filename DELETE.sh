#!/bin/bash
aws s3 rb s3://sinatra-jamesh --force
aws cloudformation delete-stack --stack-name SinatraJamesh

