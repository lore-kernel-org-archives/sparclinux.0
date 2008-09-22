From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 22 Sep 2008 04:41:43 +0000
Subject: Re: [Bugme-new] [Bug 11616] New: sata_via kernel panic (I believe
Message-Id: <20080921214143.b2faebc9.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun, 21 Sep 2008 19:55:04 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id616
> 
>            Summary: sata_via kernel panic (I believe related to IRQ sharing)
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.26.5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: SPARC64
>         AssignedTo: platform_sparc64@kernel-bugs.osdl.org
>         ReportedBy: vallesroc@gmail.com
> 
> 
> Latest working kernel version: -
> Earliest failing kernel version: 2.6.24
> Distribution: Gentoo ~sparc
> Hardware Environment: Sun Blade 2000, IDE/PATA/SATA adapter from via as a
> single PCI card.
> 
> Problem Description:
> SATA disk is detected properly and can be mounted and used, but it quickly
> stops working and causes a kernel panic.
> 
> Steps to reproduce:
> 1. boot linux
> 2. mount a filesystem that's in the SATA drive
> 3. access that filesystem (just a little is enough, doing an ls or two)
> 4. i/o to that disk stalls
> 5. a few seconds pass (maybe >10s)
> 6. kernel panic
> 
> Alternativelly, just hdparm -tT the disk; it induces a panic all the time
> 
> By unloading uhci_hcd and ehci_hcd it becomes a bit more stable, but still
> crashes by just doing ls in a few dirs.
> 
> The disk itself works fine when plugged in that same PCI card but USB2 (it's in
> an external enclosure... eSATA and USB2). It also works via eSATA in a
> different computer (x86).
> 
> Some information that might help:
> rvalles@hiyono ~ $ cat /proc/cpuinfo 
> cpu             : TI UltraSparc III+ (Cheetah+)
> fpu             : UltraSparc III+ integrated FPU
> prom            : OBP 4.16.4 2004/12/18 05:18
> type            : sun4u
> ncpus probed    : 2
> ncpus active    : 2
> D$ parity tl1   : 0
> I$ parity tl1   : 0
> Cpu0ClkTck      : 0000000001ad2748
> Cpu1ClkTck      : 0000000001ad2748
> MMU Type        : Cheetah+
> State:
> CPU0:           online
> CPU1:           online
> 
> hiyono ~ # cat /proc/ioports 
> 7fe0012e000-7fe0012e07f : 0000:00:03.0
> 7ffed000000-7ffedffffff : /pci@8,600000
>   7ffed000300-7ffed0003ff : qla2xxx
>   7ffed000400-7ffed0004ff : r8169
> 7ffef000000-7ffefffffff : /pci@8,700000
>   7ffef000300-7ffef0003ff : sym53c8xx
>   7ffef000400-7ffef0004ff : sym53c8xx
>   7ffef000500-7ffef00051f : uhci_hcd
>   7ffef000520-7ffef00053f : uhci_hcd
>   7ffef000540-7ffef00054f : sata_via
>   7ffef000550-7ffef00055f : sata_via
>   7ffef000560-7ffef00056f : sata_via
>   7ffef000570-7ffef00057f : sata_via
>   7ffef000580-7ffef00059f : sata_via
>   7ffef000600-7ffef0006ff : sata_via
> 
> hiyono ~ # cat /proc/interrupts 
>            CPU0       CPU1       
>   0:      38368      39062     <NULL>  timer
>   1:          0          0      sun4u  SCHIZO_PCIERR
>   2:          0          0      sun4u  SCHIZO_UE
>   3:          0          0      sun4u  SCHIZO_CE
>   4:          0          0      sun4u  SCHIZO_SERR
>   6:          0       1469      sun4u  bbc_i2c, bbc_i2c
>   7:          0          0      sun4u  cs4231(capture)
>   8:          0          0      sun4u  cs4231(play)
>  14:          0          3      sun4u  ohci1394
>  15:         35          0      sun4u  ohci_hcd:usb1
>  16:         91          0      sun4u  sym53c8xx
>  17:          0         30      sun4u  sym53c8xx
>  18:          0          0      sun4u  sata_via, uhci_hcd:usb3
>  19:          0          0      sun4u  uhci_hcd:usb4
>  20:          0          0      sun4u  ehci_hcd:usb2
>  21:        301         14      sun4u  eth1
>  24:       3325          0      sun4u  qla2xxx
>  25:        824          0      sun4u  eth0
> 
> (the panic, copied over ssh, since the system continues sort of working after
> it)
> [  294.453949] ERROR(1): Cheetah error trap taken afsr[0010080000000000]
> afar[000007ffef000580] TL1(0)
> [  294.453976] ERROR(1): TPC[10014a6c] TNPC[10014a70] O7[10014bd8]
> TSTATE[80f09602]
> [  294.453984] ERROR(1): TPC<ata_sff_irq_clear+0x14/0x20 [libata]>
> [  294.454163] ERROR(1): M_SYND(0),  E_SYND(0), Privileged
> [  294.454173] ERROR(1): Highest priority error (0000080000000000) "Bus error
> response from system bus"
> [  294.454184] ERROR(1): D-cache idx[0] tag[0000000000000000]
> utag[0000000000000000] stag[0000000000000000]
> [  294.454196] ERROR(1): D-cache data0[0000000000000000]
> data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
> [  294.454208] ERROR(1): I-cache idx[0] tag[0000000000000000]
> utag[0000000000000000] stag[0000000000000000] u[0000000000000000]
> l[0000000000000000]
> [  294.454221] ERROR(1): I-cache INSN0[0000000000000000]
> INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
> [  294.454233] ERROR(1): I-cache INSN4[0000000000000000]
> INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
> [  294.454244] ERROR(1): E-cache idx[ef000580] tag[0000000000000000]
> [  294.454253] ERROR(1): E-cache data0[0000000000000000]
> data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
> [  294.454266] Kernel panic - not syncing: Irrecoverable deferred error trap.
> [  294.454271]
> [  294.600021] Press Stop-A (L1-A) to return to the boot prom
> 
> hiyono ~ # lspci
> 0000:00:02.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 62)
> 0000:00:02.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 62)
> 0000:00:02.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 65)
> 0000:00:02.3 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID
> Controller (rev 50)
> 0000:00:03.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> (rev 24)
> 0000:00:05.0 Bridge: Sun Microsystems Computer Corp. RIO EBUS (rev 01)
> 0000:00:05.1 Ethernet controller: Sun Microsystems Computer Corp. RIO GEM (rev
> 01)
> 0000:00:05.2 FireWire (IEEE 1394): Sun Microsystems Computer Corp. RIO 1394
> (rev 01)
> 0000:00:05.3 USB Controller: Sun Microsystems Computer Corp. RIO USB (rev 01)
> 0000:00:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 37)
> 0000:00:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 37)
> 0001:00:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
> Gigabit Ethernet (rev 10)
> 0001:00:04.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel
> Adapter (rev 05)
> 

