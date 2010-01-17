From: Jacek Brzozowski <jacekbrzozowski.pld@gmail.com>
Date: Sun, 17 Jan 2010 17:39:00 +0000
Subject: SunFire T2000 Kernel panic - not syncing: Attempted to kill the idle task
Message-Id: <B2CCD575-7173-44E7-BF9F-06D8E805F241@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello
I have problem with boot debian on SunFire T2000.

boot from cd gives me (I tried few copies of CD's):

Boot device: cdrom  File and args: 
Can't read disk label.
Can't open disk label package
Evaluating: 

Can't open boot device

So I tried to boot from net, and then i get:

{0} ok boot net:dhcp
Boot device: /pci@780/pci@0/pci@1/network@0:dhcp  File and args: 
1000 Mbps full duplex  Link up
Timed out waiting for BOOTP/DHCP reply
\
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.20.4 2006/05/12 14:13'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-19) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Thu Aug 20 15:21:01 UTC 2009
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4V
[    0.000000] Ethernet address: 00:14:4f:3c:70:cc
[    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /virtual-devices@100/console@1
[    0.000000] PROM: Built device tree with 95165 bytes of memory.
[    0.000000] MDESC: Size is 32256 bytes.
[    0.000000] PLATFORM: banner-name [Sun Fire T200]
[    0.000000] PLATFORM: name [SUNW,Sun-Fire-T200]
[    0.000000] PLATFORM: hostid [843c70cc]
[    0.000000] PLATFORM: serial# [00ab4130]
[    0.000000] Unable to handle kernel NULL pointer dereference
[    0.000000] tsk->{mm,active_mm}->context = 0000000000000000
[    0.000000] tsk->{mm,active_mm}->pgd = fffff80000fb2104
[    0.000000]               \|/ ____ \|/
[    0.000000]               "@'/ .. \`@"
[    0.000000]               /_| \__/ |_\
[    0.000000]                  \__U_/
[    0.000000] swapper(0): Oops [#1]
[    0.000000] TSTATE: 0000009980f01604 TPC: 000000000078c2b0 TNPC: 000000000078c2b4 Y: 00000000    Not tainted
[    0.000000] TPC: <sun4v_mdesc_init+0x1b8/0x298>
[    0.000000] g0: fffffffff0000000 g1: 0000000000000045 g2: fffffffffffffff1 g3: 0000000065000000
[    0.000000] g4: 00000000007403c0 g5: 0000000000000000 g6: 000000000073c3c0 g7: 0000000000000438
[    0.000000] o0: 0000000000000000 o1: fffff801fff32930 o2: 00000000006ead10 o3: 0000000000000000
[    0.000000] o4: 0000000000740060 o5: 0000000000000001 sp: 000000000073f7b1 ret_pc: 000000000078c2a8
[    0.000000] RPC: <sun4v_mdesc_init+0x1b0/0x298>
[    0.000000] l0: 0000000000000687 l1: fffff801fff2c000 l2: 0000000000000001 l3: ffffffffffffffff
[    0.000000] l4: 000000000fffffff l5: 00000000007b4400 l6: fffffffff0000000 l7: 0000000000c00000
[    0.000000] i0: 0000000000004000 i1: 00000000007b4508 i2: 0000000200000000 i3: 00000000007a5220
[    0.000000] i4: 0000000010000000 i5: 0000000000000000 i6: 000000000073f881 i7: 000000000078fa2c
[    0.000000] I7: <paging_init+0x99c/0xd58>
[    0.000000] Caller[000000000078fa2c]: paging_init+0x99c/0xd58
[    0.000000] Caller[0000000000788b7c]: setup_arch+0x3bc/0x3c4
[    0.000000] Caller[00000000007826d0]: start_kernel+0x7c/0x324
[    0.000000] Caller[000000000067d120]: auxio_probe+0x0/0xd0
[    0.000000] Caller[0000000000000000]: 0x8
[    0.000000] Instruction DUMP: 92100010  7ff2b4b7  90100011 <d25a0000> 11001bb1  7ff32e9b  901221f8  92100010  15001bb1 
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] Press Stop-A (L1-A) to return to the boot prom


any idea? what I can do now?