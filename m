From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 23 Sep 2008 22:12:35 +0000
Subject: Re: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20080923221235.GA17710@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
List-Id: <sparclinux.vger.kernel.org>
References: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
To: sparclinux@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry guys, have been interrupted while composing the first mail. Now with attachements,
  Hermann

----- Forwarded message from Hermann Lauer <hlauer@lemon.iwr.uni-heidelberg.de> -----

Date: Tue, 23 Sep 2008 15:31:52 +0200
From: Hermann Lauer <hlauer@lemon.iwr.uni-heidelberg.de>
To: sparclinux@vger.kernel.org
Subject: kernel crashes on Sun Fire 480R with cassini network driver
User-Agent: Mutt/1.4.2.1i

Dear list members,

while trying to run vanilla linux-2.6.26.5 or the debian etchnhalf kernel
(2.6.24.x) I noticed the cassini network driver for the builtin gigabit
network is unstable and brings the kernel down on a dualprocessor sparc
SunFire 480R with a Hardware FATAL RESET.

Serial output (until the System JTAG SCAN Dump from OBP starts) and 
the output of dmesg is attached. 
Please tell me what else would be useful for
debugging.

Thanks for any help,
 greetings
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de

----- End forwarded message -----

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="serial.out"

ERROR: System Hardware FATAL RESET from  CPU2


System State (CPU2 reporting)

  BBC Devices: 0000.0000.0000.0005
  BBC Arb:     0000.0000.0000.000f
  BBC Quiesce: 0000.0000.0000.0009
  BBC WDogAct: 0000.0000.0000.0000
  BBC POR Gen: 0000.0000.0000.0000
  BBC XIR Gen: 0000.0000.0000.0000
  BBC POR Src: 0000.0000.0000.0400
  BBC XIR Src: 0000.0000.0000.0000
  BBC EBus TC: 014f.99fd.a7e6.3f29

CPU0 Config/Control/Status registers: 

  CPUVersion:  003e.0015.2300.0507
  SafConfig:   0caa.01bc.0001.0002 6:1 ID:0 HBM TOL:15
  SafBaseAdr:  0000.0400.0000.0000
  DispatchCtl: 0000.0000.0000.0000
  DCacheCtl:   0000.0000.0000.0000
  ECacheCtl:   0000.0000.0329.4400 3:1 8MB mode=4-3-3(1) R/W-turn:2 Late-Sel ECC:on
  ErrorEnable: 0000.0000.0000.000b CEEN NCEEN UCEEN

  AFAR:        0000.0000.0000.0000
  AFSR:        0000.0000.0000.0000 (no errors set)
  AFAR 2:      0000.0000.0000.0000
  AFSR 2:      0000.0000.0000.0000 (no errors set)

  DMMU SFAR:   0000.0000.0003.0900
  DMMU SFSR:   0000.0000.0080.8000 TM
  IMMU SFSR:   0000.0000.0080.8000 TM

CPU0 Trap registers:  Trap Level = 5

  TL=1 TT:     0000.0000.0000.00c0
       TSTATE: 0000.0099.1100.9601 XCC:NC ICC:NC PEF PRIV IE
       TPC:    0000.0000.0042.7e50
       TnPC:   0000.0000.0042.7e54
  TL=2 TT:     0000.0000.0000.006c
       TSTATE: 0000.0044.1100.9507 XCC:Z ICC:Z PEF PRIV AG
       TPC:    0000.0000.0042.1504
       TnPC:   0000.0000.0042.157c
  TL=3 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
  TL=4 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
 *TL=5 TT:     0000.0000.0000.0001
       TSTATE: 0000.0044.1100.9601 XCC:Z ICC:Z PEF PRIV IE
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0004

CPU0 General registers: 

  %PIL:        0
  %PC:         0000.0000.0000.0000
  %nPC:        0000.0000.0000.0004
  %PSTATE:     0000.0000.0000.0035 MM=TSO IE
  %CCR:        0000.0000.0000.0000 XCC:(clear) ICC:(clear)
  %FPRS:       0000.0000.0000.0000

  %v0: 0000.0000.0000.0000  %v1: 0000.00a1.fa75.e000  %v2: 0000.00a0.007e.8000
  %v3: 0000.0000.0000.0000  %v4: 0000.0000.0040.0000  %v5: 0000.0000.0000.0000
  %v6: 0000.0000.0082.6360  %v7: 0000.0000.0000.0000

  %m0: 0000.0000.0000.0000  %m1: 0000.00a1.fa1c.01d0  %m2: 0000.0000.0000.00c0
  %m3: 0000.0000.0000.0004  %m4: 0000.0000.0000.1000  %m5: 8000.00a1.fdf2.d6b0
  %m6: 0000.0000.0000.0000  %m7: 0000.00a1.fa86.4000

  %a0: 0000.0000.0000.0000  %a1: 0000.0000.0000.0400  %a2: 0000.0000.0000.0000
  %a3: 0000.0000.57ac.6c00  %a4: 0000.0000.0000.0002  %a5: 0000.0000.0000.000c
  %a6: 0000.0000.0042.7da4  %a7: ffff.ffff.f001.eea4

  %g0: 0000.0000.0000.0000  %g1: 0000.0000.0079.e000  %g2: 0000.0211.0000.4000
  %g3: 0000.0000.0000.0000  %g4: ffff.f8a1.ff05.a640  %g5: ffff.f8a1.ff13.8000
  %g6: ffff.f8a1.ff0a.0000  %g7: 0000.0000.0000.0001

  %o0: ffff.f8a1.ff95.8380  %o1: ffff.f8a1.ff0a.0008  %o2: 0000.0000.0000.0001
  %o3: 0000.0000.007d.e000  %o4: ffff.f8a1.ff95.82d0  %o5: 0000.0033.69a8.c400
  %o6: ffff.f8a1.ff0a.3681  %o7: 0000.0000.0042.7da4

  %l0: 0000.0000.0000.0000  %l1: 0000.0000.007d.e2d0  %l2: 0000.0000.0000.0000
  %l3: 0800.0000.0000.0000  %l4: 0000.0000.fff6.acf8  %l5: 0000.0000.0000.0001
  %l6: 0000.0000.0000.0000  %l7: 0000.07ff.f001.6adc

  %i0: 0000.0000.0000.0000  %i1: 0000.0000.0000.0016  %i2: 0000.0000.0000.0000
  %i3: 0000.0000.0000.0000  %i4: 0000.0000.0000.0000  %i5: 0000.0000.0000.0000
  %i6: ffff.f8a1.ff0a.3741  %i7: 0000.0000.0081.25d8

CPU0 Mem Ctrl registers: 

  Mem Time Ctl1:  1070.02c8.20c3.135a
  Mem Time Ctl2:  2dc8.9821.592b.0020
  Mem Time Ctl3:  1060.03c7.1c82.0360
  Mem Time Ctl4:  1d28.7ec0.38e7.0020
  Mem Addr Dec1:  8000.fe02.8002.0000
  Mem Addr Dec2:  8000.fe02.8002.0200
  Mem Addr Dec3:  8000.fe02.8002.0400
  Mem Addr Dec4:  8000.fe02.8002.0600
  Mem Addr Ctl:   5b04.1128.4422.1108

CPU2 Config/Control/Status registers: 

  CPUVersion:  003e.0015.2300.0507
  SafConfig:   1534.01bc.0005.0002 6:1 ID:2 HBM TOL:15
  SafBaseAdr:  0000.0400.0100.0000
  DispatchCtl: 0000.0000.0000.0000
  DCacheCtl:   0000.0000.0000.0000
  ECacheCtl:   0000.0000.0329.4400 3:1 8MB mode=4-3-3(1) R/W-turn:2 Late-Sel ECC:on
  ErrorEnable: 0000.0000.0000.000b CEEN NCEEN UCEEN

  AFAR:        0000.07fc.0020.0000
  AFSR:        0008.0000.0000.0000 PERR
  AFAR 2:      0000.07fc.0020.0000
  AFSR 2:      0008.0000.0000.0000 PERR

  DMMU SFAR:   0000.0000.0005.b800
  DMMU SFSR:   0000.0000.0080.8000 TM
  IMMU SFSR:   0000.0000.0080.8000 TM

CPU2 Trap registers:  Trap Level = 5

  TL=1 TT:     0000.0000.0000.0045
       TSTATE: 0000.0000.8000.9601 XCC:(clear) ICC:(clear) PEF PRIV IE
       TPC:    0000.0000.006c.0d20
       TnPC:   0000.0000.0042.08b0
  TL=2 TT:     0000.0000.0000.0068
       TSTATE: 0000.0000.1000.9504 XCC:(clear) ICC:(clear) PEF PRIV AG
       TPC:    0000.0000.0042.1b84
       TnPC:   0000.0000.0042.1b88
  TL=3 TT:     0000.0000.0000.0068
       TSTATE: 0000.0080.5804.1403 XCC:N ICC:(clear) MM=TSO PEF PRIV
       TPC:    0000.0000.f004.9e98
       TnPC:   0000.0000.f004.9e9c
  TL=4 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
 *TL=5 TT:     0000.0000.0000.0001
       TSTATE: 0000.0044.8000.9605 XCC:Z ICC:Z PEF PRIV IE
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0004

CPU2 General registers: 

  %PIL:        0
  %PC:         0000.0000.0000.0000
  %nPC:        0000.0000.0000.0004
  %PSTATE:     0000.0000.0000.0035 MM=TSO IE
  %CCR:        0000.0000.0000.0000 XCC:(clear) ICC:(clear)
  %FPRS:       0000.0000.0000.0000

  %v0: 0000.0000.0000.0000  %v1: 0000.0000.0000.0200  %v2: 0000.00a0.007e.8000
  %v3: 0000.00a0.007e.a480  %v4: 0000.0000.0040.0000  %v5: 0000.0000.0000.0000
  %v6: 0000.0000.0082.6560  %v7: 0000.0000.0000.0000

  %m0: 0000.0000.0000.0000  %m1: 0000.00a1.fa1c.15b0  %m2: 0000.03ff.ffe2.87fd
  %m3: 0000.0000.0000.0004  %m4: 0000.0000.0000.1000  %m5: 8000.00a1.fccb.b6b0
  %m6: 0000.0000.0000.03df  %m7: 0000.00a1.fa86.c000

  %a0: 0000.0000.0000.0000  %a1: 0000.0000.0000.0400  %a2: 0000.0000.0000.0000
  %a3: 0000.0000.57ac.6c00  %a4: 0000.0000.0000.1000  %a5: 0000.0000.0000.000c
  %a6: ffff.f8a1.fc09.6000  %a7: ffff.ffff.f001.eea4

  %g0: 0000.0000.0000.0000  %g1: 0000.07fc.0020.000c  %g2: 0000.0000.0000.0100
  %g3: 0000.0000.0000.0400  %g4: ffff.f8a1.ff08.4c20  %g5: ffff.f8a1.ff14.8000
  %g6: ffff.f8a1.fb1c.4000  %g7: 0000.0000.0082.1b00

  %o0: 0000.ff00.0000.0000  %o1: 00ff.0000.0000.0000  %o2: 0000.00ff.0000.0000
  %o3: 0000.0000.ff00.0000  %o4: 0000.0000.00ff.0000  %o5: 0000.0000.0000.ff00
  %o6: ffff.f8a1.ffad.f471  %o7: ffff.f8a1.fc09.6000

  %l0: 0000.0000.0000.0501  %l1: ffff.f8a1.ff33.e400  %l2: 0000.0000.0000.000f
  %l3: ffff.f8a1.ff60.7ee0  %l4: ffff.f8a1.ff33.eeb8  %l5: ffff.f8a1.fdbe.8000
  %l6: ffff.f8a1.fb1c.4000  %l7: 0000.0000.0044.0320

  %i0: ffff.f8a1.fc03.06c0  %i1: ffff.f8a1.fc03.0000  %i2: 0000.0000.0000.0000
  %i3: 0000.0000.c1fb.8002  %i4: 0000.0000.0100.0000  %i5: 0000.0000.0000.0000
  %i6: ffff.f8a1.ffad.f5c1  %i7: 0000.0000.0049.1070

CPU2 Mem Ctrl registers: 

  Mem Time Ctl1:  1070.02c8.20c3.135a
  Mem Time Ctl2:  2dc8.9821.592b.0020
  Mem Time Ctl3:  1060.03c7.1c82.0360
  Mem Time Ctl4:  1d28.7ec0.38e7.0020
  Mem Addr Dec1:  8000.fe02.8002.0100
  Mem Addr Dec2:  8000.fe02.8002.0300
  Mem Addr Dec3:  8000.fe02.8002.0500
  Mem Addr Dec4:  8000.fe02.8002.0700
  Mem Addr Ctl:   5b04.1128.4422.1108

IO-Bridge 8 at 0000.0400.0400.0000
  Device ID  fc00.0000.0011.a954
  Ctl/Stat   0255.5554.0080.7e02
  Error Ctl  7c00.0000.0000.03e7
  Int Ctl    0000.0000.0000.0017
  Error Log  0000.0000.0000.0000
  ECC Ctl    0000.0000.0000.0000
  EStar Ctl  0000.0000.0000.0001
  Queue Ctl  0000.0000.0000.0000

                 Address Match       Address Mask
  PCIA Mem   0000.07fd.0000.0000 0000.07ff.0000.0000
  PCIA C/IO  0000.07ff.ec00.0000 0000.07ff.fe00.0000
  PCIB Mem   0000.07fe.0000.0000 0000.07ff.0000.0000
  PCIB C/IO  0000.07ff.ee00.0000 0000.07ff.fe00.0000

                    AFAR                AFSR
  UE         0000.0400.0102.0010 0000.00c0.4002.01b8
  CE         0000.0a01.0408.e420 0000.0004.1000.0020
  PCI A      0000.0000.0000.0000 0000.0000.0000.0000
  PCI B      0000.0000.0000.0000 0000.0000.0000.0000

                Control/Status      Idle Check Diag       Diagnostic
  PCI A       0000.0002.0000.0000 0000.0000.0000.0000 0000.0000.0000.0000
  PCI B       0000.0000.0000.0000 0000.0000.0000.0000 0000.0000.0000.0000


IO-Bridge 9 at 0000.0400.0480.0000
  Device ID  fc00.0000.0013.a954
  Ctl/Stat   0255.59a8.0090.7e02
  Error Ctl  7c00.0000.0000.03e7
  Int Ctl    0000.0000.0000.0017
  Error Log  0000.0000.0000.0000
  ECC Ctl    0000.0000.0000.0000
  EStar Ctl  0000.0000.0000.0001
  Queue Ctl  0000.0000.0000.0000

                 Address Match       Address Mask
  PCIA Mem   0000.07fb.0000.0000 0000.07ff.0000.0000
  PCIA C/IO  0000.07ff.e800.0000 0000.07ff.fe00.0000
  PCIB Mem   0000.07fc.0000.0000 0000.07ff.0000.0000
  PCIB C/IO  0000.07ff.ea00.0000 0000.07ff.fe00.0000

                    AFAR                AFSR
  UE         0000.0408.0000.0000 0000.0000.8606.2008
  CE         0000.0000.0900.0000 0000.0020.0004.005a
  PCI A      0000.0000.0000.0000 0000.0000.0000.0000
  PCI B      0000.0000.0000.0000 0000.0000.0000.0000

                Control/Status      Idle Check Diag       Diagnostic
  PCI A       0000.0002.0000.0000 0000.0000.0000.0000 0000.0000.0000.0000
  PCI B       0000.0000.0000.0000 0000.0000.0000.0000 0000.0000.0000.0000

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.out"

~ # dmesg
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26.5 (hlauer@nano2) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #4 SMP Thu Sep 11 09:20:19 CEST 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:29:7c:9f
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 101768 bytes of memory.
[    0.000000] Top of RAM: 0xa1ffb22000, Total RAM: 0x1ffad6000
[    0.000000] Memory hole size: 655360MB
[    0.000000] Entering add_active_range(0, 83886080, 84932607) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 84932608, 84933932) 1 entries of 256 used
[    0.000000] Entering add_active_range(0, 84933968, 84934031) 2 entries of 256 used
[    0.000000] Entering add_active_range(0, 84934032, 84934033) 3 entries of 256 used
[    0.000000] [0000000318000000-fffff8a000800000] page_structs=131072 node=0 entry=1120/0
[    0.000000] [0000000318000000-fffff8a000c00000] page_structs=131072 node=0 entry=1121/0
[    0.000000] [0000000318700000-fffff8a001000000] page_structs=131072 node=0 entry=1122/0
[    0.000000] [0000000318700000-fffff8a001400000] page_structs=131072 node=0 entry=1123/0
[    0.000000] [0000000318e00000-fffff8a001800000] page_structs=131072 node=0 entry=1124/0
[    0.000000] [0000000318e00000-fffff8a001c00000] page_structs=131072 node=0 entry=1125/0
[    0.000000] [0000000319500000-fffff8a002000000] page_structs=131072 node=0 entry=1126/0
[    0.000000] [0000000319c00000-fffff8a002400000] page_structs=131072 node=0 entry=1127/0
[    0.000000] [0000000319c00000-fffff8a002800000] page_structs=131072 node=0 entry=1128/0
[    0.000000] [000000031a300000-fffff8a002c00000] page_structs=131072 node=0 entry=1129/0
[    0.000000] [000000031a300000-fffff8a003000000] page_structs=131072 node=0 entry=1130/0
[    0.000000] [000000031aa00000-fffff8a003400000] page_structs=131072 node=0 entry=1131/0
[    0.000000] [000000031aa00000-fffff8a003800000] page_structs=131072 node=0 entry=1132/0
[    0.000000] [000000031b100000-fffff8a003c00000] page_structs=131072 node=0 entry=1133/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   83886080 -> 84934033
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 83886080 -> 84932607
[    0.000000]     0: 84932608 -> 84933932
[    0.000000]     0: 84933968 -> 84934031
[    0.000000]     0: 84934032 -> 84934033
[    0.000000] On node 0 totalpages: 1047915
[    0.000000]   Normal zone: 7164 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 1040751 pages, LIFO batch:15
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1040751
[    0.000000] Kernel command line: -p suite=etch BOOT_DEBUG=3 console=/dev/ttyS0,9600
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[  116.977685] clocksource: mult[640000] shift[16]
[  117.031758] clockevent: mult[28f5c28] shift[32]
[  117.085995] Console: colour dummy device 80x25
[  117.147245] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
[  117.252456] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
[  118.296882] Memory: 8303400k available (2888k kernel code, 1088k data, 208k init) [fffff80000000000,000000a1ffb22000]
[  118.501680] Calibrating delay using timer specific routine.. 19.86 BogoMIPS (lpj=39726)
[  118.595867] Security Framework initialized
[  118.644674] SELinux:  Disabled at boot.
[  118.690500] Capability LSM initialized
[  118.735339] Mount-cache hash table entries: 512
[  118.789945] Initializing cgroup subsys ns
[  118.837386] Initializing cgroup subsys cpuacct
[  118.890502] Initializing cgroup subsys devices
[  118.945452] CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
[  118.945469] Brought up 2 CPUs
[  118.945502] CPU0 attaching sched-domain:
[  118.945513]  domain 0: span 0,2
[  118.945519]   groups: 0 2
[  118.945530] CPU2 attaching sched-domain:
[  118.945536]  domain 0: span 0,2
[  118.945540]   groups: 2 0
[  118.946282] net_namespace: 1224 bytes
[  119.123250] NET: Registered protocol family 16
[  119.192137] PCI: Probing for controllers.
[  119.238360] /pci@8,700000: SCHIZO PCI Bus Module ver[4:0]
[  119.302926] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]
[  119.378379] /pci@8,600000: SCHIZO PCI Bus Module ver[4:0]
[  119.441168] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]
[  119.516618] /pci@9,700000: SCHIZO PCI Bus Module ver[4:0]
[  119.579396] /pci@9,700000: PCI IO[7ffeb000000] MEM[7fc00000000]
[  119.654855] /pci@9,600000: SCHIZO PCI Bus Module ver[4:0]
[  119.717633] /pci@9,600000: PCI IO[7ffe9000000] MEM[7fb00000000]
[  119.793063] PCI: Scanning PBM /pci@9,600000
[  119.842177] PCI: Scanning PBM /pci@9,700000
[  119.892150] PCI: Scanning PBM /pci@8,600000
[  119.942385] PCI: Scanning PBM /pci@8,700000
[  119.991916] ebus0: [flashprom] [bbc] [power] [i2c -> (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (nvram) (idprom) (fru) (fru)] [i2c -> (temperature) (temperature) (ioexp) (ioexp) (ioexp) (ioexp) (ioexp) (ioexp) (ioexp) (temperature-sensor) (fru) (fru) (fru) (fru) (fru) (rscrtc)] [rtc] [gpio] [pmc] [rsc-control] [rsc-console] [serial]
[  120.405983] power: Control reg at 7fc7e30002e
[  120.463193] SCSI subsystem initialized
[  120.506940] usbcore: registered new interface driver usbfs
[  120.572125] usbcore: registered new interface driver hub
[  120.635591] usbcore: registered new device driver usb
[  120.735909] /pci@9,700000/ebus@1/rtc@1,300070: Clock regs at 000007fc7e300070
[  120.821608] NET: Registered protocol family 2
[  120.871971] Switched to high resolution mode on CPU 2
[  122.344516] Switched to high resolution mode on CPU 0
[  122.414192] IP route cache hash table entries: 262144 (order: 8, 2097152 bytes)
[  122.502857] TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
[  122.621971] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[  122.705387] TCP: Hash tables configured (established 524288 bind 65536)
[  122.782793] TCP reno registered
[  122.830278] NET: Registered protocol family 1
[  122.880979] checking if image is initramfs... it is
[  123.678190] Freeing initrd memory: 3329k freed
[  123.729999] Mini RTC Driver
[  123.763260] /memory-controller@0,400000: US3 memory controller at 0000040000400000 [ACTIVE]
[  123.862957] /memory-controller@2,400000: US3 memory controller at 0000040001400000 [ACTIVE]
[  123.963942] audit: initializing netlink socket (disabled)
[  124.027568] type=2000 audit(1221119794.495:1): initialized
[  124.094330] Total HugeTLB memory allocated, 0
[  124.145703] VFS: Disk quotas dquot_6.5.1
[  124.192312] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[  124.270504] msgmni has been set to 16225
[  124.317645] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[  124.405717] io scheduler noop registered
[  124.452555] io scheduler anticipatory registered
[  124.507765] io scheduler deadline registered
[  124.558914] io scheduler cfq registered (default)
[  128.864465] Console: switching to mono PROM 80x34
[  133.154607] [drm] Initialized drm 1.1.0 20060810
[  133.210495] f00bf958: ttyS0 at MMIO 0x7fc7e400000 (irq = 21) is a SAB82532 V3.2
[  133.296966] Console: ttyS0 (SAB82532)
[  133.340799] console handover: boot [earlyprom0] -> real [ttyS0]
[  133.410085] f00bf958: ttyS1 at MMIO 0x7fc7e400040 (irq = 21) is a SAB82532 V3.2
[  133.502961] brd: module loaded
[  133.541097] loop: module loaded
[  133.577789] cassini.c:v1.6 (21 May 2008)
[  133.624492] PCI: Enabling device: (0003:00:01.0), cmd 146
[  133.627670] cassini: MAC address not found in ROM VPD
[  133.688385] eth0: Sun Cassini+ (64bit/66MHz PCI/Cu) Ethernet[29] 08:00:20:65:25:7a
[  133.779102] PCI: Enabling device: (0002:00:02.0), cmd 146
[  133.782298] cassini: MAC address not found in ROM VPD
[  133.843032] eth1: Sun Cassini+ (64bit/33MHz PCI/Cu) Ethernet[23] 08:00:20:78:cc:21
[  133.933962] Uniform Multi-Platform E-IDE driver
[  133.987217] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  134.084467] Driver 'sd' needs updating - please use bus_type methods
[  134.160641] mice: PS/2 mouse device common for all mice
[  134.223208] usbcore: registered new interface driver usbhid
[  134.289106] usbhid: v2.6:USB HID core driver
[  134.341527] TCP cubic registered
[  134.379108] NET: Registered protocol family 17
[  134.432725] registered taskstats version 1
[  134.481461] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

--wac7ysb48OaltWcw--
