#!/bin/sh
######################################################
######################################################
######################################################
#############联系方式:dingdluan@gmail.com##############
######################################################
######################################################
######################################################


###获取现在的ip以及时间
ip_now=$(/usr/sbin/ifconfig |grep 'inet 202.192.33' |awk '{print $2}')
time_now=$(echo $(date +%F-%T))
	#判断服务器是否为断网或不在教育网202网段状态状态
	#此网段为作者所在网段，您可自己修改为您所在网段
	if [ ! $ip_now ];then
		exit 0
	fi
	#---->断网了GG思密达

###初次运行程序创建日志文件
if [ ! -f /home/luantch/check_ip/ip_history.txt ]; then  #此处地址应当为您自己文件所在地址，请进行修改
	echo $time_now $ip_now > /home/luantch/check_ip/ip_history.txt
	rm -rf /mnt/firstlight_ipcheck/ip_history.txt   #此处为作者dav云盘挂载地址，请进行修改
	cp -f /home/luantch/check_ip/ip_history.txt /mnt/firstlight_ipcheck/ip_history.txt
	exit 0
fi

###判断ip是否更新并更新日志文件
ip_pre=$(tail -n 1 /home/luantch/check_ip/ip_history.txt |awk '{print $2}')
if [ "$ip_pre" == "$ip_now" ];then
	exit 0
else
	echo $time_now $ip_now >> /home/luantch/check_ip/ip_history.txt
	rm -rf /mnt/firstlight_ipcheck/ip_history.txt
	cp -f /home/luantch/check_ip/ip_history.txt /mnt/firstlight_ipcheck/ip_history.txt
fi

