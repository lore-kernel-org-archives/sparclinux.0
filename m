From: <me@0x1337.net>
Date: Tue, 16 Mar 2004 19:18:02 +0000
Subject: XFS ooops in 2.6.4 (sparc64)
Message-Id: <5360627$107946383640574f9c68d2c6.81952132@config3.schlund.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I had to hard-reset my Sun Ultra 5 (440MHz, 512 MB, 2x 18 GB SCSI) today
and unfortunately it ooopsed on xfs recovery:

PROMLIB: Sun IEEE Boot Prom 3.31.0 2001/07/25 20:36                     
                                   
Linux version 2.6.4 (root@darwin) (gcc version 3.3.3 20040217 (Gentoo
Linux 3.3.3)) #1 Thu Jan 1 01:36:50 CET 0
ARCH: SUN4U                                                             
            
Ethernet address: 08:00:20:b5:b4:d9                                     
            
On node 0 totalpages: 64980                                             
            
  DMA zone: 64980 pages, LIFO batch:8                                   
            
  Normal zone: 0 pages, LIFO batch:1                                    
            
  HighMem zone: 0 pages, LIFO batch:1                                   
            
Built 1 zonelists                                                       
            
Kernel command line: root=/dev/sda4                                     
            
PID hash table entries: 2048 (order 11: 32768 bytes)                    
            
Console: colour dummy device 80x25                                      
            
Memory: 513664k available (2392k kernel code, 568k data, 368k init)
[fffff80000000000,000000001ff32000]
Calibrating delay loop... 878.18 BogoMIPS                               
            
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)         
            
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)          
            
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)              
            
POSIX conformance testing by UNIFIX                                     
            
NET: Registered protocol family 16                                      
            
PCI: Probing for controllers.                                           
            
PCI: Found SABRE, main regs at 000001fe00000000, wsync at
000001fe00001c20           
SABRE: Shared PCI config space at 000001fe01000000                      
            
SABRE: DVMA at c0000000 [20000000]                                      
            
PCI-IRQ: Routing bus[ 2] slot[ 1] map[0] to INO[10]                     
            
PCI-IRQ: Routing bus[ 2] slot[ 3] map[0] to INO[18]                     
            
PCI-IRQ: Routing bus[ 2] slot[ 3] map[0] to INO[19]                     
            
PCI0(PBMA): Bus running at 33MHz                                        
            
PCI-IRQ: Routing bus[ 1] slot[ 1] map[0] to INO[21]                     
            
PCI-IRQ: Routing bus[ 1] slot[ 2] map[0] to INO[0f]                     
            
PCI-IRQ: Routing bus[ 1] slot[ 3] map[0] to INO[20]                     
            
PCI0(PBMB): Bus running at 33MHz                                        
            
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree]
[eeprom] [flashprom] [SUNW,CS4231]
power: Control reg at 000001fff1724000 ... powerd running.              
            
SCSI subsystem initialized                                              
            
drivers/usb/core/usb.c: registered new driver hub
ikconfig 0.7 with /proc/config*
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with large block/inode numbers, no debug enabled
Console: switching to mono PROM 80x34
rtc_init: no PC rtc found
su0 at 0x000001fff13062f8 (irq = 4,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
ttyS0 at MMIO 0x1fff1400000 (irq = 7713632) is a SAB82532 V3.2
ttyS1 at MMIO 0x1fff1400040 (irq = 7713632) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.0.16
e100: Copyright(c) 1999-2004 Intel Corporation
sym0: <875> rev 0x14 at pci 0000:02:03.0 irq 4,7d8
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18f
Using anticipatory io scheduler                                  
  Vendor: IBM       Model: IC35L018UWDY10-0  Rev: S27E           
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N           
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym1: <875> rev 0x14 at pci 0000:02:03.1 irq 4,7d9
sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18f
  Vendor: IBM       Model: IC35L018UWDY10-0  Rev: S27E
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym1:0:0: tagged command queuing enabled, command queue depth 16.
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 16)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym1:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 16)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0:
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
sym0:6: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 7)
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 5
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: su/serio1/input on su/serio1
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05
15:41:49 2004 UTC).
ALSA device list:
  #0: Sun CS4231 at 0x1fff1200000, irq 13,7e3
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
XFS mounting filesystem sda4
Starting XFS recovery on filesystem: sda4 (dev: sda4)
TRAPLOG: Error at trap level 0x2, dumping track stack.
TRAPLOG: Trap level 1 TSTATE[0000000080009602] TPC[0000000000542200]
TNPC[0000000000542204] TT[4e]
TRAPLOG: Trap level 2 TSTATE[0000000080009502] TPC[00000000004089c0]
TNPC[00000000004089c0] TT[32]
TRAPLOG: Trap level 3 TSTATE[00000044f0009502] TPC[fffffffffffffffc]
TNPC[fffffffffffffffc] TT[1ff]
TRAPLOG: Trap level 4 TSTATE[00000099f0049402] TPC[fffffffffffffffc]
TNPC[fffffffffffffffc] TT[1ff]
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(1): TL1: Data Access Exception [#1]
TSTATE: 0000000080009502 TPC: 00000000004089c0 TNPC: 00000000004089c0 Y:
00000000    Not tainted
TPC: <tl0_irq14+0x0/0x20>
g0: 0000000000000008 g1: 000000002034a510 g2: fffff8001fcb5ee0 g3:
000000002034a510
g4: fffff8001fecf670 g5: 0000000000000037 g6: fffff8001fec8000 g7:
fffff8001ff25810
o0: fffff8001fc3e080 o1: fffff800000003f0 o2: 0000000000000000 o3:
0000000000000400
o4: 0000000000671d58 o5: 0000000000000001 sp: fffff8001feca2f1 ret_pc:
0000000000515ce4
RPC: <xlog_recover_do_reg_buffer+0xe4/0x160>
l0: 0000000000000001 l1: 0000000000000000 l2: 0000000002034a51 l3:
0000000000000001
l4: fffff8001fcb5eb4 l5: 000000000076f000 l6: 000000000076f000 l7:
000000000070c400
i0: fffff8001fcb0800 i1: fffff8001fcb5f20 i2: fffff8001fc41700 i3:
fffff8001fcb5ea0
i4: 0000000000000000 i5: 0000000000000000 i6: fffff8001feca3b1 i7:
00000000005162a0
I7: <xlog_recover_do_buffer_trans+0x200/0x2e0>
Caller[00000000005162a0]: xlog_recover_do_buffer_trans+0x200/0x2e0
Caller[00000000005170c8]: xlog_recover_do_trans+0x188/0x1a0
Caller[0000000000517250]: xlog_recover_commit_trans+0x30/0x60
Caller[0000000000517380]: xlog_recover_process_data+0xe0/0x1e0
Caller[0000000000517f3c]: xlog_do_recovery_pass+0x15c/0x680
Caller[0000000000518518]: xlog_do_log_recovery+0xb8/0x120
Caller[0000000000518590]: xlog_do_recover+0x10/0x140
Caller[000000000051874c]: xlog_recover+0x8c/0xc0
Caller[00000000005108d8]: xfs_log_mount+0x78/0x100
Caller[0000000000519ccc]: xfs_mountfs+0x52c/0xaa0
Caller[00000000005208ac]: xfs_mount+0x2cc/0x500
Caller[0000000000531fb4]: vfs_mount+0x34/0x60
Caller[0000000000531d78]: linvfs_fill_super+0x98/0x280
Caller[00000000004821f0]: get_sb_bdev+0xf0/0x140
Caller[0000000000482440]: do_kern_mount+0x40/0xe0
Caller[0000000000495a54]: do_add_mount+0x54/0x160
Caller[0000000000495d10]: do_mount+0x110/0x180
Caller[00000000004960f0]: sys_mount+0x90/0xe0
Caller[00000000006ef018]: do_mount_root+0x18/0xa0
Caller[00000000006ef0e4]: mount_block_root+0x44/0x120
Caller[00000000006ef220]: prepare_namespace+0x20/0x120
Caller[00000000004180f8]: init+0x18/0x160
Caller[000000000041b070]: kernel_thread+0x30/0x60
Caller[0000000000418030]: rest_init+0x10/0x40
Instruction DUMP: 400057fb  9203a8bf  306819c1 <85520000> 9190200f 
1068189f  8f414000  9010200e  400057f3 
Kernel panic: Attempted to kill init!

:(
