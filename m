From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Tue, 30 Mar 2004 03:19:59 +0000
Subject: 2.6.5rc2 panics on ss5/110
Message-Id: <1080616798.16068.37.camel@zorak>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2.6.5rc2 panics on my ss5/110. I am booting off an external scsi disk on
lun 5, with an external scsi cdrom at lun 6. The kernel panics after
hitting the internal disk on lun 3, which i am NOT using for linux. It
seems to have trouble scanning the whole bus.

Panic is as follows (handcopied):

Loading esp.ko module
esp0: IRQ 36 SCSI ID 7 Clk 40 MHz CCYC%000 CCF=8 TOut 167
NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A-FAST
  Vendor: SEAGATE   Model: ST31200W SUN 1.05  Rev: 8566
  Type:   Direct-Access                       ANSI SCSI revision: 02
esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000006
tsk->{mm,active_mm}->pgd = fc02d000
              \|/ ____ \|/
              "@'/ ,. \'@"
              /_| \__/ |_\
                 \__U_/
insmod(144): Oops [#1]
PSR: 04401fc2 PC: f00cc780 NPC: f00cc784 Y: 00000000    Not tainted
PC: <vsnprintf+0x4f0/0x604>
%G: f10fd778 00000008  00000000 001f7334  fe3152c4 0000004c  f10fc000
00000008
%O: 00000000 f10fd954  00000008 00000463  fffffecc 00000000  f10fd7b0
f00cc778
RPC: <vsnprintf+0x4e8/0x604>
%L: ffffffff 00000000  f021684f ffffffff  f0216450 00000000  0098963c
f012fc80
%I: f0216464 00000400  0000000a f10fd94c  00000018 f106069c  f10fd828
f00cc8a8
Caller[f00cc8a8]: vscnprintf+0x14/0x30
Caller[f0030f40]: printk+0x60/0x188
Caller[fe3143bc]: sd_read_capacity+0x364/0x3d4 [sd_mod]
Caller[fe314958]: sd_revalidate_disk+0xf4/0x154 [sd_mod]
Caller[fe314c70]: sd_probe+0x2b8/0x370 [sd_mod]
Caller[f00f31a8]: bus_match+0x40/0x6c
Caller[f00f3224]: device_attach+0x50/0x9c
Caller[f00f33e4]: bus_add_device+0x48/0x74
Caller[f00f2550]: device_add+0x6c/0x108
Caller[fe33164c]: scsi_sysfs_add_sdev+0x20/0x208 [scsi_mod]
Caller[fe3302fc]: scsi_add_lun+0x410/0x424 [scsi_mod]
Caller[fe33046c]: scsi_probe_and_add_lun+0x15c/0x230 [scsi_mod]
Caller[fe330bb4]: scsi_scan_target+0x58/0xd4 [scsi_mod]
Caller[fe330c8c]: scsi_scan_channel+0x5c/0x8c [scsi_mod]
Caller[fe330d9c]: scso_scan_host_selected+0xe0/0x144 [scsi_mod]
Caller[fe30dd40]: init_this_scsi_driver+0x8c/0xe0 [esp]
Caller[f0047330]: sys_init_module+0x138/0x278
Caller[f0012968]: syscall_is_too_hard+0x34/0x40
Caller[00013c8c]: 0x13c8c
Instruction DUMP: 9210001b  40000ea0  9007bff0 <d41a0000> 1080002b
b606e008  12800008  8219605a  c206c000
ERROR: /bin/insmod exited abnormally!
Loading jbd.ko module
Loading ext3.ko module
Creating block devices
VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)
  <0>Press L1-A to return to the boot prom

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not 
to be published." -- Aldous Huxley's "Brave New World"

