From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Mon, 30 Sep 2013 20:14:01 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <5249DB89.7020309@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/30/2013 09:31 AM, David Miller wrote:
> This is a respin of the original page_offset and 64-bit page
> table changes with some minor changes and a bug fix:
>
> 1) Bob's ACKs for the first 6 patches added.
>
> 2) Don't use "UL" postfix for shift counts, there is code that
>     wants those to be "int", particularly printfs in mm/mm_init.c
>     that use the "%d" format specifier for SECTIONS_SHIFT.
>
> 3) Adjust VA_HOLE defines to match what the new 3-level page
>     tables can actually provide.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi,
Tested on 3 configurations, here is the result. I dont see exit_mmap 
warning anynmore.

And I think we need to increase NR_CPUS.

Thanks,
-Guru


On a T5:

Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 3.12.0
Loading initial ramdisk (30134996 bytes at 0x380004000000 phys, 
0x40C00000 virt)...
/
PROMLIB: Sun IEEE Boot Prom 'OBP 4.35.0.a 2013/03/01 14:53'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16mainline.sparc64 (root@xxx) (gcc version 4.4.7 
20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Mon Sep 30 14:31:28 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:10:e0:35:15:f6
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 967023 bytes of memory.
MDESC: Size is 812080 bytes.
PLATFORM: banner-name [SPARC T5-8]
PLATFORM: name [sun4v-platform]
PLATFORM: hostid [863515f6]
PLATFORM: serial# [003515f6]
PLATFORM: stick-frequency [3b9aca00]
PLATFORM: mac-address [10e03515f6]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [1024]
Ignoring CPU 64 which is >= NR_CPUS (64)
Ignoring CPU 65 which is >= NR_CPUS (64)




On a T4-1:

PROMLIB: Sun IEEE Boot Prom 'OBP 4.34.1 2012/08/01 12:19'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16mainline.sparc64 (root@xxx) (gcc version 4.4.7 
20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Mon Sep 30 14:31:28 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:21:28:e8:e9:da
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 166778 bytes of memory.
MDESC: Size is 60336 bytes.
PLATFORM: banner-name [SPARC T4-1]
PLATFORM: name [ORCL,SPARC-T4-1]
PLATFORM: hostid [85e8e9da]
PLATFORM: serial# [00e8e9da]
PLATFORM: stick-frequency [3b8f5850]
PLATFORM: mac-address [2128e8e9da]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [64]
Top of RAM: 0x7ffaf2000, Total RAM: 0x7df664000
Memory hole size: 516MB
Zone ranges:
   Normal   [mem 0x20400000-0x7ffaf1fff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x20400000-0x7ffa43fff]
   node   0: [mem 0x7ffa54000-0x7ffa67fff]
   node   0: [mem 0x7ffae6000-0x7ffaf1fff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 7 pages/cpu @ffff8007ef000000 s23296 r8192 d25856 u65536
SUN4V: Mondo queue sizes [cpu(8192) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4095291
Policy zone: Normal
Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS 
LANG=en_US.UTF-8 rd_NO_MD rd_LVM_LV=VolGroup/lv_swap 
SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root KEYBOARDTYPE=pc 
KEYTABLE=us rd_NO_DM
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 32735248K/33020304K available (5333K kernel code, 708K rwdata, 
2216K rodata, 488K init, 7896K bss, 285056K reserved)
Hierarchical RCU implementation.
NR_IRQS:255
clocksource: mult[801898] shift[23]
clockevent: mult[ffced917] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
PROMLIB: Sun IEEE Boot Prom 'OBP 4.34.1 2012/08/01 12:19'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16mainline.sparc64 (root@xx) (gcc version 4.4.7 
20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Mon Sep 30 14:31:28 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:21:28:e8:e9:da
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 166778 bytes of memory.
MDESC: Size is 60336 bytes.
PLATFORM: banner-name [SPARC T4-1]
PLATFORM: name [ORCL,SPARC-T4-1]
PLATFORM: hostid [85e8e9da]
PLATFORM: serial# [00e8e9da]
PLATFORM: stick-frequency [3b8f5850]
PLATFORM: mac-address [2128e8e9da]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [64]
Top of RAM: 0x7ffaf2000, Total RAM: 0x7df664000
Memory hole size: 516MB
Zone ranges:
   Normal   [mem 0x20400000-0x7ffaf1fff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x20400000-0x7ffa43fff]
   node   0: [mem 0x7ffa54000-0x7ffa67fff]
   node   0: [mem 0x7ffae6000-0x7ffaf1fff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 7 pages/cpu @ffff8007ef000000 s23296 r8192 d25856 u65536
SUN4V: Mondo queue sizes [cpu(8192) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4095291
Policy zone: Normal
Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS 
LANG=en_US.UTF-8 rd_NO_MD rd_LVM_LV=VolGroup/lv_swap 
SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root KEYBOARDTYPE=pc 
KEYTABLE=us rd_NO_DM
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 32735248K/33020304K available (5333K kernel code, 708K rwdata, 
2216K rodata, 488K init, 7896K bss, 285056K reserved)
Hierarchical RCU implementation.
NR_IRQS:255
clocksource: mult[801898] shift[23]
clockevent: mult[ffced917] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
allocated 67108864 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Calibrating delay using timer specific routine.. 2000.29 BogoMIPS 
(lpj@00592)
pid_max: default: 65536 minimum: 512
Security Framework initialized
SELinux:  Initializing.
Dentry cache hash table entries: 4194304 (order: 12, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 11, 16777216 bytes)
Mount-cache hash table entries: 512
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
Initializing cgroup subsys perf_event
Initializing cgroup subsys hugetlb
ftrace: allocating 19188 entries in 38 pages
Performance events: Supported PMU type is 'niagara4'
Brought up 64 CPUs
Testing NMI watchdog ... OK.
devtmpfs: initialized
ldc.c:v1.1 (July 22, 2008)
regulator-dummy: no parameters
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vldc-port-0-0
VIO: Adding device vldc-port-0-1
VIO: Adding device vldc-port-0-2
VIO: Adding device vldc-port-1-0
VIO: Adding device vldc-port-2-0
VIO: Adding device vldc-port-3-0
VIO: Adding device vldc-port-3-1
VIO: Adding device vldc-port-3-2
VIO: Adding device vldc-port-3-3
VIO: Adding device vldc-port-3-4
VIO: Adding device vldc-port-3-6
VIO: Adding device vlds-port-0-0
VIO: Adding device ds-0
VIO: Adding device ds-1
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out



On a t4-1 LDOM:

Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 3.12.0
Loading initial ramdisk (31813824 bytes at 0x54800000 phys, 0x40C00000 
virt)...
|
PROMLIB: Sun IEEE Boot Prom 'OBP 4.34.3.a 2013/07/29 13:21'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16mainline.sparc64 (root@xxxx) (gcc version 4.4.7 
20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Mon Sep 30 14:31:28 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:14:4f:fb:36:6f
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 25094 bytes of memory.
MDESC: Size is 9680 bytes.
PLATFORM: banner-name [SPARC T4-1]
PLATFORM: name [ORCL,SPARC-T4-1]
PLATFORM: hostid [84fb366f]
PLATFORM: serial# [000cf710]
PLATFORM: stick-frequency [3b8f5850]
PLATFORM: mac-address [144ffb366f]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [64]
Top of RAM: 0x14fe54000, Total RAM: 0xff744000
Memory hole size: 1287MB
Zone ranges:
   Normal   [mem 0x50400000-0x14fe53fff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x50400000-0x14fb3bfff]
   node   0: [mem 0x14fe4c000-0x14fe53fff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 7 pages/cpu @ffff80014cc00000 s23296 r8192 d25856 u65536
SUN4V: Mondo queue sizes [cpu(8192) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 519079
Policy zone: Normal
Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS 
LANG=en_US.UTF-8 KEYTABLE=us rd_NO_MD rd_LVM_LV=VolGroup/lv_swap 
SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root rd_NO_DM
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 4090816K/4185360K available (5333K kernel code, 708K rwdata, 
2216K rodata, 488K init, 7896K bss, 94544K reserved)
Hierarchical RCU implementation.
NR_IRQS:255
clocksource: mult[801898] shift[23]
clockevent: mult[ffced917] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
PROMLIB: Sun IEEE Boot Prom 'OBP 4.34.3.a 2013/07/29 13:21'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16mainline.sparc64 (root@xxx) (gcc version 4.4.7 
20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Mon Sep 30 14:31:28 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:14:4f:fb:36:6f
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 25094 bytes of memory.
MDESC: Size is 9680 bytes.
PLATFORM: banner-name [SPARC T4-1]
PLATFORM: name [ORCL,SPARC-T4-1]
PLATFORM: hostid [84fb366f]
PLATFORM: serial# [000cf710]
PLATFORM: stick-frequency [3b8f5850]
PLATFORM: mac-address [144ffb366f]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [64]
Top of RAM: 0x14fe54000, Total RAM: 0xff744000
Memory hole size: 1287MB
Zone ranges:
   Normal   [mem 0x50400000-0x14fe53fff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x50400000-0x14fb3bfff]
   node   0: [mem 0x14fe4c000-0x14fe53fff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 7 pages/cpu @ffff80014cc00000 s23296 r8192 d25856 u65536
SUN4V: Mondo queue sizes [cpu(8192) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 519079
Policy zone: Normal
Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS 
LANG=en_US.UTF-8 KEYTABLE=us rd_NO_MD rd_LVM_LV=VolGroup/lv_swap 
SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root rd_NO_DM
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 4090816K/4185360K available (5333K kernel code, 708K rwdata, 
2216K rodata, 488K init, 7896K bss, 94544K reserved)
Hierarchical RCU implementation.
NR_IRQS:255
clocksource: mult[801898] shift[23]
clockevent: mult[ffced917] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
allocated 10485760 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Calibrating delay using timer specific routine.. 2014.90 BogoMIPS 
(lpj@29806)
pid_max: default: 65536 minimum: 512
Security Framework initialized
SELinux:  Initializing.
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Mount-cache hash table entries: 512
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
Initializing cgroup subsys perf_event
Initializing cgroup subsys hugetlb
ftrace: allocating 19188 entries in 38 pages
Performance events: Supported PMU type is 'niagara4'
Brought up 2 CPUs
Testing NMI watchdog ...
WARNING: CPU#0: NMI appears to be stuck (0->0)!
Please report this to bugzilla.kernel.org,
and attach the output of the 'dmesg' command.

WARNING: CPU#1: NMI appears to be stuck (0->0)!
Please report this to bugzilla.kernel.org,
and attach the output of the 'dmesg' command.
devtmpfs: initialized
ldc.c:v1.1 (July 22, 2008)
regulator-dummy: no parameters
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vnet-port-0-0
VIO: Adding device vdc-port-0-0
VIO: Adding device vdc-port-1-0
VIO: Adding device vdc-port-2-0
VIO: Adding device vdc-port-3-0
VIO: Adding device vlds-port-0-0
VIO: Adding device ds-0
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out








