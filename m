From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 23 Feb 2004 10:02:42 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040223100242.GA661@holomorphy.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
To: sparclinux@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, 22 Feb 2004 14:10:41 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> I get the same tftpbooting your vmlinux run through elftoaout, this
>> time with -p. Does elftoaout look like the culprit?

On Sun, Feb 22, 2004 at 03:17:39PM -0800, David S. Miller wrote:
> It very well might be, let me tool around with this and study your
> logs over the next day or so, I have some other things I really want
> to finish first.
> Meanwhile you can pick one of your 10 disks to install on :)
> Thanks Will.

CONFIG_NR_CPUS=6 is the culprit; things get pretty far in the attached
log which basically did nothing but change CONFIG_NR_CPUS to 32 in
current bk. I think elftoaout, gcc (well, this is 3.3.3), and so on can
all be ruled out simultaneously for this.

Solaris can talk bidirectionally over the same wire, dhcp config, NIC,
etc. but ethereal and tcpdump see limited outbound traffic and no
upper-level protocol acks etc. out of Linux. There could be something
going on with the hme driver. I'm investigating tricks to get the PROM
to somehow recognize the CD's I cut in the meantime.

-- wli

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Description: e3k.log.28
Content-Disposition: attachment; filename="e3k.log.28"
Content-Transfer-Encoding: quoted-printable

Script started on Mon Feb 23 00:32:48 2004
$ s=08screen -x
1049h=1B[r=1B[H7h1;4;6l=1B[4l1h=1B=3D=1B(B=1B[1;24r=1B[H=1B[H.DHCP: Sending=
 message type 1
=2EDHCP: Sending message type 1.
timed out!
IP-Config: Downing eth0
IP-Config: Retrying forever (NFS root)...
IP-Config: eth0 UP (able=3D1, xid=3Df1135bbb)
Sending DHCP requests .DHCP: Sending message type 1
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
=2EDHCP: Sending message type 1
=2EDHCP: Sending message type 1
=2EDHCP: Sending message type 1
=2EDHCP: Sending message type 1
Button XIR
Software Power ON
4-slot Sun Enterprise 3000, No Keyboard
OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.=1B[4B{6} ok boot net:d=
hcp root=3D/dev/nfs nfsroot=3D192.168.1.1:/mnt/f/e3k/gentoo,port=3D2049 ip=
=3D192.168.1.16:192.168.1.1:192.168.1.1:analyticity:off debug initcall_debu=
g profile=3D1
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: root=3D/dev/=
nfs nfsroot=3D192.168.1.1:/mnt/f/e3k/gentoo,port=3D2049 ip=3D192.168.1.16:1=
92.168.1.1:192.168.1.1:analyticity:off debug initcall_debug profile=3D1
Remapping the kernel... done.
Booting Linux...
Linux version 2.6.3 (wli@monad) (gcc version 3.3.3) #1 SMP Mon Feb 23 00:00=
:42 PST 2004
ARCH: SUN4U
Ethernet address: 08:00:20:89:ed:b7
On node 0 totalpages: 490243
  DMA zone: 490243 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 5): Version[1] PartID[fa0] Manuf[3e]=20
FHC(board 7): Version[1] PartID[fa0] Manuf[3e]=20
FHC(board 1): Version[1] PartID[fa0] Manuf[3e]=20
Built 1 zonelists
Kernel command line: root=3D/dev/nfs nfsroot=3D192.168.1.1:/mnt/f/e3k/gento=
o,port=3D2049 ip=3D192.168.1.16:192.168.1.1:192.168.1.1:analyticity:off deb=
ug initcall_debug profile=3D1
IP-Config: Parameter #0: `192.168.1.16'
IP-Config: Parameter #1: `192.168.1.1'
IP-Config: Parameter #2: `192.168.1.1'
IP-Config: Parameter #3: `analyticity'
IP-Config: Parameter #4: `off'
kernel profiling enabled
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Memory: 3873472k available (2288k kernel code, 664k data, 128k init) [fffff=
80000000000,00000000efd18000]
Calibrating delay loop... 670.10 BogoMIPS
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
Calibrating delay loop... 670.10 BogoMIPS
CPU 7: synchronized TICK with master CPU (last diff -10 cycles,maxerr 668 c=
ycles)=08
 =08Calibrating delay loop... 670.10 BogoMIPS
CPU 10: synchronized TICK with master CPU (last diff -14 cycles,maxerr 696 =
cycles)
  Calibrating delay loop... 670.10 BogoMIPS
CPU 11: synchronized TICK with master CPU (last diff -14 cycles,maxerr 686 =
cycles)
  Calibrating delay loop... 670.10 BogoMIPS
CPU 14: synchronized TICK with master CPU (last diff -16 cycles,maxerr 693 =
cycles)
  Calibrating delay loop... 670.10 BogoMIPS
CPU 15: synchronized TICK with master CPU (last diff -15 cycles,maxerr 688 =
cycles)
  Brought up 5 CPUs
Total of 6 processors activated (4020.63 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 1195596 cycles, 1 ticks.
calling initcall 0x00000000006fe9c0
NET: Registered protocol family 16
calling initcall 0x00000000006f7be0
calling initcall 0x00000000006eee60
calling initcall 0x00000000006f4720
calling initcall 0x00000000006f8320
calling initcall 0x00000000006f9d80
calling initcall 0x00000000006f9dc0
calling initcall 0x00000000006fc760
SCSI subsystem initialized
calling initcall 0x00000000006fd6e0
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array=20
calling initcall 0x00000000006fdfe0
calling initcall 0x00000000006fe760
calling initcall 0x00000000006f7920
calling initcall 0x00000000006f0620
calling initcall 0x00000000006f0e80
calling initcall 0x00000000006f20e0
calling initcall 0x00000000006f2660
calling initcall 0x00000000006f2820
calling initcall 0x00000000006f2b80
calling initcall 0x00000000006f2c40
calling initcall 0x00000000006f2ca0
calling initcall 0x000000000045cda0
calling initcall 0x00000000006f2ce0
calling initcall 0x00000000006f2d20
ikconfig 0.7 with /proc/config*
calling initcall 0x00000000006f3ec0
calling initcall 0x00000000006f4020
calling initcall 0x00000000006f42a0
calling initcall 0x00000000006f4360
calling initcall 0x00000000006f4420
calling initcall 0x00000000006f4500
calling initcall 0x00000000006f4900
calling initcall 0x00000000006f4960
calling initcall 0x00000000006f49c0
calling initcall 0x00000000006f4e60
calling initcall 0x00000000006f5120
calling initcall 0x00000000006f51c0
calling initcall 0x00000000006f52e0
calling initcall 0x00000000006f5360
calling initcall 0x00000000006f53c0
calling initcall 0x00000000006f53e0
calling initcall 0x00000000006f5400
calling initcall 0x00000000006f5960
calling initcall 0x00000000006f5a00
calling initcall 0x00000000006f5c20
calling initcall 0x00000000006f5c60
calling initcall 0x00000000006f5d80
calling initcall 0x00000000006f5dc0
calling initcall 0x00000000006f5e20
calling initcall 0x00000000006f5e80
calling initcall 0x00000000006f6760
calling initcall 0x00000000006f67a0
udf: registering filesystem
calling initcall 0x00000000006f6ca0
calling initcall 0x00000000006f6d40
calling initcall 0x00000000006f6f60
Initializing Cryptographic API
calling initcall 0x00000000006f6fe0
calling initcall 0x00000000006f7000
calling initcall 0x00000000006f7020
calling initcall 0x00000000006f7080
calling initcall 0x00000000006f7a80
calling initcall 0x00000000006f7c20
Console: switching to mono PROM 80x34
calling initcall 0x00000000006f7e80
pty: 2048 Unix98 ptys configured
calling initcall 0x00000000006f8c00
calling initcall 0x00000000006f9960
SunZilog: 2 chips.
zs2 at 0x000001fff8904004 (irq =3D 12,b9) is a SunZilog
zs3 at 0x000001fff8904000 (irq =3D 12,b9) is a SunZilog
ttyS0 at MMIO 0x0 (irq =3D 7398880) is a SunZilog
ttyS1 at MMIO 0x0 (irq =3D 7398880) is a SunZilog
Console: ttyS0 (SunZilog zs0)
calling initcall 0x00000000006f9bc0
calling initcall 0x000000000057caa0
calling initcall 0x00000000006f9e20
loop: loaded (max 8 devices)
calling initcall 0x00000000006fa160
Using deadline io scheduler
nbd: registered device at major 43
calling initcall 0x00000000006fad80
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:89:ed:b7=20
calling initcall 0x00000000006fb320
calling initcall 0x00000000006fbe20
calling initcall 0x00000000006fc460
calling initcall 0x00000000006fc6a0
calling initcall 0x00000000006fcce0
st: Version 20040122, fixed bufsize 32768, s/g segs 256
calling initcall 0x00000000006fcda0
calling initcall 0x00000000006fce00
calling initcall 0x00000000006fce40
calling initcall 0x00000000006fcf20
calling initcall 0x00000000006fdcc0
calling initcall 0x00000000006fde00
calling initcall 0x00000000006fdea0
calling initcall 0x00000000006fe080
mice: PS/2 mouse device common for all mice
calling initcall 0x00000000006fe160
calling initcall 0x00000000006fe180
calling initcall 0x00000000006fe240
calling initcall 0x00000000006fe2a0
calling initcall 0x00000000006fe460
calling initcall 0x00000000006fea20
calling initcall 0x00000000006ff8e0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
calling initcall 0x00000000006ffe80
calling initcall 0x00000000006fff00
calling initcall 0x00000000006fff80
calling initcall 0x0000000000702200
calling initcall 0x0000000000702420
NET: Registered protocol family 1
calling initcall 0x00000000007024c0
NET: Registered protocol family 17
calling initcall 0x0000000000702520
NET: Registered protocol family 15
calling initcall 0x0000000000702580
calling initcall 0x00000000007025a0
calling initcall 0x0000000000702620
calling initcall 0x0000000000701b20
IP-Config: Entered.
IP-Config: eth0 UP (able=3D3, xid=3D07196018)
IP-Config: Unable to set interface netmask (-22).
Looking up port of RPC 100005/1 on 192.168.1.1
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
portmap: server 192.168.1.1 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, resetting
eth0: Happy Status 03010000 TX[000003ff:00000301]
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
mount: server 192.168.1.1 not responding, timed out
Root-NFS: Server returned error -5 while mounting /mnt/f/e3k/gentoo
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)
 <0>Press L1-A to return to the boot prom
Bell in window 8  =08=08                  Bell in window 9  =08=08         =
         Bell in window 9  =08=08                  Bell in window 8  =08=08=
                  Bell in window 8  =08=08                  Bell in window =
8  =08=08                  Bell in window 9  =08=08                  Bell i=
n window 8  =08=08                  Bell in window 10  =08=08              =
     1l=1B>=1B[24;1H
1049l[detached]
$=20

Script done on Mon Feb 23 01:56:22 2004

--uAKRQypu60I7Lcqm--
