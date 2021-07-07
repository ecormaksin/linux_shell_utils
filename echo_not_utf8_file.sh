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

find "${TARGET_DIR_PATH%/}/" -type f 2>/dev/null | grep -v -E "/(\.svn|\.gradle|\.settings|\.apt_generated|\.idea|\.vscode|build|node_modules|bin|vendor)/|/\.(project|classpath|factorypath|gitignore|recovery-temp|iml|gitkeep|jar)$|/(gradlew)$" | while read -r FILE_PATH
do

    echo "処理中... ${FILE_PATH}"

    FILE_TYPE=`file "${FILE_PATH}"`
    echo "${FILE_TYPE}" | grep " text " >/dev/null
    if [ $? -ne 0 ]; then
        continue
    fi

    FILE_ENCODING=`nkf --guess "${FILE_PATH}"`
    if [ "${FILE_ENCODING}" = "UTF-8" ]; then
        continue
    fi

    echo "【対象】${FILE_PATH}: ${FILE_ENCODING}"
done

exit $?