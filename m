From: RChan <rspchan@starhub.net.sg>
Date: Thu, 07 Oct 2004 10:49:42 +0000
Subject: Ooops on serial logins: V210 and 2.6.[89]
Message-Id: <41651F46.4080800@starhub.net.sg>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Getting the following Oops on serial logins. I'm running agetty on ttyS0/1;
the oops happens after collecting the user name.


Kernel: 2.6.8-1.571 (from Aurora Linux), 2.6.9-rc3 (home-brewed)
Machine: SunFire V210 (detailed dmesg below the oops)
2.4.2[67] are ok.





Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000653
tsk->{mm,active_mm}->pgd = fffff8103d550000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
login(1911): Oops [#1]
TSTATE: 0000009911009600 TPC: 000000000041d480 TNPC: 000000000041d484 Y: 
00000000    Not tainted
TPC: <synchronize_irq+0x0/0x40>
g0: 0000150000000005 g1: 0000000000000006 g2: 0000000000000030 g3: 
0000000000000078
g4: fffff8103ebac1e0 g5: 0000000000000007 g6: fffff8103d7a4000 g7: 
fffff8103fe84010
o0: 0000000000000000 o1: 0000000000000000 o2: fffff8103ef971e0 o3: 
0000000000000000
o4: 0000000000000000 o5: 0000000000000000 sp: fffff8103d7a73a1 ret_pc: 
0000000000559f60
RPC: <uart_shutdown+0xa0/0x120>
l0: fffff8103ed09700 l1: 0000000000000000 l2: ffffffffffffffff l3: 
0000000000000000
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 
0000000000000000
i0: 000000000075fa38 i1: 0000000000000000 i2: 0000000000000001 i3: 
0000000000000000
i4: 0000000000000000 i5: 8000000000000000 i6: fffff8103d7a7461 i7: 
000000000055b9f8
I7: <uart_hangup+0x58/0xc0>
Caller[000000000055b9f8]: uart_hangup+0x58/0xc0
Caller[000000000053f670]: do_tty_hangup+0x2b0/0x3e0
Caller[000000000049016c]: sys_vhangup+0x2c/0x40
Caller[00000000004112b4]: linux_sparc_syscall32+0x34/0x40
Caller[0000000000014e28]: 0x14e28
Instruction DUMP: 01000000  01000000  01000000 <c20a2006> 82086010  
80a06000  02400007  01000000  c20a2006
TSTATE: 00000044f0000a04 TPC: 0000000000024f64 TNPC: 000000007010a120 Y: 
00000000    Not tainted
TPC: <0x24f64>
g0: 0000000000000000 g1: 000000007010a000 g2: 00000000effffc18 g3: 
0000000070029408
g4: 0000000000000001 g5: 0000000000000020 g6: 0000feffffffffff g7: 
00000000700163a8
o0: 0000000000000005 o1: 00000000effff398 o2: 0000000000000001 o3: 
0000000000014548
o4: 00000000fefefeff o5: 00000000effffe30 sp: 00000000effff338 ret_pc: 
0000000000012244
RPC: <0x12244>
l0: 00000000 l1: 00000000 l2: 00000001 l3: effff398 l4: effffc18 l5: 
00026070 l6: effff3d8 l7: 70184290
i0: 00000001 i1: 00000000 i2: 00000022 i3: 00000000 i4: 00000000 i5: 
00000000 i6: effffc20 i7: 00013f18


PROMLIB: Sun IEEE Boot Prom 4.11.4 2003/07/23 08:04
Linux version 2.6.9-rc3.3smp (root@renoir) (gcc version 3.3.4 20040623 
(Gentoo Linux 3.3.4)) #2 SMP Thu Oct 7 17:39:22 SGT 2004
ARCH: SUN4U
Ethernet address: 00:03:ba:8b:61:15
On node 0 totalpages: 261211
  DMA zone: 261211 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: ro root=LABEL=SDA1 video=radeonfb:off
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 1619008k available (2128k kernel code, 912k data, 176k init) 
[fffff80000000000,000000103feae000]
Calibrating delay loop... 665.60 BogoMIPS (lpj32800)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
Calibrating delay loop... 665.60 BogoMIPS (lpj32800)
CPU 0: synchronized TICK with master CPU (last diff -1 cycles,maxerr 6 
cycles)
Brought up 2 CPUs
Total of 2 processors activated (1331.20 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 15397 cycles, 1 ticks.
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 446k freed
NET: Registered protocol family 16
PCI: Probing for controllers.
TOMATILLO0 PBMB: ver[4:0], portid 1f, cregs[4000fc00000] pregs[4000ff00000]
TOMATILLO0 PBMB: PCI CFG[7f600000000] IO[7f601000000] MEM[7f700000000]
TOMATILLO0 PBMA: ver[4:0], portid 1e, cregs[4000f400000] pregs[4000f600000]
TOMATILLO0 PBMA: PCI CFG[7fe00000000] IO[7fe01000000] MEM[7ff00000000]
TOMATILLO1 PBMA: ver[4:0], portid 1c, cregs[4000e400000] pregs[4000e600000]
TOMATILLO1 PBMA: PCI CFG[7ce00000000] IO[7ce01000000] MEM[7cf00000000]
TOMATILLO1 PBMB: ver[4:0], portid 1d, cregs[4000ec00000] pregs[4000ef00000]
TOMATILLO1 PBMB: PCI CFG[7c600000000] IO[7c601000000] MEM[7c700000000]
PCI-IRQ: Routing bus[ 0] slot[ 1] map[0] to INO[04]
PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[1c]
PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[1d]
PCI1(PBMB): Bus running at 66MHz
PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[29]
PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[28]
PCI1(PBMA): Bus running at 66MHz
PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[08]
PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[09]
PCI0(PBMB): Bus running at 66MHz
PCI-IRQ: Routing bus[ 0] slot[ a] map[0] to INO[27]
PCI-IRQ: Routing bus[ 0] slot[ d] map[0] to INO[18]
PCI0(PBMA): Bus running at 33MHz
isa0: [flashprom] [rtc] [i2c -> (i2c-bridge) (i2c-bridge) 
(motherboard-fru-prom) (chassis-fru-prom) (power-supply-fru-prom) 
(dimm-spd) (dimm-spd) (dimm-spd) (dimm-spd) (rscrtc) (nvram) (idprom) 
(gpio) (gpio) (gpio) (gpio)] [power] [serial] [serial] [rmc-comm]
ebus: No EBus's found.
SCSI subsystem initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
Console: switching to mono PROM 80x34
Real Time Clock Driver v1.12
ttyS0 at MMIO 0x7fe010003f8 (irq = 0) is a 16550A
ttyS1 at MMIO 0x7fe010002e8 (irq = 0) is a 16550A
Using anticipatory io scheduler
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0d.0
ALI15X3: chipset revision 196
ALI15X3: 100% native mode on irq 4,798
    ide0: BM-DMA at 0x7fe01000920-0x7fe01000927, BIOS settings: hda:pio, 
hdb:pio
ALI15X3: simplex device: DMA forced
    ide1: BM-DMA at 0x7fe01000928-0x7fe0100092f, BIOS settings: hdc:DMA, 
hdd:DMA
Probing IDE interface ide0...
hda: DV-28E-C, ATAPI CD/DVD-ROM drive
ide0 at 0x7fe01000900-0x7fe01000907,0x7fe0100091a on irq 4,798
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 15
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 4,729
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: FUJITSU   Model: MAP3735N SUN72G   Rev: 0401
  Type:   Direct-Access                      ANSI SCSI revision: 04
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:0:0): Beginning Domain Validation
sym0:0: wide asynchronous.
sym0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
scsi(0:0:0:0): Ending Domain Validation
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 sda5 sda6
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: FUJITSU   Model: MAP3735N SUN72G   Rev: 0401
  Type:   Direct-Access                      ANSI SCSI revision: 04
sym0:1:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:1:0): Beginning Domain Validation
sym0:1: wide asynchronous.
sym0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
scsi(0:0:1:0): Ending Domain Validation
SCSI device sdb: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sym1: <1010-66> rev 0x1 at pci 0002:00:02.1 irq 4,728
sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18j
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 3999152k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda1, internal journal
tg3.c:v3.10 (September 14, 2004)
eth0: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 
10/100/1000BaseT Ethernet 00:03:ba:8b:61:17
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
eth1: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 
10/100/1000BaseT Ethernet 00:03:ba:8b:61:18
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
eth2: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 
10/100/1000BaseT Ethernet 00:03:ba:8b:61:15
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
eth3: Tigon3 [partno(Sun 570X) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 
10/100/1000BaseT Ethernet 00:03:ba:8b:61:16
eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:0a.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:0a.0: irq 10,7a7, pci mem 000007ff01000000
ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
/usr/src/linux-bk.20041007/drivers/usb/input/hid-core.c: v2.0:USB HID 
core driver
usb 1-1: new low speed USB device using address 2
input: USB HID v1.00 Keyboard [0430:0005] on usb-0000:00:0a.0-1
kjournald starting.  Commit interval 5 seconds



