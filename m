From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 23 Feb 2004 12:27:31 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040223122731.GB661@holomorphy.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
To: sparclinux@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 22, 2004 at 04:34:50PM -0800, William Lee Irwin III wrote:
>> OpenBoot 3.2.30 doesn't seem to netboot ELF directly; how did you do it?

On Mon, Feb 23, 2004 at 07:04:55AM -0500, Ben Collins wrote:
> I didn't say I did it on an e3000 :) Just noting that netboot should
> still work.

Yeah, it turned out to be a config problem (CONFIG_NR_CPUS == 6 is bad
with sparse MID's). I'm chasing down a sunhme.c issue how it appears.
Bootlog (with some instrumentation) attached.


-- wli

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Description: e3k.log.32
Content-Disposition: attachment; filename="e3k.log.32"
Content-Transfer-Encoding: quoted-printable

Script started on Mon Feb 23 04:16:30 2004
$ s=08screen -x
1049h=1B[r=1B[H7h1;4;6l=1B[4l1h=1B=3D=1B(B=1B[1;24r=1B[H=1B[H0000000], tx o=
ld[00000100] and rx [00000a00] ON!
IP-Config: eth0 UP (able=3D1, xid=3D07196018)
IP-Config: Complete:=1B[4;7Hdevice=3Deth0, addr=3D192.168.1.16, mask=3D255.=
255.255.0, gw=3D192.168.1.1,=1B[5;6Hhost=3Danalyticity, domain=3D, nis-doma=
in=3D(none),=1B[6;6Hbootserver=3D192.168.1.1, rootserver=3D192.168.1.1, roo=
tpath=3D
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
mount: server 192.168.1.1 not responding, timed out
Root-NFS: Server returned error -5 while mounting /mnt/f/e3k/gentoo
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)K
<0>Press L1-A to return to the boot prom
Button XIR
Software Power ON
4-slot Sun Enterprise 3000, No Keyboard
OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.=1B[4B{6} ok boot net:d=
hcp root=3D/dev/nfs nfsroot=3D192.168.1.1:/mnt/f/e3k/gentoo,port=3D2049,mou=
nt_port=3D771 ip=3D192.168.1.16:192.168.1.1:192.168.1.1:255.255.255.0:analy=
ticity:eth0:dhcp debug initcall_debug profile=3D1
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: root=3D/dev/=
nfs nfsroot=3D192.168.1.1:/mnt/f/e3k/gentoo,port=3D2049,mount_port=3D771 ip=
=3D192.168.1.16:192.168.1.1:192.168.1.1:255.255.255.0:analyticity:eth0:dhcp=
 debug initcall_debug profile=3D1
Remapping the kernel... done.
Booting Linux...
Linux version 2.6.3 (wli@monad) (gcc version 3.3.3) #6 SMP Mon Feb 23 04:15=
:23 PST 2004
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
o,port=3D2049,mount_port=3D771 ip=3D192.168.1.16:192.168.1.1:192.168.1.1:25=
5.255.255.0:analyticity:eth0:dhcp debug initcall_debug profile=3D1
IP-Config: Parameter #0: `192.168.1.16'
IP-Config: Parameter #1: `192.168.1.1'
IP-Config: Parameter #2: `192.168.1.1'
IP-Config: Parameter #3: `255.255.255.0'
IP-Config: Parameter #4: `analyticity'
IP-Config: Parameter #5: `eth0'
IP-Config: Parameter #6: `dhcp'
kernel profiling enabled
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Memory: 3873472k available (2280k kernel code, 664k data, 128k init) [fffff=
80000000000,00000000efd18000]
Calibrating delay loop... 670.10 BogoMIPS
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
Calibrating delay loop... 670.10 BogoMIPS
CPU 7: synchronized TICK with master CPU (last diff -3 cycles,maxerr 651 cy=
cles)
Calibrating delay loop... 670.10 BogoMIPS
CPU 10: synchronized TICK with master CPU (last diff 2 cycles,maxerr 661 cy=
cles)
Calibrating delay loop... 670.10 BogoMIPS
CPU 11: synchronized TICK with master CPU (last diff -12 cycles,maxerr 686 =
cycles)
  Calibrating delay loop... 670.10 BogoMIPS
CPU 14: synchronized TICK with master CPU (last diff -16 cycles,maxerr 694 =
cycles)
  Calibrating delay loop... 670.10 BogoMIPS
CPU 15: synchronized TICK with master CPU (last diff -3 cycles,maxerr 668 c=
ycles)=08
 =08Brought up 5 CPUs
Total of 6 processors activated (4020.63 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 1196100 cycles, 1 ticks.
calling initcall 0x00000000006fe900
NET: Registered protocol family 16
calling initcall 0x00000000006f7c00
calling initcall 0x00000000006eee60
calling initcall 0x00000000006f4720
calling initcall 0x00000000006f8340
calling initcall 0x00000000006f9da0
calling initcall 0x00000000006f9de0
calling initcall 0x00000000006fc780
SCSI subsystem initialized
calling initcall 0x00000000006fd700
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array=20
calling initcall 0x00000000006fe000
calling initcall 0x00000000006fe6a0
calling initcall 0x00000000006f7940
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
calling initcall 0x00000000006f6780
calling initcall 0x00000000006f67c0
udf: registering filesystem
calling initcall 0x00000000006f6cc0
calling initcall 0x00000000006f6d60
calling initcall 0x00000000006f6f80
Initializing Cryptographic API
calling initcall 0x00000000006f7000
calling initcall 0x00000000006f7020
calling initcall 0x00000000006f7040
calling initcall 0x00000000006f70a0
calling initcall 0x00000000006f7aa0
calling initcall 0x00000000006f7c40
Console: switching to mono PROM 80x34
calling initcall 0x00000000006f7ea0
pty: 2048 Unix98 ptys configured
calling initcall 0x00000000006f8c20
calling initcall 0x00000000006f9980
SunZilog: 2 chips.
zs2 at 0x000001fff8904004 (irq =3D 12,b9) is a SunZilog
zs3 at 0x000001fff8904000 (irq =3D 12,b9) is a SunZilog
handler_irq(12, fffff800efcaf6c0)
ttyS0 at MMIO 0x0 (irq =3D 7398880) is a SunZilog
ttyS1 at MMIO 0x0 (irq =3D 7398880) is a SunZilog
Console: ttyS0 (SunZilog zs0)
calling initcall 0x00000000006f9be0
calling initcall 0x000000000057caa0
calling initcall 0x00000000006f9e40
loop: loaded (max 8 devices)
calling initcall 0x00000000006fa180
Using deadline io scheduler
nbd: registered device at major 43
calling initcall 0x00000000006fada0
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
happy_meal_stop: reset, done
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:89:ed:b7=20
calling initcall 0x00000000006fb340
calling initcall 0x00000000006fbe40
calling initcall 0x00000000006fc480
calling initcall 0x00000000006fc6c0
calling initcall 0x00000000006fcd00
st: Version 20040122, fixed bufsize 32768, s/g segs 256
calling initcall 0x00000000006fcdc0
calling initcall 0x00000000006fce20
calling initcall 0x00000000006fce60
calling initcall 0x00000000006fcf40
calling initcall 0x00000000006fdce0
calling initcall 0x00000000006fde20
calling initcall 0x00000000006fdec0
calling initcall 0x00000000006fe0a0
calling initcall 0x00000000006fe0c0
calling initcall 0x00000000006fe180
calling initcall 0x00000000006fe1e0
calling initcall 0x00000000006fe3a0
calling initcall 0x00000000006fe960
calling initcall 0x00000000006ff820
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
calling initcall 0x00000000006ffdc0
calling initcall 0x00000000006ffe40
calling initcall 0x00000000006ffec0
calling initcall 0x0000000000702140
calling initcall 0x0000000000702360
NET: Registered protocol family 1
calling initcall 0x0000000000702400
NET: Registered protocol family 17
calling initcall 0x0000000000702460
NET: Registered protocol family 15
calling initcall 0x00000000007024c0
calling initcall 0x00000000007024e0
calling initcall 0x0000000000702560
calling initcall 0x0000000000701a60
IP-Config: Entered.
happy_meal_open: to happy_meal_init
happy_meal_init: happy_flags[00000186] set HFLAG_INIT, to happy_meal_poll_s=
top
not polling, return
happy_meal_init: to happy_meal_stop
happy_meal_stop: reset, done
happy_meal_init: to happy_meal_init_rings
happy_meal_init_rings: counters to zero, clean, init rxring, init txring, d=
one
happy_meal_init: Disable all MIF irqs (old[0000ffff]), use frame old[000001=
00], to happy_meal_transceiver_check
happy_meal_init: internal, using MII, tx/rx reset, happy_meal_tx_reset: res=
et, done
   happy_meal_rx_reset: reset, done
jsize/ipg1/ipg2, rseed/macaddr, htable, ring ptrs rxr[c7ffe000] txr[c7ffe80=
0]
happy_meal_init: old[00000000] bursts<64>, enable global interrupts, tx rsi=
ze=3D32 oreg[0000000f], tx dma enable old[000003fe], erx regs bug old[00000=
000]
happy_meal_init: enable hash rx_cfg_old[00000101], BIGMAC init, XIF config =
old[00000000], tx old[00000100] and rx [00000a00] ON!
IP-Config: eth0 UP (able=3D1, xid=3D07196018)
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.16, mask=3D255.255.255.0, gw=3D192.16=
8.1.1,
     host=3Danalyticity, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, rootpath=3D
handler_irq(5, fffff800efcaed90)
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
mount: server 192.168.1.1 not responding, timed out
Root-NFS: Server returned error -5 while mounting /mnt/f/e3k/gentoo
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)
 <0>Press L1-A to return to the boot prom
1l=1B>=1B[24;1H
1049l[detached]
$=20

Script done on Mon Feb 23 04:22:48 2004

--DBIVS5p969aUjpLe--
