From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 12 Oct 2007 14:19:15 +0000
Subject: Blockdev API returns erroneous size on /dev/nbd
Message-Id: <470F8263.4020107@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: nbd-general@lists.sourceforge.net, sparclinux@vger.kernel.org

	Hello,

	I'm trying to build a Raid1 volume over TCP/IP. I use net block device 
on a 2.6.23 linux kernel on a T1000 server (sparc64).

NBD server exports /dev/md7 (raid5 volume):
Root poulenc:[~] > blockdev --getsize64 /dev/md7
1499879178240
Root poulenc:[/] > nbd-server 2000 /dev/md7 1464725760 -l 192.168.0.0/24 
-C /etc/nbd-server/empty

On NDB client side:
Root gershwin:[~] > blockdev --getsize64 /dev/nbd0
1464725504
Root gershwin:[~] > blockdev --getsize64 /dev/md7
1499879178240

	When NDB client tries to connect to its server, I obtain :

Root gershwin:[/usr/scripts] > nbd-client bs@96 192.168.0.2 2000 /dev/nbd0
Negotiation: ..size = 1430396KB
bs@96, sz57599
Root gershwin:[/usr/scripts] >

Thus, nbd seems to work. Please note that size is correctly returned. 
Now, I would build a raid1 array on this server with /dev/nbd0 and 
/dev/md7. But mdadm return

Root gershwin:[/usr/scripts] > mdadm -C /dev/md8 -l1 -n2 /dev/md7 /dev/nbd0
mdadm: /dev/md7 appears to contain an ext2fs file system
     size64725760K  mtime=Thu Jan  1 01:00:00 1970
mdadm: /dev/md7 appears to be part of a raid array:
     level=raid0 devices=2 ctime=Fri Oct 12 14:22:27 2007
mdadm: /dev/nbd0 appears to contain an ext2fs file system
     size64725760K  mtime=Thu Jan  1 01:00:00 1970
mdadm: /dev/nbd0 appears to be part of a raid array:
     level=raid0 devices=2 ctime=Fri Oct 12 14:22:27 2007
mdadm: largest drive (/dev/md7) exceed size (1430272K) by more than 1%

I have seen that it is possible to use nbd to build raid. But how can I 
fix the size of exported device ? Indeed, /dev/md7 appears to be 1024 
times greater than the _same_ block device exported by nbd !

Other question : I have tried to write large files on /dev/nbd0 and 
kernel returns :

nbd0: rw=1, want(77616, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77624, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77632, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77640, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77648, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77656, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77664, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77672, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77680, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77688, limit(60792
attempt to access beyond end of device
nbd0: rw=1, want(77696, limit(60792
attempt to access beyond end of device

	I suspect a bug, but I haven't find any fix or workaround...

	Regards,

	JKB
