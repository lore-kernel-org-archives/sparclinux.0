From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Sep 2004 13:00:23 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <E1C9kFr-0003Fp-Pl@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

MRH> Sun Ultra Enterprise 2 was hardlocking in 2.6.xx. Never responded to keyboard
MRH> input. Sometimes would respond to pings and SSH connections for a while, but
MRH> would always lock hard eventually with no errors. Note that this exact same
MRH> system works perfectly in 2.4.xx. I reiterate, SMP functions correctly there.
MRH> Obviously something has changed and caused functionality to break, hence why I
MRH> have marked this bug high severity. IMHO, "stable" kernel series should not
MRH> result in a step back in hardware compatibility.
MRH> 
MRH> Disabling SMP resulted in a working system.

Exactly the same here. Dual 168 MHz UE2, with CG6 card. Network activity
hangs the machine after some activity (like before getting a prompt from
sshor while doing a test ls -alR over ssh). Keyboard produces no input,
even when configured as kernel keymap. Additionally, serial console
behaves bad - kernel messages come through fine but user level messages
are very slow and only output char by char when these is scsi disk
activity, and any serial console output ceases when the disk goes idle.
I tried loading and unloading the cd tray, hoping that maybe it causes
scsi interrupts and I see some more output but it didn't seem to work
(maybe media load does not cause unit attention, I'm not sure).

I got a working U2 config from Dustin Marquess, this still hangs my
machine.

Additionally with the recent 2.6.9-rc* BK snapshots, the display stays
black and no framebuffer console is seen. Network works until it hangs.

Here is full dmesg (using console=ttyS0), the lines beginning with udev
are the character-at-a-time slow ones.

PROMLIB: Sun IEEE Boot Prom 3.25.0 1999/12/03 11:35
Linux version 2.6.9-rc2 (mroos@kookos) (gcc version 3.3.4 (Debian 1:3.3.4-6sarg4
ARCH: SUN4U
Ethernet address: 08:00:20:86:56:4a
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro console=ttyS0
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1035840k available (1768k kernel code, 536k data, 112k init) [fffff8000]
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
CPU 1: synchronized TICK with master CPU (last diff 0 cycles,maxerr 384 cycles)
Brought up 2 CPUs
Total of 2 processors activated (665.60 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 186099 cycles, 1 ticks.
NET: Registered protocol family 16
SCSI subsystem initialized
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: HME DVMA gate array
Console: switching to colour frame buffer device 144x56
cg6: CGsix [TGX+ sparc] at 1ff:10000000
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin` sec (no)
zs2 at 0x000001fff1000004 (irq = 12,7e8) is a SunZilog
zs3 at 0x000001fff1000000 (irq = 12,7e8) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 6777600) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 6777600) is a SunZilog
Console: ttyS0 (SunZilog zs0)
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:86:56:4a
esp0: IRQ 4,7e0 SCSI ID 7 Clk 40MHz CCYC%000 CCF=8 TOut 167
NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP366-HME
Using anticipatory io scheduler
  Vendor: IBM-PSG   Model: DNES-309170Y  !#  Rev: SAHR
  Type:   Direct-Access                      ANSI SCSI revision: 03
esp0: target 1 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
  Vendor: TOSHIBA   Model: XM-5401TASUN4XCD  Rev: 1036
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
esp0: target 6 asynchronous
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
udev Adding 399328k swap on /dev/sda2.  Priority:-1 extents:1
requiEXT3 FS on sda1, internal journal
res hotplug support, not started.
