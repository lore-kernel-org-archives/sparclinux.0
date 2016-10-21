From: Anatoly Pugachev <matorola@gmail.com>
Date: Fri, 21 Oct 2016 12:57:16 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <CADxRZqwWpsWDstFOvqmiihc1HqCBdFESm+D4ceh3P4FFKd28rQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 21, 2016 at 12:12 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Wed, Sep 7, 2016 at 1:01 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
>> On Wed, Sep 7, 2016 at 12:22 PM, John Paul Adrian Glaubitz
>> <glaubitz@physik.fu-berlin.de> wrote:
>>> Hello!
>>>
>>> After kernel 4.7.2 entered Debian unstable, I decided to upgrade the buildds and ran into an
>>> apparent regression with the 4.7.x kernels on sun4u machines:
>>
>> It's not only with sun4u, we're getting kernel OOPS on sun4v as well:
>
> debian packaged 4.7.6 kernel, machine is a LDOM on T5-2 server, OOPS
> after kernel boot within a few minutes:


reproduced with latest git 4.9.0-rc1+ (v4.9-rc1-148-g6f33d645) kernel.
Machine boots ok, i can login as unprivileged user (via ssh), compile
and install kernel, run sudo, install packages (apt upgrade),
apache/mysql and other startup daemons works, but if I try to login as
root via ssh, it throws kernel oops / illegal instruction.

Any idea how to debug this?

otherhost$ ssh ttip -l root -v
...
debug1: channel 0: new [client-session]
debug1: Requesting no-more-sessions@openssh.com
debug1: Entering interactive session.
Write failed: Broken pipe
$

I can strace -f -p $pid_of_sshd , but not sure it would help.

URL version => http://paste.debian.net/plain/884751
kernel config => http://paste.debian.net/plain/884806

NOTICE: Entering OpenBoot.
NOTICE: Fetching Guest MD from HV.
NOTICE: Starting additional cpus.
NOTICE: Initializing LDC services.
NOTICE: Probing PCI devices.
NOTICE: Finished PCI probing.

SPARC T5-2, No Keyboard
Copyright (c) 1998, 2016, Oracle and/or its affiliates. All rights reserved.
OpenBoot 4.38.5, 32.0000 GB memory available, Serial #83494642.
Ethernet address 0:14:4f:fa:6:f2, Host ID: 84fa06f2.



Boot device: vdisk1  File and args:
SILO Version 1.4.14
boot:
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 4.9.0
Loading initial ramdisk (13616359 bytes at 0x74000000 phys, 0x40C00000 virt)...

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.5 2016/06/22 19:36'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Linux version 4.9.0-rc1+ (mator@ttip) (gcc version
6.2.0 20161010 (Debian 6.2.0-6+sparc64) ) #19 SMP Fri Oct 21 14:47:01
MSK 2016
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4V
[    0.000000] Ethernet address: 00:14:4f:fa:06:f2
[    0.000000] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits = 47)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
[    0.000000] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... [    0.000000] done.
[    0.000000] OF stdout device is: /virtual-devices@100/console@1
[    0.000000] PROM: Built device tree with 67418 bytes of memory.
[    0.000000] MDESC: Size is 29648 bytes.
[    0.000000] PLATFORM: banner-name [SPARC T5-2]
[    0.000000] PLATFORM: name [ORCL,SPARC-T5-2]
[    0.000000] PLATFORM: hostid [84fa06f2]
[    0.000000] PLATFORM: serial# [0035260e]
[    0.000000] PLATFORM: stick-frequency [3b9aca00]
[    0.000000] PLATFORM: mac-address [144ffa06f2]
[    0.000000] PLATFORM: watchdog-resolution [1000 ms]
[    0.000000] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.000000] PLATFORM: max-cpus [1024]
[    0.000000] Top of RAM: 0x82f94e000, Total RAM: 0x7ff386000
[    0.000000] Memory hole size: 773MB
[    0.000000] Allocated 24576 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000030400000-0x000000082f94dfff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000030400000-0x000000006febffff]
[    0.000000]   node   0: [mem 0x000000006ff40000-0x000000006ff47fff]
[    0.000000]   node   0: [mem 0x0000000070000000-0x000000082f8b3fff]
[    0.000000]   node   0: [mem 0x000000082f944000-0x000000082f94dfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000030400000-0x000000082f94dfff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[    0.000000] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
[    0.000000] CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
[    0.000000] CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
[    0.000000] percpu: Embedded 10 pages/cpu @fff800082d000000 s43096
r8192 d30632 u131072
[    0.000000] SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 4155855
[    0.000000] Kernel command line: root=/dev/vdiska2 ro
zswap.enabled=1 noresume
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 1044480 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 2097152 bytes
[    0.000000] early log buf free: 126400(96%)
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 4194304 (order: 12,
33554432 bytes)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 11,
16777216 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 33127576K/33541656K available (5721K kernel
code, 777K rwdata, 1392K rodata, 488K init, 758K bss, 414080K
reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[    0.000000] SUN4V: Using IRQ API major 3, cookie only virqs enabled
[5446513.645282] clocksource: stick: mask: 0xffffffffffffffff
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[5446513.645385] clocksource: mult[800000] shift[23]
[5446513.645434] clockevent: mult[80000000] shift[31]
[5446513.647207] Console: colour dummy device 80x25
[5446513.647260] console [tty0] enabled
[5446513.647301] bootconsole [earlyprom0] disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.5 2016/06/22 19:36'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Linux version 4.9.0-rc1+ (mator@ttip) (gcc version
6.2.0 20161010 (Debian 6.2.0-6+sparc64) ) #19 SMP Fri Oct 21 14:47:01
MSK 2016
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4V
[    0.000000] Ethernet address: 00:14:4f:fa:06:f2
[    0.000000] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits = 47)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
[    0.000000] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel...
[    0.000000] done.
[    0.000000] OF stdout device is: /virtual-devices@100/console@1
[    0.000000] PROM: Built device tree with 67418 bytes of memory.
[    0.000000] MDESC: Size is 29648 bytes.
[    0.000000] PLATFORM: banner-name [SPARC T5-2]
[    0.000000] PLATFORM: name [ORCL,SPARC-T5-2]
[    0.000000] PLATFORM: hostid [84fa06f2]
[    0.000000] PLATFORM: serial# [0035260e]
[    0.000000] PLATFORM: stick-frequency [3b9aca00]
[    0.000000] PLATFORM: mac-address [144ffa06f2]
[    0.000000] PLATFORM: watchdog-resolution [1000 ms]
[    0.000000] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.000000] PLATFORM: max-cpus [1024]
[    0.000000] Top of RAM: 0x82f94e000, Total RAM: 0x7ff386000
[    0.000000] Memory hole size: 773MB
[    0.000000] Allocated 24576 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000030400000-0x000000082f94dfff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000030400000-0x000000006febffff]
[    0.000000]   node   0: [mem 0x000000006ff40000-0x000000006ff47fff]
[    0.000000]   node   0: [mem 0x0000000070000000-0x000000082f8b3fff]
[    0.000000]   node   0: [mem 0x000000082f944000-0x000000082f94dfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000030400000-0x000000082f94dfff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[    0.000000] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
[    0.000000] CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
[    0.000000] CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
[    0.000000] percpu: Embedded 10 pages/cpu @fff800082d000000 s43096
r8192 d30632 u131072
[    0.000000] SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 4155855
[    0.000000] Kernel command line: root=/dev/vdiska2 ro
zswap.enabled=1 noresume
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 1044480 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 2097152 bytes
[    0.000000] early log buf free: 126400(96%)
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 4194304 (order: 12,
33554432 bytes)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 11,
16777216 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 33127576K/33541656K available (5721K kernel
code, 777K rwdata, 1392K rodata, 488K init, 758K bss, 414080K
reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[    0.000000] SUN4V: Using IRQ API major 3, cookie only virqs enabled
[5446513.645282] clocksource: stick: mask: 0xffffffffffffffff
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[5446513.645385] clocksource: mult[800000] shift[23]
[5446513.645434] clockevent: mult[80000000] shift[31]
[5446513.647207] Console: colour dummy device 80x25
[5446513.647260] console [tty0] enabled
[5446513.647301] bootconsole [earlyprom0] disabled
[5446513.739370] Calibrating delay using timer specific routine..
2001.57 BogoMIPS (lpj@03143)
[5446513.739378] pid_max: default: 262144 minimum: 2048
[5446513.740312] Security Framework initialized
[5446513.740318] Yama: becoming mindful.
[5446513.740348] AppArmor: AppArmor disabled by boot time parameter
[5446513.740739] Mount-cache hash table entries: 65536 (order: 6, 524288 bytes)
[5446513.740746] Mountpoint-cache hash table entries: 65536 (order: 6,
524288 bytes)
[5446513.742751] ftrace: allocating 18972 entries in 38 pages
[5446513.776303] Brought up 24 CPUs
[5446513.790990] devtmpfs: initialized
[5446513.795145] Performance events:
[5446513.795167] Testing NMI watchdog ...
[5446513.875242] OK.
[5446513.875256] Supported PMU type is 'niagara5'
[5446513.934803] ldc.c:v1.1 (July 22, 2008)
[5446513.935400] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[5446514.035251] NET: Registered protocol family 16
[5446514.044337] VIO: Adding device channel-devices
[5446514.044534] VIO: Adding device vnet-port-0-0
[5446514.044718] VIO: Adding device vnet-port-0-1
[5446514.044889] VIO: Adding device vnet-port-0-2
[5446514.045071] VIO: Adding device vnet-port-0-3
[5446514.045243] VIO: Adding device vnet-port-0-4
[5446514.045416] VIO: Adding device vdc-port-0-0
[5446514.045598] VIO: Adding device vdc-port-1-0
[5446514.045770] VIO: Adding device vdc-port-2-0
[5446514.045947] VIO: Adding device vlds-port-0-0
[5446514.046142] VIO: Adding device ds-0
[5446514.143418] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[5446514.403398] vgaarb: loaded
[5446514.405144] SUN4V: Reboot data supported (maj=1,min=0).
[5446514.405220] ds.c:v1.0 (Jul 11, 2007)
[5446514.405473] ds-0: ds_conn_reset() from send_events
[5446514.405609] ds-0: Registered md-update service.
[5446514.405623] clocksource: Switched to clocksource stick
[5446514.405626] ds-0: Registered domain-shutdown service.
[5446514.405639] ds-0: Registered domain-panic service.
[5446514.405654] ds-0: Registered dr-cpu service.
[5446514.405667] ds-0: Registered pri service.
[5446514.405684] ds-0: Registered var-config service.
[5446514.497653] VFS: Disk quotas dquot_6.6.0
[5446514.517641] VFS: Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[5446514.669592] NET: Registered protocol family 2
[5446514.829600] TCP established hash table entries: 262144 (order: 8,
2097152 bytes)
[5446514.830600] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[5446514.831104] TCP: Hash tables configured (established 262144 bind 65536)
[5446514.831491] UDP hash table entries: 16384 (order: 6, 524288 bytes)
[5446514.831745] UDP-Lite hash table entries: 16384 (order: 6, 524288 bytes)
[5446514.909591] NET: Registered protocol family 1
[5446514.910168] Unpacking initramfs...
[5446515.167549] Freeing initrd memory: 13296K (fff8000074000000 -
fff8000074cfc000)
[5446515.228035] futex hash table entries: 65536 (order: 9, 4194304 bytes)
[5446515.245613] audit: initializing netlink subsys (disabled)
[5446515.245707] audit: type 00 audit(1.580:1): initialized
[5446515.247142] workingset: timestamp_bitsF max_order" bucket_order=0
[5446515.247498] zbud: loaded
[5446515.465626] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[5446515.466226] io scheduler noop registered
[5446515.466232] io scheduler deadline registered
[5446515.529592] io scheduler cfq registered (default)
[5446515.650732] f029b7a8: ttyS0 at I/O 0x0 (irq = 1, base_baud 115200) is a SUN4V HCONS
[5446515.650929] console [ttyHV0] enabled
[5446515.653348] mousedev: PS/2 mouse device common for all mice
[5446515.654185] rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
[5446515.662989] ledtrig-cpu: registered to indicate activity on CPUs
[5446515.853593] NET: Registered protocol family 10
[5446515.933641] mip6: Mobile IPv6
[5446515.933650] NET: Registered protocol family 17
[5446515.933672] mpls_gso: MPLS GSO support
[5446515.934453] registered taskstats version 1
[5446515.955716] zswap: loaded using pool lzo/zbud
[5446515.956068] rtc-sun4v rtc-sun4v: setting system clock to
2016-10-21 11:51:58 UTC (1477050718)
[5446515.956353] This architecture does not have kernel memory protection.
Loading, please wait...
starting version 231
[5446515.996950] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[5446515.997343] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[5446515.997383] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[5446515.998965] random: udevadm: uninitialized urandom read (16 bytes read)
[5446515.999123] random: udevadm: uninitialized urandom read (16 bytes read)
[5446516.086592] random: udevadm: uninitialized urandom read (16 bytes read)
[5446516.086970] random: udevadm: uninitialized urandom read (16 bytes read)
[5446516.087358] random: udevadm: uninitialized urandom read (16 bytes read)
[5446516.087400] random: udevadm: uninitialized urandom read (16 bytes read)
[5446516.087763] random: udevadm: uninitialized urandom read (16 bytes read)
[5446516.245087] sunvdc.c:v1.2 (November 24, 2014)
[5446516.255973] sunvdc: Virtual Hard disk vdiska
[5446516.255987] sunvdc: vdiska: 20971520 sectors (10240 MB) protocol 1.1
[5446516.256771]  vdiska: vdiska1 vdiska2 vdiska3 vdiska4
[5446516.260126] sunvnet.c:v1.0 (June 25, 2007)
[5446516.264281] crc32c_sparc64: Using sparc64 crc32c opcode optimized
CRC32C implementation
[5446516.265981] vnet_port vnet-port-0-0 eth0: Sun LDOM vnet 00:14:4f:f8:12:a3
[5446516.267202] sunvnet: eth0: PORT ( remote-mac 00:14:4f:fa:f3:f0
switch-port )
[5446516.278618] sunvdc: Virtual Hard disk vdiskb
[5446516.278631] sunvdc: vdiskb: 104857600 sectors (51200 MB) protocol 1.1
[5446516.298489]  vdiskb: vdiskb1
[5446516.312441] sunvdc: Virtual Hard disk vdiskc
[5446516.312456] sunvdc: vdiskc: 41943040 sectors (20480 MB) protocol 1.1
[5446516.316207] sunvnet: eth0: PORT ( remote-mac 00:14:4f:f8:e5:f3 )
[5446516.317324] sunvnet: eth0: PORT ( remote-mac 00:14:4f:fa:e6:35 )
[5446516.318813] sunvnet: eth0: PORT ( remote-mac 00:14:4f:f9:6c:d1 )
[5446516.319892] sunvnet: eth0: PORT ( remote-mac 00:14:4f:f8:38:39 )
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... done.
Begin: Will now check root file system ... fsck from util-linux 2.28.2
[/sbin/fsck.ext4 (1) -- /dev/vdiska2] fsck.ext4 -a -C0 /dev/vdiska2
/dev/vdiska2: clean, 82595/610800 files, 1385876/2441880 blocks
done.
[5446516.930934] EXT4-fs (vdiska2): mounted filesystem with ordered
data mode. Opts: (null)
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... done.
[5446517.265719] random: fast init done
[5446518.241579] ip_tables: (C) 2000-2006 Netfilter Core Team
[5446518.420144] systemd[1]: systemd 231 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[5446518.420310] systemd[1]: Detected architecture sparc64.

Welcome to Debian GNU/Linux stretch/sid!

[5446518.438358] systemd[1]: Set hostname to <ttip>.
[5446518.733617] random: crng init done
[5446520.947723] systemd[1]: dovecot.service: Cannot add dependency
job, ignoring: Unit dovecot.service is masked.
[5446520.948998] systemd[1]: Reached target Swap.
[ OK ] Reached target Swap.
[5446520.949421] systemd[1]: Listening on LVM2 metadata daemon socket.
[ OK ] Listening on LVM2 metadata daemon socket.
[5446520.949669] systemd[1]: Listening on Syslog Socket.
[ OK ] Listening on Syslog Socket.
[5446520.950925] systemd[1]: Set up automount Arbitrary Executable
File Formats File System Automount Point.
[ OK ] Set up automount Arbitrary Executab...ats File System Automount Point.
[5446520.951204] systemd[1]: Listening on Journal Audit Socket.
[ OK ] Listening on Journal Audit Socket.
[5446520.951371] systemd[1]: Listening on fsck to fsckd communication Socket.
[ OK ] Listening on fsck to fsckd communication Socket.
[ OK ] Created slice System Slice.
[ OK ] Created slice system-getty.slice.
[ OK ] Created slice system-openvpn.slice.
[ OK ] Created slice system-postfix.slice.
[ OK ] Listening on udev Kernel Socket.
[ OK ] Started Dispatch Password Requests to Console Directory Watch.
[ OK ] Started Forward Password Requests to Wall Directory Watch.
[ OK ] Reached target Paths.
[ OK ] Listening on LVM2 poll daemon socket.
[ OK ] Reached target Encrypted Volumes.
[ OK ] Listening on Journal Socket (/dev/log).
[ OK ] Created slice system-systemd\x2dfsck.slice.
[ OK ] Listening on udev Control Socket.
[ OK ] Reached target Remote File Systems.
[ OK ] Listening on Device-mapper event daemon FIFOs.
[ OK ] Listening on Journal Socket.
         Starting Load Kernel Modules...
         Starting Create list of required st... nodes for the current kernel...
         Mounting Debug File System...
         Starting Remount Root and Kernel File Systems...
         Starting Monitoring of LVM2 mirrors... dmeventd or progress polling...
         Mounting POSIX Message Queue File System...
         Mounting Huge Pages File System...
         Starting Journal Service...
[ OK ] Listening on /dev/initctl Compatibility Named Pipe.
[ OK ] Created slice User and Session Slice.
[ OK ] Reached target Slices.
[ OK ] Started Create list of required sta...ce nodes for the current kernel.
         Starting Create Static Device Nodes in /dev...
[ OK ] Mounted POSIX Message Queue File System.
[ OK ] Mounted Huge Pages File System.
[ OK ] Mounted Debug File System.
[5446521.517395] EXT4-fs (vdiska2): re-mounted. Opts: errors=remount-ro
[ OK ] Started Remount Root and Kernel File Systems.
         Starting Initial Check File System Quotas...
         Starting udev Coldplug all Devices...
         Starting Load/Save Random Seed...
[ OK ] Started LVM2 metadata daemon.
[ OK ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[5446521.785599] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[ OK ] Started Load/Save Random Seed.
[ OK ] Started Load Kernel Modules.
         Starting Apply Kernel Variables...
[ OK ] Started Monitoring of LVM2 mirrors,...ng dmeventd or progress polling.
[ OK ] Reached target Local File Systems (Pre).
[ OK ] Started udev Kernel Device Manager.
[ OK ] Started Journal Service.
         Starting Flush Journal to Persistent Storage...
[ OK ] Started udev Coldplug all Devices.
[ OK ] Started Apply Kernel Variables.
[5446522.516615] systemd-journald[320]: Received request to flush
runtime journal from PID 1
[5446522.951042] sha1_sparc64: Using sparc64 sha1 opcode optimized
SHA-1 implementation
[5446522.954641] sha256_sparc64: Using sparc64 sha256 opcode optimized
SHA-256/SHA-224 implementation
[5446522.957544] sha512_sparc64: Using sparc64 sha512 opcode optimized
SHA-512/SHA-384 implementation
[5446522.960507] md5_sparc64: Using sparc64 md5 opcode optimized MD5
implementation
[5446522.969131] n2rng.c:v0.2 (July 27, 2011)
[5446522.969162] n2rng f029b124: Registered RNG HVAPI major 2 minor 0
[5446522.969176] n2rng f029b124: Found multi-unit-capable RNG, units: 2
[5446522.969199] n2rng f029b124: RNG ready
[ OK ] Found device /dev/disk/by-uuid/9247a54d-b25d-4433-a4d7-1f2c00f29135.
         Mounting /home...
[5446523.028888] aes_sparc64: Using sparc64 aes opcodes optimized AES
implementation
[ OK ] Found device /dev/vdiska1.
         Starting File System Check on /dev/vdiska1...
[ OK ] Started File System Check Daemon to report status.
[5446523.333247] des_sparc64: Using sparc64 des opcodes optimized DES
implementation
[5446523.451376] camellia_sparc64: Using sparc64 camellia opcodes
optimized CAMELLIA implementation
[5446523.526289] xor: automatically using best checksumming function   Niagara
[5446523.593597] raid6: int64x1  gen()  2563 MB/s
[5446523.661591] raid6: int64x1  xor()  1672 MB/s
[5446523.729599] raid6: int64x2  gen()  2679 MB/s
[5446523.797588] raid6: int64x2  xor()  1991 MB/s
[5446523.865599] raid6: int64x4  gen()  3369 MB/s
[5446523.933598] raid6: int64x4  xor()  1912 MB/s
[5446524.001609] raid6: int64x8  gen()  2029 MB/s
[5446524.069588] raid6: int64x8  xor()  1425 MB/s
[5446524.069595] raid6: using algorithm int64x4 gen() 3369 MB/s
[5446524.069601] raid6: .... xor() 1912 MB/s, rmw enabled
[5446524.069607] raid6: using intx1 recovery algorithm
[5446524.295720] SGI XFS with ACLs, security attributes, realtime, no
debug enabled
[ OK ] Started Initial Check File System Quotas.
[ OK ] Started File System Check on /dev/vdiska1.
         Mounting /boot...
[ OK ] Started Flush Journal to Persistent Storage.
[5446525.156403] XFS (vdiskb1): Mounting V5 Filesystem
[5446525.197969] EXT4-fs (vdiska1): mounting ext3 file system using
the ext4 subsystem
[5446525.212787] XFS (vdiskb1): Ending clean mount
[ OK ] Mounted /home.
[5446525.401828] Btrfs loaded, crc32c=crc32c-sparc64, debug=on, assert=on
[5446525.402610] BTRFS: selftest: sectorsize: 8192  nodesize: 8192
[5446525.402621] BTRFS: selftest: Running btrfs free space cache tests
[5446525.402879] BTRFS: selftest: Running extent only tests
[5446525.402913] BTRFS: selftest: Running bitmap only tests
[5446525.403026] BTRFS: selftest: Running bitmap and extent tests
[5446525.403195] BTRFS: selftest: Running space stealing from bitmap to extent
[5446525.403795] BTRFS: selftest: Free space cache tests finished
[5446525.403803] BTRFS: selftest: Running extent buffer operation tests
[5446525.403808] BTRFS: selftest: Running btrfs_split_item tests
[5446525.404178] BTRFS: selftest: Running extent I/O tests
[5446525.404185] BTRFS: selftest: Running find delalloc tests
[5446525.453651] BTRFS: selftest: Running extent buffer bitmap tests
[5446525.502094] BTRFS: selftest: Extent I/O tests finished
[5446525.502103] BTRFS: selftest: Running btrfs_get_extent tests
[5446525.502544] BTRFS: selftest: Running hole first btrfs_get_extent test
[5446525.502885] BTRFS: selftest: Running outstanding_extents tests
[5446525.503433] BTRFS: selftest: Running qgroup tests
[5446525.503440] BTRFS: selftest: Qgroup basic add
[5446525.503501] BTRFS: selftest: Qgroup multiple refs test
[5446525.505363] BTRFS: selftest: Running free space tree tests
[5446525.543153] BTRFS: selftest: sectorsize: 8192  nodesize: 16384
[5446525.543162] BTRFS: selftest: Running btrfs free space cache tests
[5446525.543345] BTRFS: selftest: Running extent only tests
[5446525.543359] BTRFS: selftest: Running bitmap only tests
[5446525.543424] BTRFS: selftest: Running bitmap and extent tests
[5446525.543528] BTRFS: selftest: Running space stealing from bitmap to extent
[5446525.544094] BTRFS: selftest: Free space cache tests finished
[5446525.544100] BTRFS: selftest: Running extent buffer operation tests
[5446525.544106] BTRFS: selftest: Running btrfs_split_item tests
[5446525.544441] BTRFS: selftest: Running extent I/O tests
[5446525.544447] BTRFS: selftest: Running find delalloc tests
[5446525.558911] EXT4-fs (vdiska1): mounted filesystem with ordered
data mode. Opts: (null)
[ OK ] Mounted /boot.
[ OK ] Reached target Local File Systems.
         Starting Create Volatile Files and Directories...
         Starting Raise network interfaces...
[5446525.594355] BTRFS: selftest: Running extent buffer bitmap tests
[ OK ] Started Create Volatile Files and Directories.
[ OK ] Reached target System Time Synchronized.
         Starting Update UTMP about System Boot/Shutdown...
[5446525.642824] BTRFS: selftest: Extent I/O tests finished
[5446525.642837] BTRFS: selftest: Running btrfs_get_extent tests
[5446525.643282] BTRFS: selftest: Running hole first btrfs_get_extent test
[5446525.643625] BTRFS: selftest: Running outstanding_extents tests
[5446525.644173] BTRFS: selftest: Running qgroup tests
[5446525.644180] BTRFS: selftest: Qgroup basic add
[5446525.644234] BTRFS: selftest: Qgroup multiple refs test
[5446525.646110] BTRFS: selftest: Running free space tree tests
[ OK ] Started Update UTMP about System Boot/Shutdown.
[ OK ] Reached target System Initialization.
[ OK ] Listening on UUID daemon activation socket.
[ OK ] Listening on D-Bus System Message Bus Socket.
[ OK ] Reached target Sockets.
[ OK ] Reached target Basic System.
[ OK ] Started Regular background program processing daemon.
[ OK ] Started fast remote file copy program daemon.
         Starting Postfix Mail Transport Agent (instance -)...
         Starting rng-tools.service...
         Starting Restore /etc/resolv.conf i...re the ppp link was shut down...
         Starting LSB: Start/stop sysstat's sadc...
[5446525.683858] BTRFS: selftest: sectorsize: 8192  nodesize: 32768
[5446525.683871] BTRFS: selftest: Running btrfs free space cache tests
[5446525.684053] BTRFS: selftest: Running extent only tests
[5446525.684068] BTRFS: selftest: Running bitmap only tests
[5446525.684134] BTRFS: selftest: Running bitmap and extent tests
[5446525.684238] BTRFS: selftest: Running space stealing from bitmap to extent
[5446525.684805] BTRFS: selftest: Free space cache tests finished
[5446525.684811] BTRFS: selftest: Running extent buffer operation tests
[5446525.684817] BTRFS: selftest: Running btrfs_split_item tests
[5446525.685155] BTRFS: selftest: Running extent I/O tests
[5446525.685161] BTRFS: selftest: Running find delalloc tests
         Starting OpenVPN connection to u164...
         Starting System Logging Service...
[ OK ] Started Deferred execution scheduler.
         Starting Login Service...
[ OK ] Started Daily apt activities.
[ OK ] Started Daily Cleanup of Temporary Directories.
[ OK ] Reached target Timers.
[ OK ] Started D-Bus System Message Bus.
[5446525.735232] BTRFS: selftest: Running extent buffer bitmap tests
[5446525.783693] BTRFS: selftest: Extent I/O tests finished
[5446525.783708] BTRFS: selftest: Running btrfs_get_extent tests
[5446525.784223] BTRFS: selftest: Running hole first btrfs_get_extent test
[5446525.784566] BTRFS: selftest: Running outstanding_extents tests
[5446525.785110] BTRFS: selftest: Running qgroup tests
[5446525.785117] BTRFS: selftest: Qgroup basic add
[5446525.785170] BTRFS: selftest: Qgroup multiple refs test
[5446525.787062] BTRFS: selftest: Running free space tree tests
[5446525.824666] BTRFS: selftest: sectorsize: 8192  nodesize: 65536
[5446525.824678] BTRFS: selftest: Running btrfs free space cache tests
[5446525.824860] BTRFS: selftest: Running extent only tests
[5446525.824876] BTRFS: selftest: Running bitmap only tests
[5446525.824951] BTRFS: selftest: Running bitmap and extent tests
[5446525.825055] BTRFS: selftest: Running space stealing from bitmap to extent
[5446525.825629] BTRFS: selftest: Free space cache tests finished
[5446525.825636] BTRFS: selftest: Running extent buffer operation tests
[5446525.825641] BTRFS: selftest: Running btrfs_split_item tests
[5446525.825982] BTRFS: selftest: Running extent I/O tests
[5446525.825988] BTRFS: selftest: Running find delalloc tests
[5446525.875834] BTRFS: selftest: Running extent buffer bitmap tests
[5446525.924308] BTRFS: selftest: Extent I/O tests finished
[5446525.924319] BTRFS: selftest: Running btrfs_get_extent tests
[5446525.924781] BTRFS: selftest: Running hole first btrfs_get_extent test
[5446525.925123] BTRFS: selftest: Running outstanding_extents tests
[5446525.925678] BTRFS: selftest: Running qgroup tests
[5446525.925685] BTRFS: selftest: Qgroup basic add
[5446525.925739] BTRFS: selftest: Qgroup multiple refs test
[5446525.927601] BTRFS: selftest: Running free space tree tests
[5446526.327443] BTRFS: device fsid
aedb837a-669f-45b5-ade3-f08014650aca devid 1 transid 19 /dev/vdiska4
[ OK ] Started System Logging Service.
[ OK ] Started rng-tools.service.
[ OK ] Started Restore /etc/resolv.conf if...fore the ppp link was shut down.
[ OK ] Started OpenVPN connection to u164.
[ OK ] Started Login Service.
[ OK ] Started LSB: Start/stop sysstat's sadc.
[5446527.495543] systemd[1]: apt-daily.timer: Adding 7h 11min
14.569406s random time.
[5446527.928139] systemd[1]: apt-daily.timer: Adding 7h 33min
44.338807s random time.
[5446528.139446] systemd[1]: apt-daily.timer: Adding 10h 35min
14.835388s random time.
[ OK ] Started Raise network interfaces.
[ OK ] Reached target Network.
[ OK ] Started BIND Domain Name Server.
[ OK ] Reached target Host and Network Name Lookups.
         Starting Postfix Mail Transport Agent...
         Starting Permit User Sessions...
         Starting vsftpd FTP server...
         Starting Simple Network Management Protocol (SNMP) Daemon....
         Starting OpenBSD Secure Shell server...
[ OK ] Started PoPToP Point to Point Tunneling Server.
         Starting OpenVPN service...
[ OK ] Reached target Network is Online.
         Starting LSB: Start NTP daemon...
         Starting LSB: Starts or stops the xinetd daemon....
         Starting LSB: PostgreSQL RDBMS server...
         Starting LSB: Start and stop the mysql database server daemon...
         Starting /etc/rc.local Compatibility...
         Starting LSB: Apache2 web server...
[ OK ] Started Postfix Mail Transport Agent.
[ OK ] Started Permit User Sessions.
[ OK ] Started vsftpd FTP server.
[ OK ] Started Simple Network Management Protocol (SNMP) Daemon..
[ OK ] Started OpenVPN service.
[ OK ] Started LSB: PostgreSQL RDBMS server.
[ OK ] Started OpenBSD Secure Shell server.
[ OK ] Started /etc/rc.local Compatibility.
[ OK ] Started Getty on tty1.
[ OK ] Started Console Getty.
[ OK ] Reached target Login Prompts.
[ OK ] Started LSB: Apache2 web server.
         Mounting Arbitrary Executable File Formats File System...
[ OK ] Started LSB: Start NTP daemon.
[ OK ] Mounted Arbitrary Executable File Formats File System.
[ OK ] Started LSB: Starts or stops the xinetd daemon..
[ OK ] Started Postfix Mail Transport Agent (instance -).
[5446531.282391] tun: Universal TUN/TAP device driver, 1.6
[5446531.282412] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[ OK ] Started LSB: Start and stop the mysql database server daemon.
[ OK ] Reached target Multi-User System.
[ OK ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[ OK ] Started Update UTMP about System Runlevel Changes.
^M
Debian GNU/Linux stretch/sid ttip console

ttip login: ^M
Debian GNU/Linux stretch/sid ttip console

ttip login: ^M^M
[5446612.113173]               \|/ ____ \|/
[5446612.113173]               "@'/ .. \`@"
[5446612.113173]               /_| \__/ |_\
[5446612.113173]                  \__U_/
[5446612.113194] systemd(1): Kernel illegal instruction [#1]
[5446612.113202] CPU: 12 PID: 1 Comm: systemd Not tainted 4.9.0-rc1+ #19
[5446612.113208] task: fff8000815deb620 task.stack: fff8000815dec000
[5446612.113213] TSTATE: 0000004411001603 TPC: 00000000005ccfec TNPC:
00000000005ccff0 Y: 00000000    Not tainted
[5446612.113232] TPC: <__kmalloc_track_caller+0x14c/0x240>
[5446612.113237] g0: 0006000011fbe000 g1: 0000000000400000 g2:
0000000000000000 g3: 0000000000000001
[5446612.113242] g4: fff8000815deb620 g5: fff800082c550000 g6:
fff8000815dec000 g7: 0000000000636500
[5446612.113248] o0: 0000000000000000 o1: 00000000024000c0 o2:
0000000000000009 o3: ffffffffffffffff
[5446612.113253] o4: 0000000000b1b510 o5: 0000000000b1b400 sp:
fff8000815deef01 ret_pc: 00000000005ccfe4
[5446612.113260] RPC: <__kmalloc_track_caller+0x144/0x240>
[5446612.113265] l0: fff8000030402140 l1: 0000000000000020 l2:
fff800080b4384c0 l3: ffffffffffffffff
[5446612.113270] l4: fff800082d18e000 l5: 0000000000000000 l6:
0006000012195800 l7: fff8000100e9a000
[5446612.113280] i0: 000000000000000b i1: 00000000024000c0 i2:
000000000058f41c i3: 00000000024000c0
[5446612.113288] i4: fff800080830ea12 i5: 00000000024000c0 i6:
fff8000815deefb1 i7: 000000000058f3a8
[5446612.113300] I7: <kstrdup+0x28/0x60>
[5446612.113305] Call Trace:
[5446612.113310]  [000000000058f3a8] kstrdup+0x28/0x60
[5446612.113317]  [000000000058f41c] kstrdup_const+0x3c/0x60
[5446612.113325]  [0000000000666030] __kernfs_new_node+0x10/0xc0
[5446612.113332]  [00000000006672c4] kernfs_new_node+0x24/0x60
[5446612.113339]  [000000000066769c] kernfs_create_dir_ns+0x1c/0x80
[5446612.113349]  [00000000004ffd40] cgroup_mkdir+0x1c0/0x320
[5446612.113355]  [000000000066721c] kernfs_iop_mkdir+0x5c/0xa0
[5446612.113364]  [00000000005f46dc] vfs_mkdir+0x11c/0x1a0
[5446612.113370]  [00000000005f9e7c] SyS_mkdirat+0xdc/0x120
[5446612.113377]  [00000000005f9ed4] SyS_mkdir+0x14/0x40
[5446612.113387]  [00000000004061f4] linux_sparc_syscall+0x34/0x44
[5446612.113393] Disabling lock debugging due to kernel taint
[5446612.113400] Caller[000000000058f3a8]: kstrdup+0x28/0x60
[5446612.113406] Caller[000000000058f41c]: kstrdup_const+0x3c/0x60
[5446612.113412] Caller[0000000000666030]: __kernfs_new_node+0x10/0xc0
[5446612.113418] Caller[00000000006672c4]: kernfs_new_node+0x24/0x60
[5446612.113424] Caller[000000000066769c]: kernfs_create_dir_ns+0x1c/0x80
[5446612.113430] Caller[00000000004ffd40]: cgroup_mkdir+0x1c0/0x320
[5446612.113436] Caller[000000000066721c]: kernfs_iop_mkdir+0x5c/0xa0
[5446612.113443] Caller[00000000005f46dc]: vfs_mkdir+0x11c/0x1a0
[5446612.113449] Caller[00000000005f9e7c]: SyS_mkdirat+0xdc/0x120
[5446612.113455] Caller[00000000005f9ed4]: SyS_mkdir+0x14/0x40
[5446612.113462] Caller[00000000004061f4]: linux_sparc_syscall+0x34/0x44
[5446612.113468] Caller[fff80001001ef870]: 0xfff80001001ef870
[5446612.113473] Instruction DUMP:[5446612.113476]  ba100008
 400f1d4f [5446612.113483]  01000000
<3ffffff2>[5446612.113489]  01000000
 106fffbe [5446612.113496]  01000000
 c611a036 [5446612.113502]  05002c16
[5446612.113506]
[5446612.114772]               \|/ ____ \|/
[5446612.114772]               "@'/ .. \`@"
[5446612.114772]               /_| \__/ |_\
[5446612.114772]                  \__U_/
[5446612.114791] systemd(1): Kernel illegal instruction [#2]
[5446612.114800] CPU: 12 PID: 1 Comm: systemd Tainted: G      D
 4.9.0-rc1+ #19
[5446612.114811] task: fff8000815deb620 task.stack: fff8000815dec000
[5446612.114819] TSTATE: 0000004411001602 TPC: 00000000005cd66c TNPC:
00000000005cd670 Y: 00000000    Tainted: G      D
[5446612.114833] TPC: <__kmalloc+0x14c/0x240>
[5446612.114841] g0: 0000000000b5b800 g1: 0000000000400000 g2:
0000000000000000 g3: fff800080facf2b0
[5446612.114852] g4: fff8000815deb620 g5: fff800082c550000 g6:
fff8000815dec000 g7: 0000000000000000
[5446612.114864] o0: 0000000000000000 o1: 00000000024000c0 o2:
fff800080fe49800 o3: 0000000000000000
[5446612.114875] o4: fff8000813586c80 o5: fff800080f93f600 sp:
fff8000815dee2f1 ret_pc: 00000000005cd664
[5446612.114888] RPC: <__kmalloc+0x144/0x240>
[5446612.114896] l0: fff8000030402260 l1: fff8000100000000 l2:
0000000000c813e0 l3: 0000000000000000
[5446612.114909] l4: 0000000000000012 l5: 0002000000000002 l6:
0000000000c606f0 l7: 0000000000c60f68
[5446612.114920] i0: 0000000000000030 i1: 00000000024000c0 i2:
0000000000631278 i3: 00000000024000c0
[5446612.114932] i4: fff800081564dc88 i5: 00000000024000c0 i6:
fff8000815dee3a1 i7: 0000000000631278
[5446612.114952] I7: <inotify_handle_event+0x98/0x1a0>
[5446612.114959] Call Trace:
[5446612.114967]  [0000000000631278] inotify_handle_event+0x98/0x1a0
[5446612.114977]  [0000000000631d4c] inotify_ignored_and_remove_idr+0x2c/0x60
[5446612.114986]  [00000000006313b0] inotify_freeing_mark+0x10/0x20
[5446612.114996]  [000000000062f984] __fsnotify_free_mark+0x44/0xa0
[5446612.115005]  [00000000006303d4] fsnotify_detach_group_marks+0x34/0x80
[5446612.115014]  [000000000062f420] fsnotify_destroy_group+0x20/0x80
[5446612.115023]  [00000000006314bc] inotify_release+0x1c/0x60
[5446612.115036]  [00000000005ea23c] __fput+0x9c/0x220
[5446612.115045]  [00000000005ea42c] ____fput+0xc/0x20
[5446612.115059]  [0000000000486760] task_work_run+0xa0/0xe0
[5446612.115070]  [000000000046c4d8] do_exit+0x318/0xb40
[5446612.115081]  [000000000042872c] die_if_kernel+0x16c/0x320
[5446612.115091]  [000000000042aa9c] do_illegal_instruction+0x17c/0x1a0
[5446612.115103]  [0000000000420210] tl0_ill+0x10/0x20
[5446612.115112]  [00000000005ccfec] __kmalloc_track_caller+0x14c/0x240
[5446612.115121]  [000000000058f3a8] kstrdup+0x28/0x60
[5446612.115130] Caller[0000000000631278]: inotify_handle_event+0x98/0x1a0
[5446612.115140] Caller[0000000000631d4c]:
inotify_ignored_and_remove_idr+0x2c/0x60
[5446612.115151] Caller[00000000006313b0]: inotify_freeing_mark+0x10/0x20
[5446612.115161] Caller[000000000062f984]: __fsnotify_free_mark+0x44/0xa0
[5446612.115170] Caller[00000000006303d4]: fsnotify_detach_group_marks+0x34/0x80
[5446612.115179] Caller[000000000062f420]: fsnotify_destroy_group+0x20/0x80
[5446612.115188] Caller[00000000006314bc]: inotify_release+0x1c/0x60
[5446612.115199] Caller[00000000005ea23c]: __fput+0x9c/0x220
[5446612.115207] Caller[00000000005ea42c]: ____fput+0xc/0x20
[5446612.115215] Caller[0000000000486760]: task_work_run+0xa0/0xe0
[5446612.115223] Caller[000000000046c4d8]: do_exit+0x318/0xb40
[5446612.115232] Caller[000000000042872c]: die_if_kernel+0x16c/0x320
[5446612.115240] Caller[000000000042aa9c]: do_illegal_instruction+0x17c/0x1a0
[5446612.115248] Caller[0000000000420210]: tl0_ill+0x10/0x20
[5446612.115256] Caller[00000000005ccfe4]: __kmalloc_track_caller+0x144/0x240
[5446612.115266] Caller[000000000058f3a8]: kstrdup+0x28/0x60
[5446612.115273] Caller[000000000058f41c]: kstrdup_const+0x3c/0x60
[5446612.115281] Caller[0000000000666030]: __kernfs_new_node+0x10/0xc0
[5446612.115290] Caller[00000000006672c4]: kernfs_new_node+0x24/0x60
[5446612.115299] Caller[000000000066769c]: kernfs_create_dir_ns+0x1c/0x80
[5446612.115308] Caller[00000000004ffd40]: cgroup_mkdir+0x1c0/0x320
[5446612.115316] Caller[000000000066721c]: kernfs_iop_mkdir+0x5c/0xa0
[5446612.115325] Caller[00000000005f46dc]: vfs_mkdir+0x11c/0x1a0
[5446612.115335] Caller[00000000005f9e7c]: SyS_mkdirat+0xdc/0x120
[5446612.115337]               \|/ ____ \|/
[5446612.115337]               "@'/ .. \`@"
[5446612.115337]               /_| \__/ |_\
[5446612.115337]                  \__U_/
[5446612.115339] dbus-daemon(521): Kernel illegal instruction [#3]
[5446612.115342] CPU: 15 PID: 521 Comm: dbus-daemon Tainted: G      D
       4.9.0-rc1+ #19
[5446612.115347] task: fff800080b331bc0 task.stack: fff80007f937c000
[5446612.115349] TSTATE: 0000004411001606 TPC: 00000000005ccfec TNPC:
00000000005ccff0 Y: 00000000    Tainted: G      D
[5446612.115353] TPC: <__kmalloc_track_caller+0x14c/0x240>
[5446612.115355] g0: fff800080fb28b00 g1: 0000000000400000 g2:
0000000000000000 g3: 00000000c0000000
[5446612.115357] g4: fff800080b331bc0 g5: fff800082c5b0000 g6:
fff80007f937c000 g7: 0000000000003c06
[5446612.115358] o0: 0000000000000000 o1: 00000000025106c0 o2:
000000005a5a5a5a o3: fff800080fb28b00
[5446612.115360] o4: 5a5a5a5a5a5a5a5a o5: 0000000000000028 sp:
fff80007f937eda1 ret_pc: 00000000005ccfe4
[5446612.115362] RPC: <__kmalloc_track_caller+0x144/0x240>
[5446612.115365] l0: fff8000030402800 l1: 000007feffe44e40 l2:
000007feffe452b0 l3: 0000000000000000
[5446612.115367] l4: 0000000000000000 l5: 0000000000000020 l6:
fff8000100b875c8 l7: fff800010026bf30
[5446612.115368] i0: 0000000000000240 i1: 00000000025106c0 i2:
0000000000864e00 i3: 00000000025106c0
[5446612.115371] i4: 0000000000000000 i5: 00000000025106c0 i6:
fff80007f937ee51 i7: 0000000000864d40
[5446612.115376] I7: <__kmalloc_reserve.isra.5+0x20/0x80>
[5446612.115376] Call Trace:
[5446612.115378]  [0000000000864d40] __kmalloc_reserve.isra.5+0x20/0x80
[5446612.115381]  [0000000000864e00] __alloc_skb+0x60/0x180
[5446612.115383]  [0000000000864f68] alloc_skb_with_frags+0x48/0x1c0
[5446612.115390]  [000000000085f54c] sock_alloc_send_pskb+0x1ec/0x220
[5446612.115400]  [00000000009367a8] unix_stream_sendmsg+0x228/0x380
[5446612.115404]  [0000000000859ddc] sock_sendmsg+0x3c/0x80
[5446612.115406]  [000000000085a810] ___sys_sendmsg+0x250/0x260
[5446612.115409]  [000000000085b794] __sys_sendmsg+0x34/0x80
[5446612.115411]  [000000000085b800] SyS_sendmsg+0x20/0x40
[5446612.115415]  [00000000004061f4] linux_sparc_syscall+0x34/0x44
[5446612.115417] Caller[0000000000864d40]: __kmalloc_reserve.isra.5+0x20/0x80
[5446612.115419] Caller[0000000000864e00]: __alloc_skb+0x60/0x180
[5446612.115423] Caller[0000000000864f68]: alloc_skb_with_frags+0x48/0x1c0
[5446612.115425] Caller[000000000085f54c]: sock_alloc_send_pskb+0x1ec/0x220
[5446612.115428] Caller[00000000009367a8]: unix_stream_sendmsg+0x228/0x380
[5446612.115430] Caller[0000000000859ddc]: sock_sendmsg+0x3c/0x80
[5446612.115433] Caller[000000000085a810]: ___sys_sendmsg+0x250/0x260
[5446612.115435] Caller[000000000085b794]: __sys_sendmsg+0x34/0x80
[5446612.115437] Caller[000000000085b800]: SyS_sendmsg+0x20/0x40
[5446612.115439] Caller[00000000004061f4]: linux_sparc_syscall+0x34/0x44
[5446612.115442] Caller[fff800010081770c]: 0xfff800010081770c
[5446612.115444] Instruction DUMP:
[5446612.115445]  ba100008
[5446612.115446]  400f1d4f
[5446612.115447]  01000000
[5446612.115447] <3ffffff2>
[5446612.115448]  01000000
[5446612.115450]  106fffbe
[5446612.115451]  01000000
[5446612.115452]  c611a036
[5446612.115452]  05002c16
[5446612.115452]
[5446612.115778] Caller[00000000005f9ed4]: SyS_mkdir+0x14/0x40
[5446612.115791] Caller[00000000004061f4]: linux_sparc_syscall+0x34/0x44
[5446612.115802] Caller[fff80001001ef870]: 0xfff80001001ef870
[5446612.115818] Instruction DUMP:[5446612.115823]  ba100008
 400f1baf [5446612.115839]  01000000
<3ffffff2>[5446612.115852]  01000000
 106fffbe [5446612.115866]  01000000
 c611a036 [5446612.115879]  05002c16
[5446612.115892]
[5446612.115902] Fixing recursive fault but reboot is needed!
