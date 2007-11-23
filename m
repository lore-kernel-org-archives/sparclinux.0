From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 23 Nov 2007 09:08:04 +0000
Subject: NFS hangs in D state
Message-Id: <47469874.7070606@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I'm using some sparc solaris diskless servers (Solaris 10 up to date) 
over a gigabit ethernet network. These servers use a cluster of sparc64 
linux servers (rarpd+bootparamd+nfs v3/tcp). This nfs server is a T1000 
running debian/testing with a 2.6.23.8 official kernel (with a raid5.c 
patch). Sometimes, nfsd hangs in D state :

Root gershwin:[~] > ps auwx | grep nfs
root      3641  0.5  0.0      0     0 ?        D    Nov21  14:02 [nfsd]
root     15520  0.0  0.0   2048   800 pts/0    S+   09:59   0:00 grep nfs
nobody   24922  0.0  0.0   3880  1424 ?        SN   06:25   0:00 su 
nobody -s /bin/sh -c /usr/bin/find / -ignore_readdir_race      \( 
-fstype NFS -o -fstype nfs -o -fstype nfs4 -o -fstype afs -o -fstype 
binfmt_misc -o -fstype proc -o -fstype smbfs -o -fstype autofs -o 
-fstype iso9660 -o -fstype ncpfs -o -fstype coda -o -fstype devpts -o 
-fstype ftpfs -o -fstype devfs -o -fstype mfs -o -fstype shfs -o -fstype 
sysfs -o -fstype cifs -o -fstype lustre_lite -o -fstype tmpfs -o -fstype 
usbfs -o -fstype udf -o      -type d -regex 
'\(^/tmp$\)\|\(^/usr/tmp$\)\|\(^/var/tmp$\)\|\(^/afs$\)\|\(^/amd$\)\|\(^/alex$\)\|\(^/var/spool$\)\|\(^/sfs$\)\|\(^/media$\)' 
\) -prune -o -print0
nobody   24923  1.4  0.0   2144  1136 ?        DN   06:25   3:07 
/usr/bin/find / -ignore_readdir_race ( -fstype NFS -o -fstype nfs -o 
-fstype nfs4 -o -fstype afs -o -fstype binfmt_misc -o -fstype proc -o 
-fstype smbfs -o -fstype autofs -o -fstype iso9660 -o -fstype ncpfs -o 
-fstype coda -o -fstype devpts -o -fstype ftpfs -o -fstype devfs -o 
-fstype mfs -o -fstype shfs -o -fstype sysfs -o -fstype cifs -o -fstype 
lustre_lite -o -fstype tmpfs -o -fstype usbfs -o -fstype udf -o -type d 
-regex 
\(^/tmp$\)\|\(^/usr/tmp$\)\|\(^/var/tmp$\)\|\(^/afs$\)\|\(^/amd$\)\|\(^/alex$\)\|\(^/var/spool$\)\|\(^/sfs$\)\|\(^/media$\) 
) -prune -o -print0
Root gershwin:[~] >

	I don't have any information in log files. I have made similar 
constatation with 2.6.23.

	I use at home the same kernel on several U60/SMP, U80/SMP and U420/SMP 
with nfs v3 without any trouble. I'm not sure that this trouble come 
from Solaris side... Maybe from sun4v support...

	Any idea ? Thanks in advance,

	JKB
