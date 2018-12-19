From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 19 Dec 2018 14:40:35 +0000
Subject: [sparc64] soft lockup - CPU stuck , KGDB_TESTS_ON_BOOT
Message-Id: <CADxRZqxP8A7+8QdB5Q2df4g_OeBbARB1UAg-acaEL=mGJWr_rw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello!

Getting "soft lockup, cpu stuck" on the latest git kernel (including
4.20.0-rc7) enabling kernel config option KGDB_TESTS_ON_BOOT.

My current LDOM configuration allocated 3 cores (3x8 =3D 24 vcpus).
Tried as well with 2 vcpus and 1 vcpu. Any configuration, except 1
vcpu, does not boot, but single vcpu boots ok.

Enabled the following kernel config options:

CONFIG_KGDB_TESTS=3Dy
CONFIG_KGDB_TESTS_ON_BOOT=3Dy
CONFIG_KGDB_TESTS_BOOT_STRING=3D"V1F100"

compiled latest git kernel and tried to boot (2 vcpu LDOM config):

[ 0.000017] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.12 2018/03/28 14:54'
[ 0.000029] PROMLIB: Root node compatible: sun4v
[ 0.000073] Linux version 4.20.0-rc6-00161-g6531e115b7ab (mator@ttip)
(gcc version 8.2.0 (Debian 8.2.0-12)) #777 SMP Sun Dec 16 15:27:49 MSK
2018
[ 0.000383] printk: bootconsole [earlyprom0] enabled
[ 0.000436] ARCH: SUN4V
[ 0.000484] Ethernet address: 00:14:4f:fa:06:f2
[ 0.000536] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits =3D 47)
[ 0.000601] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
[ 0.000663] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
[ 0.013376] Kernel: Using 5 locked TLB entries for main kernel image.
[ 0.013445] Remapping the kernel...
[ 0.013469] done.
[ 0.025723] OF stdout device is: /virtual-devices@100/console@1
[ 0.025787] PROM: Built device tree with 44645 bytes of memory.
[ 0.025847] MDESC: Size is 16208 bytes.
[ 0.025930] PLATFORM: banner-name [SPARC T5-2]
[ 0.025980] PLATFORM: name [ORCL,SPARC-T5-2]
[ 0.026024] PLATFORM: hostid [84fa06f2]
[ 0.026066] PLATFORM: serial# [0035260e]
[ 0.026108] PLATFORM: stick-frequency [3b9aca00]
[ 0.026156] PLATFORM: mac-address [144ffa06f2]
[ 0.026204] PLATFORM: watchdog-resolution [1000 ms]
[ 0.026254] PLATFORM: watchdog-max-timeout [31536000000 ms]
[ 0.026310] PLATFORM: max-cpus [1024]
[ 0.026391] Top of RAM: 0x24af948000, Total RAM: 0x87f3dc000
[ 0.026451] Memory hole size: 115461MB
[ 0.028905] Allocated 40960 bytes for kernel page tables.
[ 0.028981] Zone ranges:
[ 0.029020] Normal [mem 0x0000000030400000-0x00000024af947fff]
[ 0.029083] Movable zone start for each node
[ 0.029128] Early memory node ranges
[ 0.029168] node 0: [mem 0x0000000030400000-0x000000006fefffff]
[ 0.029228] node 0: [mem 0x000000006ff80000-0x000000006ff9ffff]
[ 0.029289] node 0: [mem 0x0000000070000000-0x000000042fffffff]
[ 0.029348] node 0: [mem 0x0000002030000000-0x00000024af8b3fff]
[ 0.029409] node 0: [mem 0x00000024af940000-0x00000024af947fff]
[ 0.036765] Zeroed struct page in unavailable ranges: 230070 pages
[ 0.036773] Initmem setup node 0 [mem 0x0000000030400000-0x00000024af947fff]
[ 0.234394] Booting Linux...
[ 0.234479] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[ 0.234564] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
[ 0.235642] CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
[ 0.235716] CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
[ 0.272737] percpu: Embedded 20 pages/cpu @(____ptrval____) s122824
r8192 d32824 u262144
[ 0.273625] SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256=
)]
[ 0.273779] Built 1 zonelists, mobility grouping on. Total pages: 4415739
[ 0.273866] Kernel command line:
BOOT_IMAGE=3D/vmlinuz-4.20.0-rc6-00161-g6531e115b7ab root=3D/dev/vdiska2
ro zswap.enabled=3D1 elevator=DEadline
[ 0.276230] printk: log_buf_len individual max cpu contribution: 4096 bytes
[ 0.276299] printk: log_buf_len total cpu_extra contributions: 1044480 bytes
[ 0.276367] printk: log_buf_len min size: 131072 bytes
[ 0.276719] printk: log_buf_len: 2097152 bytes
[ 0.276770] printk: early log buf free: 125920(96%)
[ 0.283069] Dentry cache hash table entries: 8388608 (order: 13, 67108864 b=
ytes)
[ 0.286312] Inode-cache hash table entries: 4194304 (order: 12, 33554432 by=
tes)
[ 0.286395] Sorting __ex_table...
[ 0.369324] Memory: 35110296K/35639152K available (6226K kernel code,
837K rwdata, 1856K rodata, 888K init, 7995K bss, 528856K reserved, 0K
cma-reserved)
[ 0.369987] kmemleak: Kernel memory leak detector disabled
[ 0.371411] ftrace: allocating 18971 entries in 38 pages
[ 0.385010] Running RCU self tests
[ 0.385055] rcu: Hierarchical RCU implementation.
[ 0.385104] rcu: RCU event tracing is enabled.
[ 0.385153] rcu: RCU lockdep checking is enabled.
[ 0.385203] Tasks RCU enabled.
[ 0.385241] rcu: RCU calculated value of scheduler-enlistment delay is
11 jiffies.
[ 0.390376] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
[ 0.390458] SUN4V: Using IRQ API major 3, cookie only virqs enabled
[ 0.394244] clocksource: stick: mask: 0xffffffffffffffff max_cycles:
0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[ 0.394378] clocksource: mult[800000] shift[23]
[ 0.394428] clockevent: mult[80000000] shift[31]
[ 0.398798] Console: colour dummy device 80x25
[ 0.398861] printk: console [tty0] enabled
[ 0.398937] printk: bootconsole [earlyprom0] disabled
[ 0.399019] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[ 0.399064] ... MAX_LOCKDEP_SUBCLASSES: 8
[ 0.399092] ... MAX_LOCK_DEPTH: 48
[ 0.399121] ... MAX_LOCKDEP_KEYS: 8191
[ 0.399150] ... CLASSHASH_SIZE: 4096
[ 0.399179] ... MAX_LOCKDEP_ENTRIES: 16384
[ 0.399208] ... MAX_LOCKDEP_CHAINS: 32768
[ 0.399238] ... CHAINHASH_SIZE: 16384
[ 0.399267] memory used by lock dependency info: 4959 kB
[ 0.399301] per task-struct memory footprint: 1920 bytes
[ 0.399531] kmemleak: Early log buffer exceeded (36190), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[ 0.544793] Calibrating delay using timer specific routine.. 2009.16
BogoMIPS (lpj=10045830)
[ 0.544860] pid_max: default: 262144 minimum: 2048
[ 0.546003] LSM: Security Framework initializing
[ 0.546044] AppArmor: AppArmor disabled by boot time parameter
[ 0.546696] Mount-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[ 0.546853] Mountpoint-cache hash table entries: 131072 (order: 7,
1048576 bytes)
[ 0.551617] rcu: Hierarchical SRCU implementation.
[ 0.574031] smp: Bringing up secondary CPUs ...
[ 0.577098] smp: Brought up 1 node, 2 CPUs
[ 0.579038] devtmpfs: initialized
[ 0.582550] Performance events:
[ 0.582574] Testing NMI watchdog ...
[ 0.782660] OK.
[ 0.782775] Supported PMU type is 'niagara5'
[ 0.783121] random: get_random_u32 called from
bucket_table_alloc.isra.4+0x140/0x1c0 with crng_init=3D0
[ 0.783879] ldc.c:v1.1 (July 22, 2008)
[ 0.786222] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[ 0.786347] futex hash table entries: 65536 (order: 10, 8388608 bytes)
[ 0.796016] NET: Registered protocol family 16
[ 0.801769] VIO: Adding device channel-devices (tx_ino ffffffffffffffff, rx=
_ino =3D ffffffffffffffff)
[ 0.801994] VIO: Adding device vnet-port-0-0 (tx_ino =3D 0, rx_ino =3D 1)
[ 0.802227] VIO: Adding device vnet-port-0-1 (tx_ino =3D 2, rx_ino =3D 3)
[ 0.802413] VIO: Adding device vnet-port-0-2 (tx_ino =3D 4, rx_ino =3D 5)
[ 0.802597] VIO: Adding device vnet-port-0-3 (tx_ino =3D 6, rx_ino =3D 7)
[ 0.802800] VIO: Adding device vdc-port-3-0 (tx_ino =3D 8, rx_ino =3D 9)
[ 0.802990] VIO: Adding device vdc-port-2-0 (tx_ino =3D a, rx_ino =3D b)
[ 0.803173] VIO: Adding device vdc-port-1-0 (tx_ino =3D c, rx_ino =3D d)
[ 0.803361] VIO: Adding device vdc-port-0-0 (tx_ino =3D e, rx_ino =3D f)
[ 0.803551] VIO: Adding device vlds-port-0-0 (tx_ino =3D 10, rx_ino =3D 11)
[ 0.803753] VIO: Adding device domain-services-port-0 (tx_ino =3D 10, rx_in=
o =3D 11)
[ 0.804146] audit: initializing netlink subsys (disabled)
[ 0.804510] audit: type 00 audit(0.210:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[ 0.846121] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[ 0.846167] HugeTLB registered 8.00 MiB page size, pre-allocated 0 pages
[ 0.846209] HugeTLB registered 256 MiB page size, pre-allocated 0 pages
[ 0.846251] HugeTLB registered 2.00 GiB page size, pre-allocated 0 pages
[ 0.857379] SUN4V: Reboot data supported (maj=3D1,min=3D0).
[ 0.857789] ds.c:v1.0 (Jul 11, 2007)
[ 0.858184] ds-0: ds_conn_reset() from send_events.isra.3
[ 0.859741] clocksource: Switched to clocksource stick
[ 1.037716] VFS: Disk quotas dquot_6.6.0
[ 1.038213] VFS: Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[ 1.058375] NET: Registered protocol family 2
[ 1.063061] tcp_listen_portaddr_hash hash table entries: 32768 (order:
8, 2359296 bytes)
[ 1.066376] TCP established hash table entries: 524288 (order: 9, 4194304 b=
ytes)
[ 1.068391] TCP bind hash table entries: 65536 (order: 9, 4194304 bytes)
[ 1.074141] TCP: Hash tables configured (established 524288 bind 65536)
[ 1.080678] UDP hash table entries: 32768 (order: 9, 5242880 bytes)
[ 1.087909] UDP-Lite hash table entries: 32768 (order: 9, 5242880 bytes)
[ 1.101881] NET: Registered protocol family 1
[ 1.102607] Unpacking initramfs...
[ 1.557478] Freeing initrd memory: 17104K
[ 1.599309] Kprobe smoke test: started
[ 1.608011] Kprobe smoke test: passed successfully
[ 1.609165] workingset: timestamp_bitsF max_order# bucket_order=3D0
[ 1.609516] zbud: loaded
[ 1.762990] Block layer SCSI generic (bsg) driver version 0.4 loaded (major=
 252)
[ 1.764437] io scheduler noop registered
[ 1.764469] io scheduler deadline registered (default)
[ 1.765218] io scheduler cfq registered
[ 1.765250] io scheduler mq-deadline registered (default)
[ 1.765287] io scheduler kyber registered
[ 1.769203] f029b788: ttyS0 at I/O 0x0 (irq =3D 1, base_baud =3D 115200)
is a SUN4V HCONS
[ 1.774739] printk: console [ttyHV0] enabled
[ 1.776848] sunvdc.c:v1.2 (November 24, 2014)
[ 1.779427] sunvdc: Virtual CDROM vdiskd
[ 1.779478] sunvdc: vdiskd: 403160 sectors (196 MB) protocol 1.2
[ 1.780747] vdiskd: vdiskd1 vdiskd2 vdiskd3 vdiskd4 vdiskd5 vdiskd6 vdiskd7
[ 1.790947] sunvdc: Virtual Hard disk vdiskc
[ 1.790984] sunvdc: vdiskc: 104857600 sectors (51200 MB) protocol 1.2
[ 1.797597] sunvdc: Virtual Hard disk vdiskb
[ 1.797634] sunvdc: vdiskb: 62914560 sectors (30720 MB) protocol 1.2
[ 1.799128] vdiskb: vdiskb1
[ 1.806169] sunvdc: Virtual Hard disk vdiska
[ 1.806205] sunvdc: vdiska: 31457280 sectors (15360 MB) protocol 1.2
[ 1.806905] vdiska: vdiska1 vdiska2 vdiska3 vdiska4
[ 1.810071] KGDB: Registered I/O driver kgdbts
[ 1.810244] kgdbts:RUN plant and detach test

Entering kdb (current=3D0xfff80024a0b84020, pid 1) on processor 0 due to
Keyboard Entry
[0]kdb> [ 1.811420] kgdbts:RUN sw breakpoint test
[ 1.813562] kgdbts:RUN bad memory access test
[ 1.814630] kgdbts:RUN singlestep test 1000 iterations
[ 1.817893] kgdbts:RUN singlestep [0/1000]
[ 2.180093] kgdbts:RUN singlestep [100/1000]
[ 2.492556] kgdbts:RUN singlestep [200/1000]
[ 2.826972] kgdbts:RUN singlestep [300/1000]
[ 3.200197] kgdbts:RUN singlestep [400/1000]
[ 3.475914] kgdbts:RUN singlestep [500/1000]
[ 3.851106] kgdbts:RUN singlestep [600/1000]
[ 4.233180] kgdbts:RUN singlestep [700/1000]
[ 4.609281] kgdbts:RUN singlestep [800/1000]
[ 4.968420] kgdbts:RUN singlestep [900/1000]
[ 5.262740] kgdbts:RUN do_fork for 100 breakpoints
[ 5.263465] sunvnet: sunvnet 2.0 (February 3, 2017)
[ 5.267474] vnet_port vnet-port-0-0 eth0: Sun LDOM vnet 00:14:4f:f8:12:a3
[ 5.268150] sunvnet: eth0: PORT ( remote-mac 00:14:4f:fa:f3:f0 switch-port )
[ 5.269701] sunvnet: eth0: PORT ( remote-mac 00:14:4f:f8:e5:f3 )
[ 5.271202] sunvnet: eth0: PORT ( remote-mac 00:14:4f:f9:b4:97 )
[ 5.272689] sunvnet: eth0: PORT ( remote-mac 00:14:4f:f9:8b:83 )
[ 5.273845] mousedev: PS/2 mouse device common for all mice
[ 5.274930] rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
[ 5.276231] device-mapper: uevent: version 1.0.3
[ 5.277428] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03)
initialised: dm-devel@redhat.com
[ 5.278953] NET: Registered protocol family 17
[ 5.280368] registered taskstats version 1
[ 5.281321] zswap: loaded using pool lzo/zbud
[ 5.326031] Key type big_key registered
[ 32.749684] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
[ 32.749759] Modules linked in:
[ 32.749790] irq event stamp: 341442
[ 32.749831] hardirqs last enabled at (341441): [<0000000000404bdc>]
rtrap_xcall+0x18/0x20
[ 32.749893] hardirqs last disabled at (341442): [<000000000042723c>]
sys_call_table+0x650/0x854
[ 32.749957] softirqs last enabled at (341440): [<0000000000a18874>]
__do_softirq+0x494/0x500
[ 32.750021] softirqs last disabled at (341433): [<000000000042ce14>]
do_softirq_own_stack+0x34/0x60
[ 32.750086] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.20.0-rc6-00161-g6531e115b7ab #777
[ 32.750144] TSTATE: 0000000080001603 TPC: 00000000005149c8 TNPC:
00000000005149cc Y: 0000098e Not tainted
[ 32.750212] TPC: <smp_call_function_single+0x108/0x180>
[ 32.750252] g0: fff80024a0b84888 g1: 0000000000000003 g2:
0000000000018e26 g3: 0000000000000001
[ 32.750311] g4: fff80024a0b84020 g5: fff80024aa280000 g6:
fff80024a0b88000 g7: 000000000000013f
[ 32.750371] o0: 0000000000000000 o1: fff80024a0b8b760 o2:
00000000004fdb80 o3: 0000000000000000
[ 32.750430] o4: 0000000000000000 o5: 0000000000000000 sp:
fff80024a0b8aeb1 ret_pc: 00000000005149ec
[ 32.750491] RPC: <smp_call_function_single+0x12c/0x180>
[ 32.750531] l0: 00000000014e3000 l1: 0000000000000001 l2:
00000000009e6410 l3: 0000000000000000
[ 32.750590] l4: 0000000000b490a0 l5: 0000000000cc21a8 l6:
0000000000b49070 l7: 0000000000000000
[ 32.750649] i0: 0000000000000001 i1: 00000000004fdb80 i2:
0000000000000000 i3: 0000000000000001
[ 32.750708] i4: 0000000000000001 i5: fff80024a0b8b760 i6:
fff80024a0b8af91 i7: 0000000000514e98
[ 32.750768] I7: <smp_call_function_many+0x118/0x320>
[ 32.750806] Call Trace:
[ 32.750832] [0000000000514e98] smp_call_function_many+0x118/0x320
[ 32.750877] [00000000005150cc] smp_call_function+0x2c/0x60
[ 32.750919] [0000000000515120] on_each_cpu+0x20/0xa0
[ 32.750964] [00000000004fea98] clock_was_set+0x18/0x40
[ 32.751005] [0000000000502114] do_settimeofday64+0x174/0x1a0
[ 32.751054] [0000000000ced8f8] rtc_hctosys+0x7c/0xe8
[ 32.751094] [0000000000427cc0] do_one_initcall+0x160/0x360
[ 32.751146] [0000000000cc3130] kernel_init_freeable+0x440/0x500
[ 32.751197] [0000000000a0cac0] kernel_init+0xc/0x10c
[ 32.751237] [00000000004060e4] ret_from_fork+0x1c/0x2c
[ 32.751276] [0000000000000000] (null)
[ 32.779676] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [swapper/1:0]
[ 32.779731] Modules linked in:
[ 32.779758] irq event stamp: 54408233
[ 32.779788] hardirqs last enabled at (54408232): [<0000000000404bdc>]
rtrap_xcall+0x18/0x20
[ 32.779842] hardirqs last disabled at (54408233):
[<000000000042723c>] sys_call_table+0x650/0x854
[ 32.779902] softirqs last enabled at (5192): [<000000000046bbc4>]
_local_bh_enable+0x44/0x60
[ 32.779956] softirqs last disabled at (5193): [<000000000042ce14>]
do_softirq_own_stack+0x34/0x60
[ 32.780012] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G L
4.20.0-rc6-00161-g6531e115b7ab #777
[ 32.780071] TSTATE: 0000004480001602 TPC: 0000000000a184bc TNPC:
0000000000a184c0 Y: 00000000 Tainted: G L
[ 32.780138] TPC: <__do_softirq+0xdc/0x500>
[ 32.780169] g0: fff80024af867641 g1: 0000000000d811a8 g2:
000000000001f208 g3: 0000000000000001
[ 32.780223] g4: fff80024a0be41a0 g5: fff80024aa2c0000 g6:
fff80024a0be8000 g7: 0000000000200042
[ 32.780277] o0: 000000000042ce14 o1: 00000
