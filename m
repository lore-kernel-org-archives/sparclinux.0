From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sun, 04 Jan 2004 22:38:06 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <1073255886.22653.63.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-kL/zgwXxIui7IxYC2lj/"
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
To: sparclinux@vger.kernel.org


--=-kL/zgwXxIui7IxYC2lj/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-01-04 at 16:19, Keith M Wesolowski wrote:
> On Sun, Jan 04, 2004 at 09:59:49AM -0600, Tom 'spot' Callaway wrote:
> 
> > This panic happens when I've got a keyboard on it too, I just can't get
> > it all, unless I pull the keyboard and boot it -p over serial.
> > NOTE: This is an UP kernel, even though the SS20 is SMP.
> 
> > Caller[f0207cf4]: serial8250_console_setup+0xa0/0xb0
> 
> I'll look at making it not panic just because of this, but there's
> zero reason to include 8250 support on sparcstations.  Doubly so for
> console support.  Zilog is what you want.

Then it shouldn't be an option. I agree with you about it not being
needed, but perhaps something like the attached patch is prudent (If I
accidentally enable it, others will too)...

I went ahead and rebuilt the kernel without the 8250 support enabled,
and I got both of the oopses in the serial console. Attached is the full
dmesg (includes oopses), the oopses, and the ksymoops results.

Hope that helps,

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

--=-kL/zgwXxIui7IxYC2lj/
Content-Disposition: attachment; filename=linux-2.6.0-no8250forsparc32.patch
Content-Type: text/x-patch; name=linux-2.6.0-no8250forsparc32.patch; charset=
Content-Transfer-Encoding: 7bit

--- linux-2.6.0/drivers/serial/Kconfig.BAD	2004-01-04 23:03:04.000000000 -0500
+++ linux-2.6.0/drivers/serial/Kconfig	2004-01-04 23:03:19.000000000 -0500
@@ -10,6 +10,7 @@
 # The new 8250/16550 serial drivers
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
+	depends on !SPARC32
 	select SERIAL_CORE
 	---help---
 	  This selects whether you want to include the driver for the standard

--=-kL/zgwXxIui7IxYC2lj/
Content-Disposition: attachment; filename=Oops-serial-no8250.txt
Content-Type: text/plain; name=Oops-serial-no8250.txt; charset=
Content-Transfer-Encoding: 7bit

Unable to handle kernel paging request at virtual address 76000000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
PSR: 400010c6 PC: 76000000 NPC: 76000004 Y: 00000000    Not tainted
PC: <0x76000000>
%G: f01bbb48 76000000  00000001 404010e6  f0201354 00000002  f01b9c18 00000000
%O: f0194238 f3000000  00000000 00000006  f021cc00 f021f000  f01bbb48 f01f2d88
RPC: <start_kernel+0x184/0x228>
%L: f0211400 f0223400  00004004 01c00000  00000000 00000000  ffef0000 00000e00
%I: 0000002c 00000003  f01bc800 f01bcb98  40401fe7 f021751c  f01bbbb8 f01f2790
Caller[f01f2790]: sun4c_continue_boot+0x314/0x324
                                                                                                                                
Caller[00000000]: 0x0
                                                                                                                                
Instruction DUMP:<1>Unable to handle kernel paging request at virtual address 75fff000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#2]
PSR: 404010c1 PC: f0013b98 NPC: f0013b9c Y: 00000000    Not tainted
PC: <instruction_dump+0x18/0x64>
%G: f021b800 fffffff4  f01bcb90 40401fe1  f00326f4 404010e1  f01b9c18 00000000
%O: f01bcb90 00000001  fffff8b8 f021b800  f021b800 f021b800  f01bb7f0 f0032654
RPC: <printk+0x184/0x1d0>
%L: fffffffd f0194c00  f01bb750 00000010  00000020 00000000  00200200 00100100
%I: 76000000 00000000  f01bc800 f01bcb98  404010e2 f0217501  f01bb858 f0013d00
Caller[f0013d00]: die_if_kernel+0x11c/0x144
                                                                                                                                
Caller[f001cfd8]: unhandled_fault+0x64/0x90
                                                                                                                                
Caller[f001d240]: do_sparc_fault+0x17c/0x3a8
                                                                                                                                
Caller[f001274c]: srmmu_fault+0x58/0x68
                                                                                                                                
Caller[f01f2d88]: start_kernel+0x184/0x228
                                                                                                                                
Caller[f01f2790]: sun4c_continue_boot+0x314/0x324
                                                                                                                                
Caller[00000000]: 0x0
                                                                                                                                
Instruction DUMP: a0103ffd  233c0653  832c2002 <d4060001> 80a00010  901463b0  92403fff  960a601e  920a601c
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Press L1-A to return to the boot prom

--=-kL/zgwXxIui7IxYC2lj/
Content-Disposition: attachment; filename=ksymoops-serial-no8250.txt
Content-Type: text/plain; name=ksymoops-serial-no8250.txt; charset=
Content-Transfer-Encoding: 7bit

ksymoops 2.4.4 on sparc64 2.6.0-1.23sparc.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-1.23sparc/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 76000000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
PSR: 400010c6 PC: 76000000 NPC: 76000004 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
PC: <0x76000000>
Caller[f01f2790]: sun4c_continue_boot+0x314/0x324

>>PC;  76000000 <__crc_class_device_register+347f33/3e8e82>   <=====
Trace; f01f2790 <sun4c_continue_boot+314/324>

Caller[00000000]: 0x0

Trace; 00000000 Before first symbol

Instruction DUMP:<1>Unable to handle kernel paging request at virtual address 75fff000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#2]
PSR: 404010c1 PC: f0013b98 NPC: f0013b9c Y: 00000000    Not tainted
PC: <instruction_dump+0x18/0x64>
Caller[f0013d00]: die_if_kernel+0x11c/0x144

>>PC;  f0013b98 <instruction_dump+18/64>   <=====
Trace; f0013d00 <die_if_kernel+11c/144>

Caller[f001cfd8]: unhandled_fault+0x64/0x90

Trace; f001cfd8 <unhandled_fault+64/90>

Caller[f001d240]: do_sparc_fault+0x17c/0x3a8

Trace; f001d240 <do_sparc_fault+17c/3a8>

Caller[f001274c]: srmmu_fault+0x58/0x68

Trace; f001274c <srmmu_fault+58/68>

Caller[f01f2d88]: start_kernel+0x184/0x228

Trace; f01f2d88 <start_kernel+184/228>

Caller[f01f2790]: sun4c_continue_boot+0x314/0x324

Trace; f01f2790 <sun4c_continue_boot+314/324>

Caller[00000000]: 0x0

Trace; 00000000 Before first symbol

Instruction DUMP: a0103ffd  233c0653  832c2002 <d4060001> 80a00010  901463b0  92403fff  960a601e  920a601c

Code;  f0013b8c <instruction_dump+c/64>
00000000 <_PC>:
Code;  f0013b8c <instruction_dump+c/64>
   0:   a0 10 3f fd       mov  -3, %l0
Code;  f0013b90 <instruction_dump+10/64>
   4:   23 3c 06 53       sethi  %hi(0xf0194c00), %l1
Code;  f0013b94 <instruction_dump+14/64>
   8:   83 2c 20 02       sll  %l0, 2, %g1
Code;  f0013b98 <instruction_dump+18/64>
   c:   d4 06 00 01       ld  [ %i0 + %g1 ], %o2
Code;  f0013b9c <instruction_dump+1c/64>
  10:   80 a0 00 10       cmp  %g0, %l0
Code;  f0013ba0 <instruction_dump+20/64>
  14:   90 14 63 b0       or  %l1, 0x3b0, %o0
Code;  f0013ba4 <instruction_dump+24/64>
  18:   92 40 3f ff       addx  %g0, -1, %o1
Code;  f0013ba8 <instruction_dump+28/64>
  1c:   96 0a 60 1e       and  %o1, 0x1e, %o3
Code;  f0013bac <instruction_dump+2c/64>
  20:   92 0a 60 1c       and  %o1, 0x1c, %o1

Kernel panic: Attempted to kill the idle task!

1 error issued.  Results may not be reliable.

--=-kL/zgwXxIui7IxYC2lj/
Content-Disposition: attachment; filename=dmesg-serial-no8250.txt
Content-Type: text/plain; name=dmesg-serial-no8250.txt; charset=
Content-Transfer-Encoding: 7bit

Boot device: /iommu/sbus/espdma/esp/sd@3,0:a  File and args:
SILO boot: 2.6 -p
Loading initial ramdisk....
PROMLIB: obio_ranges 5
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.6.0-1.23sparc2 (root@arthur.devel.redhat.com) (gcc version 3.3.1 20030915 (Aurora Linux 3.3.1-5sparc)) #1 
Sun J4ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 8:0:20:73:b8:f
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for srmmu[TI Viking/MXCC]/iommu
31MB HIGHMEM available.
On node 0 totalpages: 23667
  DMA zone: 15652 pages, LIFO batch:3
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 8015 pages, LIFO batch:1
Booting Linux...
Found CPU 0 <node=ffd6f150,mid=8>
Found CPU 1 <node=ffd6f510,mid=10>
Found 2 CPU prom device tree node(s).
Power off control detected.
Building zonelist for node : 0
Kernel command line: root=/dev/sda2 ro -p
PID hash table entries: 2048 (order 11: 16384 bytes)
Console: colour dummy device 80x25
Memory: 86936k available (1596k kernel code, 372k data, 124k init, 32060k highmem) [f0000000,1af4f000]
Unable to handle kernel paging request at virtual address 76000000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
PSR: 400010c6 PC: 76000000 NPC: 76000004 Y: 00000000    Not tainted
PC: <0x76000000>
%G: f01bbb48 76000000  00000001 404010e6  f0201354 00000002  f01b9c18 00000000
%O: f0194238 f3000000  00000000 00000006  f021cc00 f021f000  f01bbb48 f01f2d88
RPC: <start_kernel+0x184/0x228>
%L: f0211400 f0223400  00004004 01c00000  00000000 00000000  ffef0000 00000e00
%I: 0000002c 00000003  f01bc800 f01bcb98  40401fe7 f021751c  f01bbbb8 f01f2790
Caller[f01f2790]: sun4c_continue_boot+0x314/0x324
                                                                                                                                
Caller[00000000]: 0x0
                                                                                                                                
Instruction DUMP:<1>Unable to handle kernel paging request at virtual address 75fff000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#2]
PSR: 404010c1 PC: f0013b98 NPC: f0013b9c Y: 00000000    Not tainted
PC: <instruction_dump+0x18/0x64>
%G: f021b800 fffffff4  f01bcb90 40401fe1  f00326f4 404010e1  f01b9c18 00000000
%O: f01bcb90 00000001  fffff8b8 f021b800  f021b800 f021b800  f01bb7f0 f0032654
RPC: <printk+0x184/0x1d0>
%L: fffffffd f0194c00  f01bb750 00000010  00000020 00000000  00200200 00100100
%I: 76000000 00000000  f01bc800 f01bcb98  404010e2 f0217501  f01bb858 f0013d00
Caller[f0013d00]: die_if_kernel+0x11c/0x144
                                                                                                                                
Caller[f001cfd8]: unhandled_fault+0x64/0x90
                                                                                                                                
Caller[f001d240]: do_sparc_fault+0x17c/0x3a8
                                                                                                                                
Caller[f001274c]: srmmu_fault+0x58/0x68
                                                                                                                                
Caller[f01f2d88]: start_kernel+0x184/0x228
                                                                                                                                
Caller[f01f2790]: sun4c_continue_boot+0x314/0x324
                                                                                                                                
Caller[00000000]: 0x0
                                                                                                                                
Instruction DUMP: a0103ffd  233c0653  832c2002 <d4060001> 80a00010  901463b0  92403fff  960a601e  920a601c
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Press L1-A to return to the boot prom

--=-kL/zgwXxIui7IxYC2lj/--

