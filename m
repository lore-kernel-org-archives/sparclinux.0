From: Christopher Zimmermann <madroach@zakweb.de>
Date: Wed, 07 Dec 2005 22:11:23 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051207221123.GA678@sparc>
List-Id: <sparclinux.vger.kernel.org>
References: <20051205.181732.34234732.davem@davemloft.net>
In-Reply-To: <20051205.181732.34234732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 07, 2005 at 12:49:12PM -0800, David S. Miller wrote:
> From: Christopher Zimmermann <madroach@zakweb.de>
> Date: Wed, 7 Dec 2005 14:56:27 +0100
> 
> > As I said, I tested 2.6.15rc5, too. It performs as badly as rc3.
> > The symptoms are the same J.H. Aho described. But in contrast to J.H.
> > Aho I can switch back to a vt. By pressing CTRL+c on the vt I started X
> > on, I can kill the X server. This is the output I get after pressing
> > CTRL+c:
> 
> I stand corrected.  This needs some investigation...
> 
> I still think J.H. Aho has his Xorg.conf configured to use "fbdev"
> for that ATI chip instead of "ati", which is a mistake which on
> sparc64 is known to wedge the machine in various ways.
> 
> Your case seems different...  in the debugging the vm_flags is
> 0x184473, which works out to:
> 
> 	VM_READ | VM_WRITE |
> 	VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC |
> 	VM_PFNMAP |
> 	VM_IO |
> 	VM_RESERVED |
> 	VM_ACCOUNT
> 
> The important bit is VM_PFNMAP, that "Bad pte" kernel message triggers
> usually because VM_PFNMAP is set and vma->vm_pgoff does not match what
> is in the PTE, but unfortunately the debugging message does not print
> the vma->vm_pgoff value.
> 
> Let's get that debugging info, shall we?  :-) Please add the patch
> below, and retrigger, then send the full dmesg.
> 
> Thanks a lot.

ok I applied the patch. You want the complete dmesg? Here you go:

PROMLIB: Sun IEEE Boot Prom 3.25.0 1999/12/03 11:35
Linux version 2.6.15-rc5 (madroach@sparc) (gcc version 4.0.2 (Debian 4.0.2-2)) #1 SMP Wed Dec 7 22:26:17 CET 2005
ARCH: SUN4U
Ethernet address: 08:00:20:86:08:46
On node 0 totalpages: 130572
  DMA zone: 130572 pages, LIFO batch:15
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: root=/dev/sda2
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1034960k available (2168k kernel code, 552k data, 136k init) [fffff80000000000,000000003ff44000]
Calibrating delay loop... 589.82 BogoMIPS (lpj79648)
Mount-cache hash table entries: 512
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
Calibrating delay loop... 589.82 BogoMIPS (lpj79648)
CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
CPU 1: synchronized TICK with master CPU (last diff -7 cycles,maxerr 542 cycles)
Brought up 2 CPUs
Total of 2 processors activated (1179.64 BogoMIPS).
NET: Registered protocol family 16
SCSI subsystem initialized
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: HME DVMA gate array 
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Console: switching to colour frame buffer device 106x46
ffb: FFB at 000001fc00000000 type 8 DAC 10
lp: driver loaded but no devices found
SunZilog: 2 chips.
zs2 at 0x000001fff1000004 (irq = 12,7e8) is a SunZilog
zs3 at 0x000001fff1000000 (irq = 12,7e8) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7227840) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7227840) is a SunZilog
parport0: sunbpp at 0x1ffec800000
lp0: using parport0 (interrupt-driven).
loop: loaded (max 8 devices)
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip0: Parallel port at 0x1ffec800000, using IRQ 7227648.
sunhme.c:v2.02 8/24/03 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:86:08:46 
eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:86:08:46 
esp0: IRQ 4,7e0 SCSI ID 7 Clk 40MHz CCYC%000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP366-HME
  Vendor: FUJITSU   Model: MAJ3182M SUN18G   Rev: 0804
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: FUJITSU   Model: MAJ3182M SUN18G   Rev: 0804
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM-5401TASUN4XCD  Rev: 1036
  Type:   CD-ROM                             ANSI SCSI revision: 02
esp0: target 0 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 sda5
sd 0:0:0:0: Attached scsi disk sda
esp0: target 1 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdb: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5
sd 0:0:1:0: Attached scsi disk sdb
esp0: target 6 asynchronous
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:6:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
sr 0:0:6:0: Attached scsi generic sg2 type 5
OBP Flash: RD 1fff0000000[80000] WR 1fff1380000[80000]
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21 2005 UTC).
ALSA device list:
  #0: Sun CS4231 at 0xff:0xdc000000, irq 13,7e4
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
input: Sun Type 5 keyboard as /class/input/input0
input: Sun Mouse as /class/input/input1
sermouse.c: Switched to the 5-byte MSC mouse protocol.
Adding 1999856k swap on /dev/sda5.  Priority:-1 extents:1 across:1999856k
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth1: Auto-Negotiation unsuccessful, trying force link mode
eth1: Link has been forced up using internal transceiver at 10Mb/s, Half Duplex.
Bad pte = 1fc00600a88, process = Xorg, vm_flags = 184473, vm_pgoff = fe00300, vaddr = 7001e000
Call Trace:
 [0000000000439de4] copy_process+0x8e4/0xe40
 [000000000043a380] do_fork+0x40/0x1e0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3bfc] 0x701d3bfc
Bad pte = 1fc00600a88, process = Xorg, vm_flags = 184473, vm_pgoff = fe00300, vaddr = 7001e000
Call Trace:
 [000000000046bc00] exit_mmap+0x80/0x140
 [0000000000439454] mmput+0x34/0xe0
 [0000000000484e6c] flush_old_exec+0x1cc/0x940
 [0000000000427f2c] load_elf_binary+0x3cc/0x15c0
 [00000000004857b4] search_binary_handler+0x74/0x1a0
 [00000000004a3e58] compat_do_execve+0x118/0x1e0
 [000000000041f71c] sparc32_execve+0x3c/0xc0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3d68] 0x701d3d68
Bad pte = 1fc00600a88, process = Xorg, vm_flags = 184473, vm_pgoff = fe00300, vaddr = 7001e000
Call Trace:
 [0000000000439de4] copy_process+0x8e4/0xe40
 [000000000043a380] do_fork+0x40/0x1e0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3bfc] 0x701d3bfc
Bad pte = 1fc00600a88, process = Xorg, vm_flags = 184473, vm_pgoff = fe00300, vaddr = 7001e000
Call Trace:
 [000000000046bc00] exit_mmap+0x80/0x140
 [0000000000439454] mmput+0x34/0xe0
 [0000000000484e6c] flush_old_exec+0x1cc/0x940
 [0000000000427f2c] load_elf_binary+0x3cc/0x15c0
 [00000000004857b4] search_binary_handler+0x74/0x1a0
 [00000000004a3e58] compat_do_execve+0x118/0x1e0
 [000000000041f71c] sparc32_execve+0x3c/0xc0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3d68] 0x701d3d68
Bad pte = 1fc00600a88, process = Xorg, vm_flags = 184473, vm_pgoff = fe00300, vaddr = 7001e000
Call Trace:
 [0000000000439de4] copy_process+0x8e4/0xe40
 [000000000043a380] do_fork+0x40/0x1e0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3bfc] 0x701d3bfc
Bad pte = 1fc00600a88, process = Xorg, vm_flags = 184473, vm_pgoff = fe00300, vaddr = 7001e000
Call Trace:
 [000000000046bc00] exit_mmap+0x80/0x140
 [0000000000439454] mmput+0x34/0xe0
 [0000000000484e6c] flush_old_exec+0x1cc/0x940
 [0000000000427f2c] load_elf_binary+0x3cc/0x15c0
 [00000000004857b4] search_binary_handler+0x74/0x1a0
 [00000000004a3e58] compat_do_execve+0x118/0x1e0
 [000000000041f71c] sparc32_execve+0x3c/0xc0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3d68] 0x701d3d68
Bad pte = 800001fc00600e88, process = Xorg, vm_flags = 184473, vm_pgoff = fe00300, vaddr = 7001e000
Call Trace:
 [000000000046c370] unmap_region+0x90/0x140
 [000000000046cab4] do_munmap+0x174/0x240
 [000000000046cb9c] sys_munmap+0x1c/0x40
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000003d3ee0] 0x3d3ee0
