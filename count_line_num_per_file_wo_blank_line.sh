#!/bin/bash

if [ $# -ne 1 ]; then
    echo "対象のディレクトリを指定してください。"
    exit 1
fi

TARGET_DIR_PATH=$1


if [ -z "${TARGET_DIR_PATH}" ]; then
    echo "対象のディレクトリを指定してください。"
    exit 1
fi

if [ -e "${TARGET_DIR_PATH}" ]; then
    # パスが存在する
    : # 何もしない
else
    echo "存在するパスを指定してください。"
    exit 1
fi

if [ -d "${TARGET_DIR_PATH}" ]; then
    # パスはディレクトリ
    : # 何もしない
else
    echo "ディレクトリを指定してください。"
    exit 1
fi

find "${TARGET_DIR_PATH%/}/" -type f 2>/dev/null | while read -r FILE_PATH
do

    LINE_NUM=`cat "${FILE_PATH}" | nkf -w | grep -v -e '^\s*$' | wc -l`
    
    echo "${FILE_PATH} ${LINE_NUM}"
done

exit $?