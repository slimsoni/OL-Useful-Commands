
# ------------------------------------------------------------------------------
# Shell Tips for Linux Server Administrators
# ------------------------------------------------------------------------------

# View system log
sudo cat /var/log/messages

# Kill process by PID
kill <PID>  # Use 'ps aux' or 'top' to identify PID



#==== TOP arguments:
#   k - Kill process
#   M - Sort by memory
#   N - Sort by PID
#   r - Renice
#   h - Help
#   z - Color
#   d - Delay update
#   c - Show full path
#   x/y - Highlight sort/running
#   L,&,<,> - Locate/sort
#   CTRL+C or q - Quit
#==== Top remember info:
# us – Tempo gasto em espaço de usuário (aplicações).
# sy – Tempo gasto no kernel (sistema).
# id – Tempo ocioso (idle).
# wa – Tempo esperando por I/O de disco.
# hi, si, st – Interrupções e steal time (menos relevantes aqui).
#==== Top command sintax:

$ top <argument>





# Memory usage
free -h

# Tail logs
tail -100f <file>

# List files ordered by time
ls -ltrh

# Grep exact word
grep -w MAP *.prm

# Grep across files and return filenames
grep -l NODISCARDFILE *

# Grep with subdirs, excluding specific one, called artifacts in this example
grep -R --exclude-dir=artifacts "gitlab" *

# Grep to count number of occurrences ( wc -l ) of a string:
[oracle@sp3linoragghub01 dirrpt]$ grep -i "ORA_MTRH.CC_CC"  R_INTCSD0.dsc | wc -l
68426
[oracle@sp3linoragghub01 dirrpt]$ grep -i "ORA_MTRH.CC_HISTORICO"  R_INTCSD0.dsc | wc -l
0
[oracle@sp3linoragghub01 dirrpt]$ grep -i "ORA_MTRH.CC_LANCAMENTO"  R_INTCSD0.dsc | wc -l
0


# Fix backspace key issue
stty erase ^H

# View non-comment, non-empty lines
cat template.rsp | grep -v '^#' | grep '\S'

# Show IP
ifconfig

# Directory size by depth
sudo du -mh --max-depth 1 /u01 | sort -n | grep G

# Check tcp open ports
netstat -putona

# Check upd ports
netstat -tulnap 

# To check listening upd - ports Like telnet but for udp ports
$ nc -u -v  <ip> <udp-port>
Ncat: Version X ( https://nmap.org/ncat )
Ncat: Connected to <ip>:<udp-port>.

# Firewall commands
systemctl status firewalld
systemctl stop firewalld
firewall-cmd --add-port=7809/tcp --permanent
sudo firewall-cmd --list-ports

# Compare ignoring whitespace
diff -w file1 file2

# Remove directory recursively
rm -rf <dir>

# OS info | kernel info 
cat /etc/os-release
uname -m
hostnamectl

# sudoers example
# oracle ALL=(ALL) NOPASSWD:/bin/mkdir

# DNS cache cleanup (Windows)
ipconfig /flushdns
ipconfig /release
ipconfig /renew

# Which binary
which java

# IP address
ip addr

# Recover deleted file via open file descriptor
lsof -p <PID> | grep <filename>
cd /proc/<PID>/fd
ds -lrt
cat <fd> > /path/to/restore/file

# Docker resource usage
docker stats

# Read clean config file
cat file.rsp | grep -v "^#" | grep -v "^$"

# Clear OS buffer cache
echo 1 > /proc/sys/vm/drop_caches

# Add user/group
groupadd -g 501 oinstall
adduser oracle
useradd -d /home/oracle -u 500 -g oinstall -G oinstall -m -s /bin/bash oracle
usermod -aG oinstall oracle

# Apply the new group membership without logging out
newgrp docker


# Confirm groups
groups oracle
cat /etc/group | grep oinstall
cat /etc/passwd | grep oracle


# SSH to alternate hosts
ssh user@host

# Find directory with special chars
find / -type d -name 'directory*name#?%'

# Find all files in a specific directory that were modified more than 7 days ago.
find /directory/ -type f -mtime +7

# Mass substitution
find . -type f -exec sed -i 's/DADOS_/DATA_/gI' {} +

# Disk usage (top 20)
du -ah <path> | sort -nr | head -20

# Add datetime to history
export HISTTIMEFORMAT="%d/%m/%y %T "

# Create profile if missing
touch ~/.bash_profile
chmod +x ~/.bash_profile
echo "source ~/.bashrc" >> ~/.bash_profile

# SCP file Linux to Linux
scp /path/to/file user@ip:/path/to/dest

# SCP from Windows using PuTTY (pscp)
pscp -scp -i path\to\key.pem file user@ip:/path

# SCP Linux to Windows
scp -P <port> -i key.pem user@ip:/path/to/file C:\path\to\dest

# Compress/decompress
sudo tar -zcvf file.tar /dir
sudo tar -xvf file.tar -C /
tar -tzf file.tar

# Symbolic links
## To create new one
ln -s <target> <link>
## To remove old one 
unlink <link>

# Timezone
export TZ=America/Sao_Paulo
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Remove lines containing word
sed -i -e "s|teste.*||g" your_file_name
## SED command to replace EVERY original_string in your_file_name to the new_string : 
sed -i 's/<original_string>/<new_string>/g' your_file_name
sed -i 's/$((SERVICEMANAGER_PORT + 2))/7832/g' your_file_name
sed -i "s#\$(echo \$DEPLOY_NAME | tr -d '')#dp_daa#g" your_file_name

# IPTABLES commands
iptables -L --line-numbers
iptables -I INPUT -p tcp --dport 7809 -j ACCEPT
iptables -D INPUT <rule>
iptables-legacy -L --line-numbers
iptables-legacy-save > /etc/iptables/rules.v4

# Shell Script conditionals
if [ ! -f file ]; then echo "missing"; fi
if [ ! -L link ]; then ln -s target link; fi
if [ ! -d dir ]; then echo "dir missing"; fi

# Remove file if exists
if [ -f "file.sql" ]; then rm "file.sql"; fi

# View logical volumes
sudo vgdisplay
sudo pvdisplay
lsblk

# Create fake files for test
fallocate -l 1G fakefile

# iperf3 speed test
iperf3 -s  # on target
iperf3 -c target_ip
iperf3 -c target_ip -n 1G
iperf3 -c target_ip -n 1G -R  # reverse

# Test transfer speed via ssh
# (source --> destination)
dd if=/dev/zero bs=1M count=1024 | ssh user@ip "dd of=/dev/null status=progress"

# CPU Info
lscpu

# Disk I/O and performance
vmstat <delay> <n_loop>

##- Procs
##     - r: The number of runnable processes (running or waiting for run times)
##     - b: The number of processes in uninterruptible sleep.

$ vmstat 1 100
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free     buff    cache     si   so   bi     bo     in   cs     us sy id wa st
23  1 21226112 6676920 495572 110369392    1    1 18170   349    0     0      23  3 75  0  0
22  0 21226300 6602512 495624 110381744    0  188 2510803 146798 75009 103943 31  3 66  0  0
21  0 21226220 7122096 495640 110387296   48  176 2802765 144763 71805 108081 29  4 67  0  0
21  1 21226520 7104776 495648 110414496    0  300 4724358 130094 83826 144190 31  4 66  0  0
13  0 21226812 7069708 495652 110437232   20  292 4158714 69523  91477 171523 32  4 64  0  0
18  0 21227108 7059852 495704 110464384    0  296 2295112 148278 75962 102888 29  3 68  0  0
21  0 21227356 7064204 495712 110481504    0  248 3213045 77199  67108 103069 25  3 73  0  0
20  0 21227544 7074168 495728 110496072  124  188 2599582 194942 65134 102784 25  3 72  0  0
17  0 21227916 6947856 495760 110509864   20  372 2229621 86019  67429 84997  28  2 69  0  0
14  1 21228188 6771068 495768 110493152   48  272 2159050 191618 68731 90894  29  3 68  0  0
19  1 21228172 6603892 495792 110457256  220  240 2205113 84015  73633 104918 30  4 65  0  0
25  0 21228348 6028364 495804 110452448    0  176 2496470 185746 70045 96397  32  3 65  0  0
31  0 21228512 5906168 495828 110424296    0  164 3868669 122247 73495 111321 34  3 63  0  0
24  0 21228824 5892612 495832 110402104    4  312 4214477 148942 80927 129165 36  3 61  0  0
29  0 21229012 5891244 495836 110410688    0  188 3688529 133703 79705 123763 32  3 64  0  0
23  0 21229280 5684548 495848 110380592    0  268 2835726 132438 83226 112929 33  4 63  0  0
29  0 21229460 5521328 495852 110368624   60  180 2343098 151095 83959 110462 35  3 62  0  0
24  0 21229660 5628732 495860 110381792   16  200 1627692 133422 71634 81392  33  3 65  0  0




iostat 1 100

# Windows info
msinfo32
wmic memorychip get speed

# Kernel log grep
sudo grep -r "<pattern>" /var/log

# Map dm-X devices
sudo dmsetup ls
dmsetup info /dev/dm-X
sudo lvdisplay | awk '/LV Name/{n=$3} /Block device/{d=$3; sub(".*:","dm-",d); print d,n;}'

# X11 forwarding setup
ssh -Y user@address 
xauth merge /home/user/.Xauthority
xeyes

# Systemd service management
systemctl list-units --all
systemctl edit --full <service>
systemctl daemon-reload
systemctl enable <service>
systemctl start <service>
systemctl status <service>

# Hostname change
hostnamectl set-hostname new_name
reboot

# Crontab
sudo yum install cronie -y  # or dnf for Ubuntu
sudo crond
crontab -e
crontab -l

# Validate multiple file existence (bash array)
files=(file1.sql file2.sql)
for f in "${files[@]}"; do
  [ -f "$f" ] && echo "$f ok" || echo "$f missing"
done

# Search pattern in Windows (like grep -iR)
findstr /S /I /C:"pattern" *

# How to update ssh configurations without losing current connection:
echo "DenyUsers oracle" >> /etc/ssh/sshd_config
kill -HUP $(pgrep -o sshd)
sed -i "s|DenyUsers oracle||g" /etc/ssh/sshd_config
kill -HUP $(pgrep -o sshd)


## To unzip gzip files
# -x: Extract
# -z: Decompress using gzip
# -v: Verbose (show progress)
# -f: Specify the filename
$ tar -xzvf Python-3.13.5.tgz


# Just a extra info about CIDR:
Notação CIDR	Tamanho do "Bairro"	Exemplo de Uso
/32	1 endereço	Um único computador. O mais específico.
/24	256 endereços	Uma rede de escritório pequena.
/16	65.536 endereços	Uma rede corporativa maior.
/8	16.777.216 endereços	Uma rede gigantesca.
/0	Todos os 4 bilhões de endereços	A Internet inteira. (0.0.0.0/0)



# while example:
#!/bin/bash

i=01
while (( i < 51 ))
do
    echo "${i}"
    ((i++))
done



# Comparing file content with intersession concept:
## (comm -12 >> require sorted files)

$ cat banana
banana
-
maça

$ cat maça
maça
:
banana

$ sort banana > banana_s ; sort maça > maça_s ; comm -12 banana_s maça_s
banana
maça


# Conditional assigning:
## DATA = strings between  ('@' and '&') or ('@' and '@')
    data=$(echo "$decoded" | grep -oP '(?<=@).*?(?=&)')
