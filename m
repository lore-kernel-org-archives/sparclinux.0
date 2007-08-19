From: jim watson <jim@amarooas.com.au>
Date: Sun, 19 Aug 2007 07:48:21 +0000
Subject: firewire oops
Message-Id: <46C7F5C5.9070500@amarooas.com.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I got a Lacie 320g firewire drive for my Sun Blade 100. This got errors 
after running for a while on debian/unstable so I ran it for a couple of 
weeks on an IMac and saw no errors. Now I have built 2.6.23rc3 with the 
new drivers/firewire modules firewire-core, firewire-ohci and firewire-sbp2.

firewire-core loads ok but firewire-ohci gets the oops below. I tried 
some traces that suggest the oops actually happens at  
dma_sync_single_for_device but don't know if that is reliable.

A kernel with these modules included will not boot, as it cannot find 
/dev/hda2 after the oops.

The modules code is in drivers/firewire and .config has:
#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m

jim@sun:~$ uname -a
Linux sun 2.6.23-rc3 #1 Sun Aug 19 11:40:55 EST 2007 sparc64 GNU/Linux


OOPS: Bogus kernel PC [0000000000000000] in fault handler
OOPS: RPC [00000000101c2b78]
RPC: <ar_context_add_page+0xe4/0x148 [firewire_ohci]>
OOPS: Fault was to vaddr[fffff8000b696000]
Call Trace:
 [00000000004076f4] sparc64_realfault_common+0x18/0x20
 [00000000101c2b78] ar_context_add_page+0xe4/0x148 [firewire_ohci]
 [00000000101c2c14] ar_context_init+0x38/0x58 [firewire_ohci]
 [00000000101c4874] pci_probe+0x11c/0x330 [firewire_ohci]
 [0000000000542140] pci_device_probe+0x5c/0x8c
 [000000000059f638] driver_probe_device+0xf4/0x190
 [000000000059f718] __driver_attach+0x44/0x68
 [000000000059eb2c] bus_for_each_dev+0x38/0x6c
 [000000000059ee9c] bus_add_driver+0x70/0x1ac
 [00000000005422a8] __pci_register_driver+0x44/0x88
 [0000000000475b1c] sys_init_module+0x1310/0x143c
 [0000000000406094] linux_sparc_syscall32+0x3c/0x40
 [0000000000011090] 0x11098
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000000000ef
tsk->{mm,active_mm}->pgd = fffff80004158000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
insmod(5924): Oops [#1]
TSTATE: 0000001911009605 TPC: 0000000000000000 TNPC: 0000000000000004 Y: 
00000000    Not tainted
TPC: <0x8>
g0: 0000000000000000 g1: 0000000000000000 g2: 00000000ffffe81f g3: 
0000000000400000
g4: fffff80003a2f280 g5: 0000000000000038 g6: fffff8000cad0000 g7: 
00cc0240184002cc
o0: fffff8000ef97070 o1: 00000000cc024000 o2: 0000000000002000 o3: 
0000000000000000
o4: 0000000000000004 o5: 000001ff00420000 sp: fffff8000cad2e71 ret_pc: 
00000000101c2b78
RPC: <ar_context_add_page+0xe4/0x148 [firewire_ohci]>
l0: fffff8000ba82000 l1: 00000000cc024000 l2: fffff80001c5cd90 l3: 
fffff8000ef97070
l4: 0000000000ff0000 l5: 0000000000704c00 l6: 0000000000782268 l7: 
00000000f7f6e000
i0: 000000000000ff00 i1: 00000000101c39d0 i2: fffff80001c5cd90 i3: 
0000000000000000
i4: 0000000000000040 i5: 0000000000000000 i6: fffff8000cad2f31 i7: 
00000000101c2c14
I7: <ar_context_init+0x38/0x58 [firewire_ohci]>
Caller[00000000101c2c14]: ar_context_init+0x38/0x58 [firewire_ohci]
Caller[00000000101c4874]: pci_probe+0x11c/0x330 [firewire_ohci]
Caller[0000000000542140]: pci_device_probe+0x5c/0x8c
Caller[000000000059f638]: driver_probe_device+0xf4/0x190
Caller[000000000059f718]: __driver_attach+0x44/0x68
Caller[000000000059eb2c]: bus_for_each_dev+0x38/0x6c
Caller[000000000059ee9c]: bus_add_driver+0x70/0x1ac
Caller[00000000005422a8]: __pci_register_driver+0x44/0x88
Caller[0000000000475b1c]: sys_init_module+0x1310/0x143c
Caller[0000000000406094]: linux_sparc_syscall32+0x3c/0x40
Caller[0000000000011090]: 0x11098
Instruction DUMP: 00000000  00000000  00000000 <1>Unable to handle 
kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000000000ef
tsk->{mm,active_mm}->pgd = fffff80004158000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
insmod(5924): Oops [#2]
TSTATE: 0000004480009601 TPC: 0000000000428bb8 TNPC: 0000000000428bbc Y: 
00000000    Tainted: G      D
TPC: <instruction_dump+0x68/0x88>
g0: 78745f6164645f70 g1: 0000000000000000 g2: 0000000000705c00 g3: 
0000000000705fa0
g4: fffff80003a2f280 g5: 0000000000000038 g6: fffff8000cad0000 g7: 
0000000000000000
o0: 00000000006b1400 o1: 0000000000000020 o2: 0000000000000000 o3: 
0000000000000020
o4: 00000000101c2c14 o5: 0000000000772220 sp: fffff8000cad2aa1 ret_pc: 
0000000000428b98
RPC: <instruction_dump+0x48/0x88>
l0: 0000000000000000 l1: fffff8000cad3670 l2: 0000000000000000 l3: 
0000001911009605
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 
0000000000000001
i0: 0000000000000000 i1: 0000000000011098 i2: fffff8000cad35d0 i3: 
0000000000000000
i4: 00000000000000ff i5: 000000000000000b i6: fffff8000cad2b61 i7: 
0000000000429470
I7: <die_if_kernel+0x110/0x26c>
Caller[0000000000429470]: die_if_kernel+0x110/0x26c
Caller[000000000044b068]: unhandled_fault+0x94/0x98
Caller[00000000004076f4]: sparc64_realfault_common+0x18/0x20
Caller[00000000101c2b78]: ar_context_add_page+0xe4/0x148 [firewire_ohci]
Caller[00000000101c2c14]: ar_context_init+0x38/0x58 [firewire_ohci]
Caller[00000000101c4874]: pci_probe+0x11c/0x330 [firewire_ohci]
Caller[0000000000542140]: pci_device_probe+0x5c/0x8c
Caller[000000000059f638]: driver_probe_device+0xf4/0x190
Caller[000000000059f718]: __driver_attach+0x44/0x68
Caller[000000000059eb2c]: bus_for_each_dev+0x38/0x6c
Caller[000000000059ee9c]: bus_add_driver+0x70/0x1ac
Caller[00000000005422a8]: __pci_register_driver+0x44/0x88
Caller[0000000000475b1c]: sys_init_module+0x1310/0x143c
Caller[0000000000406094]: linux_sparc_syscall32+0x3c/0x40
Caller[0000000000011090]: 0x11098
Instruction DUMP: 31001b23  4000c1ad  91ee2378 <d4060000> 9210203c  
9610203e  901220b0  4000c1a7  a0102001


