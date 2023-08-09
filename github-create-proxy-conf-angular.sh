#!/bin/bash
# script to create fallai with configurations for proxy for angular for github actions
# the script allows you to create a file and update it by adding another link for proxying
# Author: kotorkovsciy

# example of working with a script
# create file
# bash ./github-create-proxy-conf-angular.sh ./proxy.conf.json http://localhost:5000 /api false "^/api" "empty" "null" "null" "create"
# output
# {
#   "/api": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/api": ""
#     }
#   }
# }
# update file
# bash ./github-create-proxy-conf-angular.sh ./proxy.conf.json http://localhost:5000 /media false "^/static" "empty" "null" "null" "update"
# output
# {
#   "/api": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/api": ""
#     }
#   },
#   "/media": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/static": ""
#     }
#   }
# }
# example of using all parameters
# bash ./github-create-proxy-conf-angular.sh ./proxy.conf.json http://localhost:5000 /api false "^/static" "empty" true "debug" "create"
# output
# {
#   "/api": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/static": ""
#     },
#     "changeOrigin": true,
#     "logLevel": "debug"
#   }
# }

# list parmas
# 1 - path
# 2 - target
# 3 - url
# 4 - secure
# 5 - pathRewriteOld
# 6 - pathRewriteNew
# 7 - changeOrigin
# 8 - logLevel
# 9 - type create or update

# variables
path=$1
target=$2
url=$3
secure=$4
pathRewriteOld=$5
pathRewriteNew=$6
changeOrigin=$7
logLevel=$8
type=$9

# check veribles
if [ -z "$path" ]
then
      echo "path is empty"
      exit 1
fi

if [ -z "$target" ]
then
      echo "target is empty"
      exit 1
fi

if [ -z "$url" ]
then
      echo "url is empty"
      exit 1
fi

if [ -z "$secure" ]
then
      echo "secure is empty"
      exit 1
fi

if [ -z "$pathRewriteOld" ]
then
      echo "pathRewriteOld is empty"
      exit 1
fi

if [ -z "$pathRewriteNew" ]
then
      echo "pathRewriteNew is empty"
      exit 1
fi

if [ -z "$changeOrigin" ]
then
      echo "changeOrigin is empty"
      exit 1
fi

if [ -z "$logLevel" ]
then
      echo "logLevel is empty"
      exit 1
fi

if [ -z "$type" ]
then
      echo "type is empty"
      exit 1
fi

function write_to_file {
    echo "  \"$url\": {" >> $path
    echo "    \"target\": \"$target\"," >> $path
    echo "    \"secure\": $secure," >> $path
    if [ "$pathRewriteOld" != "null" ]; then
        if [ "$pathRewriteNew" == "empty" ]; then
            echo "    \"pathRewrite\": {" >> $path
            echo "      \"$pathRewriteOld\": \"\"" >> $path
            echo "    }," >> $path
        else
            echo "    \"pathRewrite\": {" >> $path
            echo "      \"$pathRewriteOld\": \"$pathRewriteNew\"" >> $path
            echo "    }," >> $path
        fi
    fi
    if [ "$changeOrigin" != "null" ]; then
        echo "    \"changeOrigin\": $changeOrigin," >> $path
    fi
    if [ "$logLevel" != "null" ]; then
        echo "    \"logLevel\": \"$logLevel\"" >> $path
    fi
    # checking if there is an extra comma at the end of the file
    lastChar=$(tail -c 2 $path)
    if [ "$lastChar" = "," ]; then
        echo $(sed '$ s/.$//' $path) > $path
    fi
    echo "  }" >> $path
}

function check_file {
    if [ ! -f "$path" ]; then
        echo "file $path not found"
        exit 1
    fi
}

# create file
if [ "$type" == "create" ]; then
    # create file
    echo "{" > $path

    # write link
    write_to_file

    # write last brackets
    echo "}" >> $path

    echo "file $path created"
fi

# update file
# update file
if [ "$type" == "update" ]; then
    # check file
    check_file

    # since the link is already written in the file, you need to remove the last brackets
    sed -i '$ d' $path
    echo "," >> $path

    # write new link
    write_to_file

    # write last brackets
    echo "}" >> $path

    echo "file $path updated"
fi
