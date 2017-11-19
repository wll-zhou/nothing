#!/bin/bash
# 将系统上面有SUID/SGID文件加入指纹记录

#查找文件列表
find /bin /sbin /usr/bin /usr/sbin -perm +6000 > important.file

if [ "$1" == "new" ]
then
    echo -n '' > finger1.file
    for filename in $(cat important.file)
    do
        md5sum $filename >> finger1.file
    done
    echo "New file finger1.file is created."
    exit 0
fi

if [ ! -f finger1.file ]
then
    echo "file : finger1.file not exist.";
    exit 1
fi

[ -f finger_new.file ] && rm finger_new.file
for filename in $(cat important.file)
do
    md5sum $filename >> finger_new.file
done

testing=$(diff finger1.file finger_new.file)
if [ "$testing" != "" ]
then
    echo testing;
fi
