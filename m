From: Josh Grebe <squash@gentoo.org>
Date: Fri, 11 Mar 2005 19:19:25 +0000
Subject: Problems with V240
Message-Id: <4231EF3D.9040902@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi List,

I've been working with a couple V240s, and have run into a few issues. I ha=
ve tried 3 different
machines, so I think I've fairly ruled out a hardware issue. With that said=
, here's what I see.

On both 2.4 and 2.6 kernels, I get an occasional D-cache parity error (no p=
articular order, the Mar 4
ones are on a different machine than the later ones):
Mar  4 18:34:08 v240 CPU[1]: Cheetah+ D-cache parity error at TPC[000000000=
04a62d8]
Mar  4 10:50:07 v240 CPU[0]: Cheetah+ D-cache parity error at TPC[000000000=
04606c0]
Mar  4 12:22:54 v240 CPU[1]: Cheetah+ D-cache parity error at TPC[000000000=
05ae90c]
Mar  7 17:25:15 v240 CPU[0]: Cheetah+ D-cache parity error at TPC[000000000=
04870a4]
Mar  8 02:08:22 v240 CPU[0]: Cheetah+ D-cache parity error at TPC[000000000=
04870a4]
Mar  8 09:13:51 v240 CPU[0]: Cheetah+ D-cache parity error at TPC[000000000=
04870a4]
Mar 10 04:53:45 v240 CPU[0]: Cheetah+ D-cache parity error at TPC[000000000=
04ec38c]
Mar 11 02:33:32 v240 CPU[0]: Cheetah+ D-cache parity error at TPC[000000000=
04ec38c]

Since it is a cache error, it should be No Big Deal, and maybe Solaris is s=
ilently ignoring them?

These machines all have 2G of ram, but Linux detects otherwise.
2.4.29 says:
Memory: 1293136k available (1712k kernel code, 240k data, 128k init) [fffff=
80000000000,000000103ff02000]
2.6.9 says:
Memory: 1623296k available (1920k kernel code, 544k data, 144k init) [fffff=
80000000000,000000103ff02000]

I enabled debugging Bootmem on 2.4, it says:
Bootmem_init: Scan sp_banks, init_bootmem(min[0], bootmap[162], max[81ff81])
free_bootmem(sp_banks:0): base[0] size[40000000]
free_bootmem(sp_banks:1): base[1000000000] size[3effe000]
free_bootmem(sp_banks:2): base[103f000000] size[dcc000]
free_bootmem(sp_banks:3): base[103fdd0000] size[e0000]
free_bootmem(sp_banks:4): base[103fec0000] size[10000]
free_bootmem(sp_banks:5): base[103ff00000] size[2000]
reserve_bootmem(kernel): base[0] size[2c3a90]
reserve_bootmem(bootmap): base[2c4000] size[103ff8]


Anyway,
I can live with that. However, after a period of Real Work,
Mar  4 13:31:44 v240 ERROR(0): Cheetah error trap taken afsr[80101000000000=
00] afar[000000009af900e0] TL1(1)
Mar  4 13:31:44 v240 ERROR(0): TPC[0000000000408d24] TNPC[0000000000408d28]=
 TSTATE[0000009911049406]
Mar  4 13:31:44 v240 ERROR(0): M_SYND(0),  E_SYND(0), Privileged
Mar  4 13:31:44 v240 ERROR(0): Highest priority error (0000100000000000) "U=
nmapped error from system bus"
Mar  4 13:31:44 v240 ERROR(0): D-cache idx[80e0] tag[000000000009af91] utag=
[0000000000003300] stag[000000000009af90]
Mar  4 13:31:44 v240 ERROR(0): D-cache data0[00135f2070178a14] data1[004b20=
8c004b1f44] data2[0000000000030419] data3[0000000000030419]
Mar  4 13:31:44 v240 ERROR(0): I-cache idx[0] tag[0000000000000000] utag[00=
00000000000000] stag[0000000000000000] u[0000000000000000] l[00000000000000=
00]
Mar  4 13:31:44 v240 ERROR(0): I-cache INSN0[0000000000000000] INSN1[000000=
0000000000] INSN2[0000000000000000] INSN3[0000000000000000]
Mar  4 13:31:44 v240 ERROR(0): I-cache INSN4[0000000000000000] INSN5[000000=
0000000000] INSN6[0000000000000000] INSN7[0000000000000000]
Mar  4 13:31:44 v240 ERROR(0): E-cache idx[9af900e0] tag[0010100000000000]
Mar  4 13:31:44 v240 ERROR(0): E-cache data0[106ff8c18f414000] data1[921000=
1494100015] data2[40002c549003a8bf] data3[306ff9da86102018]
Mar  4 13:31:44 v240 Kernel panic: Irrecoverable deferred error trap.
Mar  4 13:31:44 v240
Mar  4 13:31:45 v240 Press L1-A to return to the boot prom

When this happens, the box is still Alive, but one cpu is pegged at 100%.  =
This is from Machine1.  However,
Machine2 agrees:
Mar  5 11:16:34 v240 ERROR(0): Cheetah error trap taken afsr[80108000000000=
00] afar[00000009eb6340e0] TL1(1)
Mar  5 11:16:34 v240 ERROR(0): TPC[0000000000410514] TNPC[0000000000410518]=
 TSTATE[0000004411009507]
Mar  5 11:16:34 v240 ERROR(0): M_SYND(0),  E_SYND(0), Privileged
Mar  5 11:16:34 v240 ERROR(0): Highest priority error (0000800000000000) "O=
ut of range memory error has occurred"
Mar  5 11:16:34 v240 ERROR(0): AFAR M-syndrome [???]
Mar  5 11:16:34 v240 ERROR(0): D-cache idx[80e0] tag[00000000209eb635] utag=
[000000000000be00] stag[00000000209eb634]
Mar  5 11:16:34 v240 ERROR(0): D-cache data0[413d6c696278736c] data1[000000=
0000414000] data2[fffff80030fd0118] data3[0000000000000000]
Mar  5 11:16:34 v240 ERROR(0): I-cache idx[0] tag[0000000000000000] utag[00=
00000000000000] stag[0000000000000000] u[0000000000000000] l[00000000000000=
00]
Mar  5 11:16:34 v240 ERROR(0): I-cache INSN0[0000000000000000] INSN1[000000=
0000000000] INSN2[0000000000000000] INSN3[0000000000000000]
Mar  5 11:16:34 v240 ERROR(0): I-cache INSN4[0000000000000000] INSN5[000000=
0000000000] INSN6[0000000000000000] INSN7[0000000000000000]
Mar  5 11:16:34 v240 ERROR(0): E-cache idx[eb6340e0] tag[0000000000000000]
Mar  5 11:16:34 v240 ERROR(0): E-cache data0[0000000000000000] data1[000000=
0000000000] data2[0000000000000000] data3[0000000000000000]
Mar  5 11:16:34 v240 Kernel panic: Irrecoverable deferred error trap.
Mar  5 11:16:34 v240
Mar  5 11:16:35 v240 Press L1-A to return to the boot prom

These logs are from kernel 2.4.29. I also tried 2.6, and it hangs around wh=
en it would be starting init if I
run SMP, boots ok UP.. Although if I force init=3D/bin/bash, it works. I've=
 added echos into each file in the boot
runlevel, and none of them ever print.

I ran a UP 2.6.9 kernel for over 4 days and got only D-cache errors, no cra=
sh.

When the first box crashes, I figured it was bad hardware. Since Sun would =
want to hear about how Solaris
crashed it, I put Solaris 10 on it and ran SunVTS 6 in exclusive mode on th=
e cpu and memory for a solid week,
and it passed all tests. So, here I am.

Below I'm pasting a full dmesg from machine 1.

Any thoughts?

Thanks,

Josh




Mar  4 09:26:11 v240 PROMLIB: Sun IEEE Boot Prom 4.16.4 2004/12/18 05:20
Mar  4 09:26:11 v240 Linux version 2.4.29-sparc (root@livecd) (gcc version =
3.3.5 (Gentoo Linux 3.3.5)) #1 SMP Thu Mar 3 13:06:23 CST 2005
Mar  4 09:26:11 v240 ARCH: SUN4U
Mar  4 09:26:11 v240 Ethernet address: 00:03:ba:5f:9c:11
Mar  4 09:26:11 v240 On node 0 totalpages: 261498
Mar  4 09:26:11 v240 zone(0): 8519553 pages.
Mar  4 09:26:11 v240 zone(1): 0 pages.
Mar  4 09:26:11 v240 zone(2): 0 pages.
Mar  4 09:26:11 v240 Found CPU 0 (node=F0065570,mid=3D0)
Mar  4 09:26:11 v240 Found CPU 1 (node=F0065df0,mid=3D1)
Mar  4 09:26:11 v240 Found 2 CPU prom device tree node(s).
Mar  4 09:26:11 v240 Kernel command line: root=3D/dev/sda4
Mar  4 09:26:11 v240 Calibrating delay loop... 851.96 BogoMIPS
Mar  4 09:26:11 v240 Memory: 1293136k available (1712k kernel code, 240k da=
ta, 128k init) [fffff80000000000,000000103ff02000]
Mar  4 09:26:11 v240 Dentry cache hash table entries: 262144 (order: 9, 419=
4304 bytes)
Mar  4 09:26:11 v240 Inode cache hash table entries: 131072 (order: 8, 2097=
152 bytes)
Mar  4 09:26:11 v240 Mount cache hash table entries: 512 (order: 0, 8192 by=
tes)
Mar  4 09:26:11 v240 Buffer cache hash table entries: 131072 (order: 7, 104=
8576 bytes)
Mar  4 09:26:11 v240 Page-cache hash table entries: 262144 (order: 8, 20971=
52 bytes)
Mar  4 09:26:11 v240 POSIX conformance testing by UNIFIX
Mar  4 09:26:11 v240 Entering UltraSMPenguin Mode...
Mar  4 09:26:11 v240 Calibrating delay loop... 851.96 BogoMIPS
Mar  4 09:26:11 v240 Total of 2 processors activated (1703.93 BogoMIPS).
Mar  4 09:26:11 v240 CPU 0: synchronized TICK with master CPU (last diff 1 =
cycles,maxerr 6 cycles)
Mar  4 09:26:11 v240 Waiting on wait_init_idle (map =3D 0x1)
Mar  4 09:26:11 v240 All processors have done init_idle
Mar  4 09:26:11 v240 PCI: Probing for controllers.
Mar  4 09:26:11 v240 TOMATILLO0 PBMB: ver[4:0], portid 1f, cregs[4000fc0000=
0] pregs[4000ff00000]
Mar  4 09:26:11 v240 TOMATILLO0 PBMB: PCI CFG[7f600000000] IO[7f601000000] =
MEM[7f700000000]
Mar  4 09:26:11 v240 TOMATILLO0 PBMA: ver[4:0], portid 1e, cregs[4000f40000=
0] pregs[4000f600000]
Mar  4 09:26:11 v240 TOMATILLO0 PBMA: PCI CFG[7fe00000000] IO[7fe01000000] =
MEM[7ff00000000]
Mar  4 09:26:11 v240 TOMATILLO1 PBMA: ver[4:0], portid 1c, cregs[4000e40000=
0] pregs[4000e600000]
Mar  4 09:26:11 v240 TOMATILLO1 PBMA: PCI CFG[7ce00000000] IO[7ce01000000] =
MEM[7cf00000000]
Mar  4 09:26:11 v240 TOMATILLO1 PBMB: ver[4:0], portid 1d, cregs[4000ec0000=
0] pregs[4000ef00000]
Mar  4 09:26:11 v240 TOMATILLO1 PBMB: PCI CFG[7c600000000] IO[7c601000000] =
MEM[7c700000000]
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[1c]
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[1d]
Mar  4 09:26:11 v240 PCI1(PBMB): Bus running at 66MHz
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 1] slot[ 2] map[0] to INO[29]
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 1] slot[ 2] map[0] to INO[28]
Mar  4 09:26:11 v240 PCI1(PBMA): Bus running at 66MHz
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 2] slot[ 2] map[0] to INO[08]
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 2] slot[ 2] map[0] to INO[09]
Mar  4 09:26:11 v240 PCI0(PBMB): Bus running at 66MHz
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 3] slot[ a] map[0] to INO[27]
Mar  4 09:26:11 v240 PCI-IRQ: Routing bus[ 3] slot[ d] map[0] to INO[18]
Mar  4 09:26:11 v240 PCI0(PBMA): Bus running at 33MHz
Mar  4 09:26:11 v240 isa0: [flashprom] [rtc] [i2c -> (i2c-bridge) (i2c-brid=
ge) (motherboard-fru-prom) (chassis-fru-prom) (power-supply-fru-prom) (powe=
r-supply-fru-prom) (dimm-spd) (dimm-spd)
(dimm-spd) (dimm-spd) (rscrtc) (nvram) (idprom) (gpio) (gpio) (gpio) (gpio)=
 (gpio) (gpio)] [power] [serial] [serial] [rmc-comm]
Mar  4 09:26:11 v240 ebus: No EBus's found.
Mar  4 09:26:11 v240 PCIO serial driver version 1.54
Mar  4 09:26:11 v240 su(serial) at 0x7fe010003f8 (tty 0 irq 4,7ac) is a 165=
50A
Mar  4 09:26:11 v240 su(serial) at 0x7fe010002e8 (tty 1 irq 4,7ac) is a 165=
50A
Mar  4 09:26:11 v240 Linux NET4.0 for Linux 2.4
Mar  4 09:26:11 v240 Based upon Swansea University Computer Society NET3.039
Mar  4 09:26:11 v240 Initializing RT netlink socket
Mar  4 09:26:11 v240 Starting kswapd
Mar  4 09:26:11 v240 Journalled Block Device driver loaded
Mar  4 09:26:11 v240 devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.cs=
iro.au)
Mar  4 09:26:11 v240 devfs: boot_options: 0x1
Mar  4 09:26:11 v240 i2c-core.o: i2c core module version 2.6.1 (20010830)
Mar  4 09:26:11 v240 i2c-dev.o: i2c /dev entries driver module version 2.6.=
1 (20010830)
Mar  4 09:26:11 v240 i2c-core.o: driver i2c-dev dummy driver registered.
Mar  4 09:26:11 v240 i2c-algo-bit.o: i2c bit algorithm module
Mar  4 09:26:11 v240 i2c-proc.o version 2.6.1 (20010830)
Mar  4 09:26:11 v240 pty: 256 Unix98 ptys configured
Mar  4 09:26:11 v240 Real Time Clock Driver v1.10f
Mar  4 09:26:11 v240 tg3.c:v3.15 (January 6, 2005)
Mar  4 09:26:11 v240 eth0: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PC=
I:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:03:ba:5f:9c:13
Mar  4 09:26:11 v240 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0=
] WireSpeed[1] TSOcap[0]
Mar  4 09:26:11 v240 eth1: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PC=
I:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:03:ba:5f:9c:14
Mar  4 09:26:11 v240 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0=
] WireSpeed[1] TSOcap[0]
Mar  4 09:26:11 v240 eth2: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PC=
I:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:03:ba:5f:9c:11
Mar  4 09:26:11 v240 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0=
] WireSpeed[1] TSOcap[0]
Mar  4 09:26:11 v240 eth3: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PC=
I:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:03:ba:5f:9c:12
Mar  4 09:26:11 v240 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0=
] WireSpeed[1] TSOcap[0]
Mar  4 09:26:11 v240 SCSI subsystem driver Revision: 1.00
Mar  4 09:26:11 v240 sym.1.2.0: setting PCI_COMMAND_INVALIDATE.
Mar  4 09:26:11 v240 sym.1.2.1: setting PCI_COMMAND_INVALIDATE.
Mar  4 09:26:11 v240 sym0: <1010-66> rev 0x1 on pci bus 1 device 2 function=
 0 irq 4,729
Mar  4 09:26:11 v240 sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
Mar  4 09:26:11 v240 sym0: SCSI BUS has been reset.
Mar  4 09:26:11 v240 sym1: <1010-66> rev 0x1 on pci bus 1 device 2 function=
 1 irq 4,728
Mar  4 09:26:11 v240 sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
Mar  4 09:26:11 v240 sym1: SCSI BUS has been reset.
Mar  4 09:26:11 v240 scsi0 : sym-2.1.17a
Mar  4 09:26:11 v240 scsi1 : sym-2.1.17a
Mar  4 09:26:11 v240 Vendor: FUJITSU   Model: MAP3367N SUN36G   Rev: 0401
Mar  4 09:26:11 v240 Type:   Direct-Access                      ANSI SCSI r=
evision: 04
Mar  4 09:26:11 v240 Vendor: FUJITSU   Model: MAP3367N SUN36G   Rev: 0401
Mar  4 09:26:11 v240 Type:   Direct-Access                      ANSI SCSI r=
evision: 04
Mar  4 09:26:11 v240 sym0:0:0: tagged command queuing enabled, command queu=
e depth 16.
Mar  4 09:26:11 v240 sym0:1:0: tagged command queuing enabled, command queu=
e depth 16.
Mar  4 09:26:11 v240 Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Mar  4 09:26:11 v240 Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Mar  4 09:26:11 v240 sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offse=
t 31)
Mar  4 09:26:11 v240 SCSI device sda: 71132959 512-byte hdwr sectors (36420=
 MB)
Mar  4 09:26:11 v240 Partition check:
Mar  4 09:26:11 v240 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
Mar  4 09:26:11 v240 sym0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offse=
t 31)
Mar  4 09:26:11 v240 SCSI device sdb: 71132959 512-byte hdwr sectors (36420=
 MB)
Mar  4 09:26:11 v240 /dev/scsi/host0/bus0/target1/lun0: p1 p3
Mar  4 09:26:11 v240 NET4: Linux TCP/IP 1.0 for NET4.0
Mar  4 09:26:11 v240 IP Protocols: ICMP, UDP, TCP, IGMP
Mar  4 09:26:11 v240 IP: routing cache hash table of 16384 buckets, 256Kbyt=
es
Mar  4 09:26:11 v240 TCP: Hash tables configured (established 262144 bind 6=
5536)
Mar  4 09:26:11 v240 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Mar  4 09:26:11 v240 kjournald starting.  Commit interval 5 seconds
Mar  4 09:26:11 v240 EXT3-fs: mounted filesystem with ordered data mode.
Mar  4 09:26:11 v240 VFS: Mounted root (ext3 filesystem) readonly.
Mar  4 09:26:11 v240 Mounted devfs on /dev
Mar  4 09:26:11 v240 Adding Swap: 499776k swap-space (priority -1)
Mar  4 09:26:11 v240 EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,4), interna=
l journal
Mar  4 09:26:11 v240 kjournald starting.  Commit interval 5 seconds
Mar  4 09:26:11 v240 EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,17), intern=
al journal
Mar  4 09:26:11 v240 EXT3-fs: mounted filesystem with ordered data mode.
Mar  4 09:26:11 v240 TOMATILLO1 PBMB: PCI Error, primary error type[Excessi=
ve Retries]
Mar  4 09:26:11 v240 TOMATILLO1 PBMB: bytemask[0000] was_block(0) space(Con=
fig)
Mar  4 09:26:11 v240 TOMATILLO1 PBMB: PCI AFAR [0000000000002084]
Mar  4 09:26:11 v240 TOMATILLO1 PBMB: PCI Secondary errors [(none)]
Mar  4 09:26:11 v240 tg3: eth0: Link is up at 100 Mbps, half duplex.
Mar  4 09:26:11 v240 tg3: eth0: Flow control is off for TX and off for RX.
Mar  4 09:26:11 v240 envctrl: I2C device not found.
Mar  4 09:26:11 v240 kjournald starting.  Commit interval 5 seconds
Mar  4 09:26:11 v240 EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), interna=
l journal
Mar  4 09:26:11 v240 EXT3-fs: mounted filesystem with ordered data mode.
Mar  4 10:50:07 v240 CPU[0]: Cheetah+ D-cache parity error at TPC[000000000=
04606c0]
Mar  4 12:22:54 v240 CPU[1]: Cheetah+ D-cache parity error at TPC[000000000=
05ae90c]
Mar  4 13:31:44 v240 ERROR(0): Cheetah error trap taken afsr[80101000000000=
00] afar[000000009af900e0] TL1(1)
Mar  4 13:31:44 v240 ERROR(0): TPC[0000000000408d24] TNPC[0000000000408d28]=
 TSTATE[0000009911049406]
Mar  4 13:31:44 v240 ERROR(0): M_SYND(0),  E_SYND(0), Privileged
Mar  4 13:31:44 v240 ERROR(0): Highest priority error (0000100000000000) "U=
nmapped error from system bus"
Mar  4 13:31:44 v240 ERROR(0): D-cache idx[80e0] tag[000000000009af91] utag=
[0000000000003300] stag[000000000009af90]
Mar  4 13:31:44 v240 ERROR(0): D-cache data0[00135f2070178a14] data1[004b20=
8c004b1f44] data2[0000000000030419] data3[0000000000030419]
Mar  4 13:31:44 v240 ERROR(0): I-cache idx[0] tag[0000000000000000] utag[00=
00000000000000] stag[0000000000000000] u[0000000000000000] l[00000000000000=
00]
Mar  4 13:31:44 v240 ERROR(0): I-cache INSN0[0000000000000000] INSN1[000000=
0000000000] INSN2[0000000000000000] INSN3[0000000000000000]
Mar  4 13:31:44 v240 ERROR(0): I-cache INSN4[0000000000000000] INSN5[000000=
0000000000] INSN6[0000000000000000] INSN7[0000000000000000]
Mar  4 13:31:44 v240 ERROR(0): E-cache idx[9af900e0] tag[0010100000000000]
Mar  4 13:31:44 v240 ERROR(0): E-cache data0[106ff8c18f414000] data1[921000=
1494100015] data2[40002c549003a8bf] data3[306ff9da86102018]
Mar  4 13:31:44 v240 Kernel panic: Irrecoverable deferred error trap.
Mar  4 13:31:44 v240
Mar  4 13:31:45 v240 Press L1-A to return to the boot prom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCMe88FAhB33r2ACYRAjcJAJ9WH/gSvsNZVgPQyDy+cfeGHWfcPwCcCVzz
tmKo+pmumZNVS2mrRsiITFs=3DiORx
-----END PGP SIGNATURE-----
