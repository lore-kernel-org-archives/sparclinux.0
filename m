From: raoul@shuttle.de (Raoul Borenius)
Date: Thu, 22 Jan 2004 14:18:46 +0000
Subject: kernel-oops with 2.4.24-smp on Ultra II
Message-Id: <20040122141846.GA31934@bunny.shuttle.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

on one of our Ultra IIs oops'ed today, see attachments.
Please tell me if you need more information.

Regards

  Raoul

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.9 on sparc64 2.4.24-smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24-smp/ (default)
     -m /boot/System.map-2.4.24-smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request in mna handler<1> at virtual address 4141414141414169
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
bounce(30961): Oops
CPU[0]: local_irq_count[0] irqs_running[0]
TSTATE: 0000009911009606 TPC: 00000000005691c0 TNPC: 00000000005691c4 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 0000000000000000 g1: fffff80046b49800 g2: 0000000000000028 g3: fffff800067ab960
g4: fffff80000000000 g5: 0000000000000000 g6: fffff8002349c000 g7: 0000000000000000
o0: 0000000000000001 o1: 4141414141414169 o2: 0000000000000010 o3: 0000000000000008
o4: 000000007025349c o5: fffff80044633ae0 sp: fffff8002349f411 ret_pc: 000000000046b084
l0: 4141414141414141 l1: fffff800067ab964 l2: 0000000000000000 l3: 0000000000000000
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000070099250
i0: 0000000000000005 i1: fffff8002349fe60 i2: fffff800067aba10 i3: fffff80044633ae8
i4: fffff800067aba10 i5: fffff80044633ae8 i6: fffff8002349f4d1 i7: 000000000047e5e4
Caller[000000000047e5e4]
Caller[000000000042a43c]
Caller[0000000000410874]
Caller[0000000070087bc4]
Instruction DUMP: 00000000  00000000  00000000 <ca024000> 8e014008  cfe25005  80a14007  1247fffc  8143e00a 


>>PC;  005691c0 <__atomic_add+0/0>   <=====

>>ret_pc; 0046b084 <fget+44/60>
>>i7; 0047e5e4 <do_select+124/240>

Trace; 0047e5e4 <do_select+124/240>
Trace; 0042a43c <sys32_select+2bc/4c0>
Trace; 00410874 <linux_sparc_syscall32+34/40>
Trace; 70087bc4 <END_OF_CODE+6e0527a5/????>

Code;  005691b4 <VISenterhalf+b4/c0>
00000000 <_PC>:
Code;  005691c0 <__atomic_add+0/0>   <=====
   c:   ca 02 40 00       ld  [ %o1 ], %g5   <=====
Code;  005691c4 <atomic_impl_begin+4/20>
  10:   8e 01 40 08       add  %g5, %o0, %g7
Code;  005691c8 <atomic_impl_begin+8/20>
  14:   cf e2 50 05       unknown
Code;  005691cc <atomic_impl_begin+c/20>
  18:   80 a1 40 07       cmp  %g5, %g7
Code;  005691d0 <atomic_impl_begin+10/20>
  1c:   12 47 ff fc       unknown
Code;  005691d4 <atomic_impl_begin+14/20>
  20:   81 43 e0 0a       unknown

CPU[1]: local_irq_count[0] irqs_running[0]
TSTATE: 0000004400000a06 TPC: 000000007007a9c4 TNPC: 000000007007a9c8 Y: 00000003    Not tainted
g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000000020 g3: 0000000000000000
g4: 00000000ffffffff g5: 0000000000000000 g6: 0000000000000070 g7: 0000000070015618
o0: 00000000efffebc7 o1: 0000000000016826 o2: 0000000000000001 o3: 0000000000000004
o4: 0000000000000000 o5: 00000000701535d8 sp: 00000000efffe628 ret_pc: 000000007007a7f0
l0: 00000000 l1: 00000001 l2: 0000000a l3: 669b7cf0 l4: 0058a000 l5: 00000016 l6: 0000000a l7: 70174c2c
i0: efffec30 i1: efffebc7 i2: efffede4 i3: 00027878 i4: 00000002 i5: 00000064 i6: efffebd0 i7: 7009cf64


>>PC;  7007a9c4 <END_OF_CODE+6e0455a5/????>   <=====

>>l4; 0058a000 <abi_table+d0/230>

Unable to handle kernel paging request in mna handler<1> at virtual address 414751426b414169
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
bounce(30961): Oops
CPU[0]: local_irq_count[0] irqs_running[0]
TSTATE: 0000004480009606 TPC: 0000000000469664 TNPC: 0000000000469668 Y: 00000000    Not tainted
g0: 0000000000026000 g1: fffff80046b49800 g2: 0000000000000000 g3: 0000000000000000
g4: fffff80000000000 g5: 0000000000000000 g6: fffff8002349c000 g7: 414751426b414141
o0: 000000000043a800 o1: 0000000000000032 o2: fffff80006484004 o3: 000000000061c600
o4: fffff80063fc8000 o5: 0000000000000006 sp: fffff8002349ecd1 ret_pc: 0000000000455e2c
l0: 0000000000000000 l1: 00000000efffc000 l2: 0000000000000000 l3: 0000000000004000
l4: 0000000000642c00 l5: 0000000000000000 l6: 0000000000000000 l7: 000000000000000f
i0: 414751426b414141 i1: fffff800067ab960 i2: 0000000000000002 i3: 0000000000000002
i4: 0000000000653400 i5: 0000000000000000 i6: fffff8002349ed91 i7: 000000000044582c
Caller[000000000044582c]
Caller[0000000000446134]
Caller[000000000041bc0c]
Caller[0000000000422444]
Caller[0000000000422958]
Caller[000000000041bd88]
Caller[00000000004105c0]
Caller[000000000046b084]
Caller[000000000047e5e4]
Caller[000000000042a43c]
Caller[0000000000410874]
Caller[0000000070087bc4]
Instruction DUMP: 01000000  01000000  9de3bf40 <c2062028> 110015c4  a0102000  80a06000  0240002b  901220c8 


>>PC;  00469664 <filp_close+4/e0>   <=====

>>o0; 0043a800 <__cheetah_flush_tlb_range+14/50>
>>o3; 0061c600 <cpu_data+0/1000>
>>ret_pc; 00455e2c <exit_mmap+12c/180>
>>l4; 00642c00 <pidhash+1ff0/2000>
>>i4; 00653400 <block_list+10/18>
>>i7; 0044582c <put_files_struct+ac/120>

Trace; 0044582c <put_files_struct+ac/120>
Trace; 00446134 <do_exit+114/3c0>
Trace; 0041bc0c <die_if_kernel+ec/140>
Trace; 00422444 <kernel_mna_trap_fault+104/1e0>
Trace; 00422958 <kernel_unaligned_trap_fault+4/4c>
Trace; 0041bd88 <mem_address_unaligned+28/80>
Trace; 004105c0 <do_mna+3c/4c>
Trace; 0046b084 <fget+44/60>
Trace; 0047e5e4 <do_select+124/240>
Trace; 0042a43c <sys32_select+2bc/4c0>
Trace; 00410874 <linux_sparc_syscall32+34/40>
Trace; 70087bc4 <END_OF_CODE+6e0527a5/????>

Code;  00469658 <sys_creat+18/20>
00000000 <_PC>:
Code;  00469658 <sys_creat+18/20>
   0:   01 00 00 00       nop 
Code;  0046965c <sys_creat+1c/20>
   4:   01 00 00 00       nop 
Code;  00469660 <filp_close+0/e0>
   8:   9d e3 bf 40       save  %sp, -192, %sp
Code;  00469664 <filp_close+4/e0>   <=====
   c:   c2 06 20 28       ld  [ %i0 + 0x28 ], %g1   <=====
Code;  00469668 <filp_close+8/e0>
  10:   11 00 15 c4       sethi  %hi(0x571000), %o0
Code;  0046966c <filp_close+c/e0>
  14:   a0 10 20 00       clr  %l0
Code;  00469670 <filp_close+10/e0>
  18:   80 a0 60 00       cmp  %g1, 0
Code;  00469674 <filp_close+14/e0>
  1c:   02 40 00 2b       unknown
Code;  00469678 <filp_close+18/e0>
  20:   90 12 20 c8       or  %o0, 0xc8, %o0

CPU[1]: local_irq_count[0] irqs_running[0]
TSTATE: 0000000411009600 TPC: 00000000004864d4 TNPC: 00000000004864d8 Y: 00000000    Not tainted
g0: fffff800406fb160 g1: 00000000005c4000 g2: 0000000000000000 g3: fffff80023f8f090
g4: fffff80000000000 g5: 00000000006526e8 g6: fffff80062c0c000 g7: 00000000000000ff
o0: fffff80023f8f080 o1: fffff800638074e0 o2: 0000000000000000 o3: 0000000080808080
o4: 000000000002b340 o5: 0000000000000000 sp: fffff80062c0f221 ret_pc: 0000000000484f04
l0: 0000000000000000 l1: fffff80063807574 l2: fffff80063807560 l3: 0000000000000007
l4: 0000000000000000 l5: 00000000005c5800 l6: 0000000000000000 l7: 000000000058da30
i0: fffff80023f8f080 i1: 00000000006526e8 i2: 0000000000020000 i3: 000000000056b100
i4: fffff80067efa77c i5: fffff80062c0fb40 i6: fffff80062c0f2e1 i7: 0000000000485fac
Warning (Oops_read): Code line not seen, dumping what data is available


>>PC;  004864d4 <remove_dquot_ref+374/4a0>   <=====

>>g1; 005c4000 <kernel_flag+0/0>
>>g5; 006526e8 <inode_lock+0/8>
>>ret_pc; 00484f04 <clear_inode+4/160>
>>l5; 005c5800 <tasklet_hi_vec+700/800>
>>l7; 0058da30 <dentry_stat+0/18>
>>i1; 006526e8 <inode_lock+0/8>
>>i3; 0056b100 <small_digits.0+0/28>
>>i7; 00485fac <iput+30c/360>


2 warnings issued.  Results may not be reliable.

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.txt"

PROMLIB: Sun IEEE Boot Prom 3.7.0 1997/01/09 13:06
Linux version 2.4.24-smp (root@test9) (gcc version 3.3.2 (Debian)) #1 SMP Mon Jan 12 16:45:11 CET 2004
ARCH: SUN4U
Ethernet address: 08:00:20:9b:f3:47
On node 0 totalpages: 65107
zone(0): 212904 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Found CPU 0 (node=f0071294,mid=0)
Found CPU 1 (node=f0071600,mid=1)
Found 2 CPU prom device tree node(s).
Kernel command line: root=/dev/sda1 ro devfs=mount
Calibrating delay loop... 591.46 BogoMIPS
Memory: 500816k available (1440k kernel code, 216k data, 72k init) [fffff80000000000,0000000067f50000]
Dentry cache hash table entries: 65536 (order: 7, 1048576 bytes)
Inode cache hash table entries: 32768 (order: 6, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer cache hash table entries: 32768 (order: 5, 262144 bytes)
Page-cache hash table entries: 65536 (order: 6, 524288 bytes)
POSIX conformance testing by UNIFIX
Entering UltraSMPenguin Mode...
Calibrating delay loop... 591.46 BogoMIPS
Total of 2 processors activated (1182.92 BogoMIPS).
Waiting on wait_init_idle (map = 0x2)
CPU 1: synchronized TICK with master CPU (last diff -11 cycles,maxerr 539 cycles)
All processors have done init_idle
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: HME DVMA gate array 
Sparc Zilog8530 serial driver version 1.68.2.2
Sun Mouse-Systems mouse driver version 1.00
tty00 at 0xf1100004 (irq = 12,7e8) is a Zilog8530
tty01 at 0xf1100000 (irq = 12,7e8) is a Zilog8530
tty02 at 0xf1000004 (irq = 12,7e8) is a Zilog8530
tty03 at 0xf1000000 (irq = 12,7e8) is a Zilog8530
keyboard: not present
Console: ttyS0 (Zilog8530)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
SCSI subsystem driver Revision: 1.00
esp0: IRQ 4,7e0 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP366-HME
  Vendor: SEAGATE   Model: ST32550W SUN2.1G  Rev: 0418
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST34371W SUN4.2G  Rev: 7462
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0720
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0764
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0764
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: FUJITSU   Model: MAN3367MC         Rev: 0109
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: FUJITSU   Model: MAN3367MC         Rev: 0109
  Type:   Direct-Access                      ANSI SCSI revision: 03
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
Attached scsi disk sdg at scsi0, channel 0, id 6, lun 0
esp0: target 0 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sda: 4194995 512-byte hdwr sectors (2148 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
esp0: target 1 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdb: 8385121 512-byte hdwr sectors (4293 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p3
esp0: target 2 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdc: 8386733 512-byte hdwr sectors (4294 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1 p3
esp0: target 3 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdd: 8386733 512-byte hdwr sectors (4294 MB)
 /dev/scsi/host0/bus0/target3/lun0: p1 p3
esp0: target 4 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sde: 8386733 512-byte hdwr sectors (4294 MB)
 /dev/scsi/host0/bus0/target4/lun0: p1 p3
esp0: target 5 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdf: 71771688 512-byte hdwr sectors (36747 MB)
 /dev/scsi/host0/bus0/target5/lun0: p1 p3
esp0: target 6 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdg: 71771688 512-byte hdwr sectors (36747 MB)
 /dev/scsi/host0/bus0/target6/lun0: p1 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Unimplemented SPARC system call 188
Unimplemented SPARC system call 188
Unimplemented SPARC system call 188
Unimplemented SPARC system call 188
Unimplemented SPARC system call 188
Unimplemented SPARC system call 188
Adding Swap: 523624k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
sunhme.c:v2.01 26/Mar/2002 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:9b:f3:47 
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
 [events: 00000025]
md: bind<scsi/host0/bus0/target6/lun0/part1,1>
 [events: 00000025]
md: bind<scsi/host0/bus0/target5/lun0/part1,2>
md: scsi/host0/bus0/target5/lun0/part1's event counter: 00000025
md: scsi/host0/bus0/target6/lun0/part1's event counter: 00000025
md: RAID level 1 does not need chunksize! Continuing anyway.
md: raid1 personality registered as nr 3
md0: max total readahead window set to 248k
md0: 1 data-disks, max readahead per data-disk: 248k
raid1: device scsi/host0/bus0/target5/lun0/part1 operational as mirror 0
raid1: device scsi/host0/bus0/target6/lun0/part1 operational as mirror 1
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: scsi/host0/bus0/target5/lun0/part1 [events: 00000026]<6>(write) scsi/host0/bus0/target5/lun0/part1's sb offset: 35881920
md: scsi/host0/bus0/target6/lun0/part1 [events: 00000026]<6>(write) scsi/host0/bus0/target6/lun0/part1's sb offset: 35881920
 [events: 0000000f]
md: bind<scsi/host0/bus0/target6/lun0/disc,1>
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,17), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,33), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,49), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.

--envbJBWh7q8WU6mo--
