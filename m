From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 24 Oct 2008 15:24:33 +0000
Subject: Re: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20081024152433.GA1803@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello all,

On Mon, Sep 29, 2008 at 10:19:54AM +0200, Hermann Lauer wrote:
> > while trying to run vanilla linux-2.6.26.5 or the debian etchnhalf kernel
> > (2.6.24.x) I noticed the cassini network driver for the builtin gigabit
> > network is unstable and brings the kernel down on a dualprocessor sparc
> > SunFire 480R with a Hardware FATAL RESET.
> 
> I now noticed that even a few pings are possible with the cassini
> network driver if you configure it statically, but then the machine again 
> crashes with the known: 
> ERROR: System Hardware FATAL RESET from  CPU0 CPU2

tried 2.6.27.2 today, but this hangs already at loading the kernel.
Output is attached. Please tell me what else I can provide.

Thanks,
  Hermann

Rebooting with command: boot net:dhcp -p suite=etch BOOT_DEBUG=2 console=/dev/ttyS0,9600
Boot device: /pci@9,700000/network@2:dhcp  File and args: -p suite=etch BOOT_DEBUG=2 console=/dev/ttyS0,9600
/pci@9,700000/network@2: 1000 Mbps full duplex link up
-
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27.2 (hlauer@install1) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Wed Oct 22 11:33:48 CEST 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:29:7c:9f
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 101718 bytes of memory.
[    0.000000] Top of RAM: 0xa0ffb22000, Total RAM: 0xffad6000
[    0.000000] Memory hole size: 655360MB
[    0.000000] [0000000318000000-fffff8a000800000] page_structs1072 node=0 entry20/0
[    0.000000] [0000000318000000-fffff8a000c00000] page_structs1072 node=0 entry21/0
[    0.000000] [0000000318700000-fffff8a001000000] page_structs1072 node=0 entry22/0
[    0.000000] [0000000318700000-fffff8a001400000] page_structs1072 node=0 entry23/0
[    0.000000] [0000000318e00000-fffff8a001800000] page_structs1072 node=0 entry24/0
[    0.000000] [0000000318e00000-fffff8a001c00000] page_structs1072 node=0 entry25/0
[    0.000000] [0000000319500000-fffff8a002000000] page_structs1072 node=0 entry26/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x05000000 -> 0x0507fd91
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x05000000 -> 0x0507f7ff
[    0.000000]     0: 0x0507f800 -> 0x0507fd2c
[    0.000000]     0: 0x0507fd50 -> 0x0507fd8f
[    0.000000]     0: 0x0507fd90 -> 0x0507fd91
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 520047
[    0.000000] Kernel command line: -p suite=etch BOOT_DEBUG=2 console=/dev/ttyS0,9600
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[640000] shift[16]
[    0.000000] clockevent: mult[28f5c28] shift[32]
[   44.605863] Console: colour dummy device 80x25
[   44.675397] Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
[   44.770529] Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
[   45.037252] Memory: 4143944k available (2928k kernel code, 1104k data, 208k init) [fffff80000000000,000000a0ffb22000]
[   45.242394] Calibrating delay using timer specific routine.. 19.94 BogoMIPS (lpj9882)
[   45.336754] Security Framework initialized
[   45.385494] SELinux:  Disabled at boot.
[   45.431376] Mount-cache hash table entries: 512
[   45.486255] Initializing cgroup subsys ns
[   45.533413] Initializing cgroup subsys cpuacct
[   45.586524] Initializing cgroup subsys devices
[   45.641866] CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
[   45.641885] Brought up 2 CPUs
[   45.642975] net_namespace: 1552 bytes
[   45.819677] NET: Registered protocol family 16

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
