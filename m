From: Ulrich Teichert <krypton@ulrich-teichert.org>
Date: Sun, 10 Jul 2005 17:45:38 +0000
Subject: Re: Flashing of an Ultra2?
Message-Id: <200507101745.j6AHjcWb023278@arbas.nms.ulrich-teichert.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200507091845.j69IjwBL027851@arbas.nms.ulrich-teichert.org>
In-Reply-To: <200507091845.j69IjwBL027851@arbas.nms.ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Baurzhan, Morey & all,

>I had the same problem and tried about everything I could think of to
>work around it, but I couldn't get it to work over the network.  So,
>the only way to do it was off of a ufs partition.  I have no idea why
>it seems to only work there.
[del]

You've been right. Only that I had to install Solaris just to get an UFS
filesystem where I could boot that file from. I just didn't found any
Linux UFS tools and thought that would be the quickest way of doing it -
I think that was my first and last Solaris install.....

Anyway, now my Ultra2 is happly running my new CPUs:

PROMLIB: Sun IEEE Boot Prom 3.25.0 1999/12/03 11:35
Linux version 2.4.25 (root@ceteol) (gcc version egcs-2.92.11 19980921 (gcc2=
 ss-980609 experimental)) #1 SMP Fri Feb 20 00:34:37 CET 2004
ARCH: SUN4U
Ethernet address: 08:00:20:83:01:d5
On node 0 totalpages: 48615
zone(0): 212898 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Found CPU 0 (node=F0065b90,mid=3D0)
Found CPU 1 (node=F0065efc,mid=3D1)
Found 2 CPU prom device tree node(s).
Kernel command line: root=3D/dev/sda4 ro
Calibrating delay loop... 591.46 BogoMIPS
Memory: 368888k available (1768k kernel code, 328k data, 360k init) [fffff8=
0000000000,0000000067f44000]
Dentry cache hash table entries: 65536 (order: 7, 1048576 bytes)
Inode cache hash table entries: 32768 (order: 6, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer cache hash table entries: 16384 (order: 4, 131072 bytes)
Page-cache hash table entries: 65536 (order: 6, 524288 bytes)
POSIX conformance testing by UNIFIX
Entering UltraSMPenguin Mode...
Calibrating delay loop... 591.46 BogoMIPS
Total of 2 processors activated (1182.92 BogoMIPS).
CPU 1: synchronized TICK with master CPU (last diff -5 cycles,maxerr 522 cy=
cles)
Waiting on wait_init_idle (map =3D 0x2)
All processors have done init_idle
....

:-))))

Thanks to all,

CU,
Uli
--=20
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Op=E9ration=
 S)
