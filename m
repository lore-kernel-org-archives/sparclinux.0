From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 24 Feb 2004 07:37:19 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040224073719.GC693@holomorphy.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TiqCXmo5T1hvSQQg"
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
To: sparclinux@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 22, 2004 at 04:34:50PM -0800, William Lee Irwin III wrote:
>>> OpenBoot 3.2.30 doesn't seem to netboot ELF directly; how did you do it?

On Mon, Feb 23, 2004 at 07:04:55AM -0500, Ben Collins wrote:
>> I didn't say I did it on an e3000 :) Just noting that netboot should
>> still work.

On Mon, Feb 23, 2004 at 04:27:31AM -0800, William Lee Irwin III wrote:
> Yeah, it turned out to be a config problem (CONFIG_NR_CPUS == 6 is bad
> with sparse MID's). I'm chasing down a sunhme.c issue how it appears.
> Bootlog (with some instrumentation) attached.

I found what I was looking for. 2.5.75 makes it to luserspace okay,
so I think I broke whatever 2.6.3 is seeing when cpumask_t got merged.

Bootlog attached (as usual).


-- wli

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Description: e3k.log.47
Content-Disposition: attachment; filename="e3k.log.47"
Content-Transfer-Encoding: quoted-printable

Script started on Mon Feb 23 23:11:57 2004
$ screen -x
/sbin/rc: line 797: syntax error: unexpected end of file
/sbin/rc: line 797: syntax error: unexpected end of file
INIT: Entering runlevel: 3
/sbin/rc: line 797: syntax error: unexpected end of file


This is analyticity.holomorphy.com (Linux sparc64 2.5.75) 07:21:53

analyticity login: root
FATAL: cannot change permissions of TTY: Read-only file system

This is analyticity.holomorphy.com (Linux sparc64 2.5.75) 07:23:18

analyticity login:

This is analyticity.holomorphy.com (Linux sparc64 2.5.75) 07:27:21

analyticity login:

This is analyticity.holomorphy.com (Linux sparc64 2.5.75) 07:27:22

analyticity login: ~Button XIR
Software Power ON
4-slot Sun Enterprise 3000, No Keyboard
OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.



{6} ok boot net:dhcp root=3D/dev/nfs nfsroot=3D/mnt/f/e3k/gentoo ip=3Ddhcp =
debug initcall_debug profile=3D1 gentoo=3Dnodevfs
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: root=3D/dev/=
nfs nfsroot=3D/mnt/f/e3k/gentoo ip=3Ddhcp debug initcall_debug profile=3D1 =
gentoo=3Dnodevfs
Remapping the kernel... done.
Booting Linux...
calling initcall 0x00000000006e3220
calling initcall 0x00000000006da780
calling initcall 0x00000000006dffc0
BIO: pool of 256 setup, 24Kb (96 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (16 bytes)
biovec pool[1]:   4 bvecs: 256 entries (64 bytes)
biovec pool[2]:  16 bvecs: 256 entries (256 bytes)
biovec pool[3]:  64 bvecs: 256 entries (1024 bytes)
biovec pool[4]: 128 bvecs: 256 entries (2048 bytes)
biovec pool[5]: 256 bvecs: 256 entries (4096 bytes)
calling initcall 0x00000000006e5460
calling initcall 0x00000000006e54a0
calling initcall 0x00000000006e5500
calling initcall 0x00000000006e7d20
SCSI subsystem initialized
calling initcall 0x00000000006e8ba0
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array
calling initcall 0x00000000006e93c0
calling initcall 0x00000000006e9a20
calling initcall 0x00000000006e3140
calling initcall 0x00000000006da780
calling initcall 0x00000000006dffc0
BIO: pool of 256 setup, 24Kb (96 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (16 bytes)
biovec pool[1]:   4 bvecs: 256 entries (64 bytes)
biovec pool[2]:  16 bvecs: 256 entries (256 bytes)
biovec pool[3]:  64 bvecs: 256 entries (1024 bytes)
biovec pool[4]: 128 bvecs: 256 entries (2048 bytes)
biovec pool[5]: 256 bvecs: 256 entries (4096 bytes)
calling initcall 0x00000000006e5460
calling initcall 0x00000000006e54a0
calling initcall 0x00000000006e5500
calling initcall 0x00000000006e7d20
SCSI subsystem initialized
calling initcall 0x00000000006e8ba0
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array
calling initcall 0x00000000006e93c0
calling initcall 0x00000000006e9a20
calling initcall 0x00000000006e3140
calling initcall 0x000000000045d0c0
calling initcall 0x00000000006de560
calling initcall 0x00000000006df840
calling initcall 0x00000000006dfac0
calling initcall 0x00000000006dfb60
calling initcall 0x00000000006dfba0
calling initcall 0x00000000006dfc60
calling initcall 0x00000000006dfd40
calling initcall 0x00000000006e01c0
calling initcall 0x00000000006e0240
calling initcall 0x00000000006e02a0
calling initcall 0x00000000006e0680
calling initcall 0x00000000006e0940
calling initcall 0x00000000006e09e0
calling initcall 0x00000000006e0b00
ioctl translation 548 bad
calling initcall 0x00000000006e0ba0
calling initcall 0x00000000006e0c00
calling initcall 0x00000000006e0c20
calling initcall 0x00000000006e0c40
calling initcall 0x00000000006e11a0
calling initcall 0x00000000006e1240
calling initcall 0x00000000006e1460
Journalled Block Device driver loaded
calling initcall 0x00000000006e14a0
calling initcall 0x00000000006e15c0
calling initcall 0x00000000006e1600
calling initcall 0x00000000006e1660
calling initcall 0x00000000006e16c0
calling initcall 0x00000000006e1fe0
udf: registering filesystem
calling initcall 0x00000000006e24e0
calling initcall 0x00000000006e2780
Initializing Cryptographic API
calling initcall 0x00000000006e2800
calling initcall 0x00000000006e2820
calling initcall 0x00000000006e2840
calling initcall 0x00000000006e28a0
calling initcall 0x00000000006e42c0
calling initcall 0x00000000006e5020
SunZilog: 2 chips
zs2 at 0x000001fff8904004 (irq =3D 12,b9) is a SunZilog
zs3 at 0x000001fff8904000 (irq =3D 12,b9) is a SunZilog
ttyS0 at MMIO 0x0 (irq =3D 7317152) is a SunZilog
ttyS1 at MMIO 0x0 (irq =3D 7317152) is a SunZilog
calling initcall 0x00000000006e5260
calling initcall 0x00000000005738a0
calling initcall 0x00000000006e5560
loop: loaded (max 8 devices)
calling initcall 0x00000000006e5800
anticipatory scheduling elevator
calling initcall 0x00000000006e63c0
sunhme.c:v2.01 26/Mar/2002 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet  08:00:20:89:ed:b7
calling initcall 0x00000000006e6960
calling initcall 0x00000000006e7440
calling initcall 0x00000000006e7a40
calling initcall 0x00000000006e8200
st: Version 20030622, fixed bufsize 32768, s/g segs 256
calling initcall 0x00000000006e82c0
calling initcall 0x00000000006e8320
calling initcall 0x00000000006e8360
calling initcall 0x00000000006e83e0
calling initcall 0x00000000006e9180
calling initcall 0x00000000006e92c0
calling initcall 0x00000000006e9360
calling initcall 0x00000000006e9520
calling initcall 0x00000000006e95e0
calling initcall 0x00000000005b0280
calling initcall 0x00000000006e9600
calling initcall 0x00000000006e97c0
calling initcall 0x00000000006e9e00
calling initcall 0x00000000006eac80
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
calling initcall 0x00000000006eb220
calling initcall 0x00000000006eb2a0
calling initcall 0x00000000006eb320
calling initcall 0x00000000006ecc60
Sending DHCP requests . fix old protocol handler ic_bootp_recv+0x0/0x440!
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
fix old protocol handler ic_bootp_recv+0x0/0x440!
 OK
IP-Config: Got DHCP answer from 192.168.1.1,  =08 =08m=08my address is 192.=
168.1.16
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.16, mask=3D255.255.255.0, gw=3D192.16=
8.1.1,
     host=3Danalyticity, domain=3Dholomorphy.com, nis-domain=3D(none),
     bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, rootpath=3D/mnt/f/=
e3k/gentoo
calling initcall 0x00000000006ed360
calling initcall 0x00000000006ed520
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
calling initcall 0x00000000006ed5c0
calling initcall 0x00000000006ed620
calling initcall 0x00000000006ed680
calling initcall 0x00000000006ed6a0
calling initcall 0x00000000006ed720
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem) readonly.
INIT: version 2.84 booting
Gentoo Linux;  =08h=08http://www.gentoo.org/
 Copyright 2001-2003 Gentoo Technologies, Inc.; Distributed under the GPL
=20
* Mounting proc at /proc...  ok
* Activating (possible) swap... ok
* Remounting root filesystem read-only (if necessary)... ok
* Checking root filesystem... fsck: fsck.nfs: not found
fsck: Error 2 while executing fsck.nfs for 192.168.1.1:/mnt/f/e3k/gentoo ok
* Remounting root filesystem read/write...  ok=20
* Setting hostname to analyticity...  ok
* Calculating module dependencies...  ok
* Missing /etc/modules.autoload.d/kernel-2.5
modprobe:  Can't open dependencies file /lib/modules/2.5.75/modules.dep (No=
 such file or directory)
* Checking all filesystems...  ok
* Mounting local filesystems...=20
mount: mount point /dev/shm does not exist
* Some local filesystem failed to mount !!!
* Activating (possibly) more swap...  ok
* Caching service dependencies...
* Can't find service 'portmap' needed by 'netmount';  continuing..
* Setting system clock to hardware clock [UTC]...  ok
* Configuring kernel parameters... ok
* Updating environment... ok
* Cleaning /var/lock, /var/run...  ok
* Cleaning /tmp directory...  ok
* Setting user font...=20
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
putfont: PIO_FONT: Function not implemented
* Failed to set user font !!!
* Loading key mappings... ok
* Bringing lo up... ok
* Initializing random number generator... ok
INIT:  Entering runlevel: 3
* ERROR:  Some services needed are missing.  Run
* './netmount broken' for a list of those=20
* services.  "netmount" was not started.
* Starting local... ok

This is analyticity.holomorphy.com (Linux sparc64 2.5.75) 07:31:20

analyticity login: root
Password:=20
=08l=08login(pam_unix)[897]: session opened for user root by LOGIN(uid=3D0)=
 =08 =08l=08
=08m=08analyticity root # vi /etc/profile
-bash: vi: command not found
analyticity root # emerge nvi
!!! No profile directory; system mode unavailable.
analyticity root # typeset -x PS1=3D'$ '
$ set -o vi
$ typeset -x PS1=3D'$ '
$ typeset -x PS1=3D'# '
# cat /proc/cpuinfo
cpu: TI UltraSparc II  (BlackBird)
fpu: UltraSparc II integrated FPU
promlib : Version 3 Revision 2
prom: 3.2.30
type: sun4u
ncpus probed: 6
ncpus active: 6
Cpu6Bogo: 670.10
Cpu6ClkTck: 000000001406f400
Cpu7Bogo: 670.10
Cpu7ClkTck: 000000001406f400
Cpu10Bogo: 670.10
Cpu10ClkTck: 000000001406f400
Cpu11Bogo: 670.10
Cpu11ClkTck: 000000001406f400
Cpu14Bogo: 670.10
Cpu14ClkTck: 000000001406f400
Cpu15Bogo: 670.10
Cpu15ClkTck: 000000001406f400
MMU Type: Spitfire
State:
CPU6:   online
CPU7:   online
CPU10:  online
CPU11:  online
CPU14:  online
CPU15:  online
# vi /etc/profile^C
#
[detached]
$=20

Script done on Mon Feb 23 23:16:37 2004

--TiqCXmo5T1hvSQQg--
