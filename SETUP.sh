#!/bin/bash
git clone https://github.com/rea-cruitment/simple-sinatra-app.git
zip -r simple-sinatra-app.zip simple-sinatra-app/
aws s3 mb s3://sinatra-jamesh
aws s3 cp simple-sinatra-app.zip s3://sinatra-jamesh/
