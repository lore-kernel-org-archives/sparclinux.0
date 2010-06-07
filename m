From: Meelis Roos <mroos@linux.ee>
Date: Mon, 07 Jun 2010 14:57:50 +0000
Subject: bootcup crash in prom tree building with specific PCI card
Message-Id: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

After successfully testing 2.6.35-rc2-00001-g386f40c on my Ultra 10, I 
decided to try some FCode ROM PCI cards in this U10. Sun SYM22801 worked 
fine, ATTO SCSI fro APPle was found and ignored by PROM and worked in 
Linux, but Orange Micro Grappler 906F gave me trouble. It was detected 
by PROM (.properties ath the bottom of the mail) but Linux crashed early 
on the boot while building prom tree. The actual crash happens in 
prom_early_alloc and I don't understand the code well there. What debug 
printk-s do I need to debug this further?


PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible: 
Linux version 2.6.35-rc1-00261-g03cd373 (mroos@u10) (gcc version 4.4.4 (Debian 4.4.4-3) ) #1 Fri Jun 4 04:44:32 EEST 2010
debug: ignoring loglevel setting.
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:9e:82:fd
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
spitfire_data_access_exception: SFSR[0000000000801009] SFAR[0000000e10a8e7d0], going.
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Dax [#1]
TSTATE: 0000000080e01604 TPC: 0000000000878328 TNPC: 0000000000878234 Y: 00000000    Not tainted
TPC: <__lmb_alloc_base+0x14c/0x164>
g0: 0000000000000000 g1: 00000000008e0c00 g2: 00000000008e0d58 g3: fffffffffffffff8
g4: 0000000000829ef0 g5: 0000000000000000 g6: 0000000000820000 g7: 0000000000000000
o0: 00000000008e0d58 o1: 00000000008e1598 o2: 0000000000000080 o3: 0000000000000000
o4: 000000001fede000 o5: 4501dc2230dcde41 sp: 0000000000822ea1 ret_pc: 2a4ee00e10a8e7c8
RPC: <0x2a4ee00e10a8e7c8>
l0: 32a4ee00e101ada5 l1: 0000000000000000 l2: 00000000f00673e8 l3: 0000000000820000
l4: 0000000000000004 l5: 0000000000000004 l6: 0000000000000000 l7: fffffffffffffff0
i0: 0000000000000050 i1: ffffffffffffffc0 i2: 0000000000000000 i3: 0000000000000000
i4: fffff8001fed6340 i5: 0000000000000000 i6: 0000000000822f51 i7: 0000000000878380
I7: <lmb_alloc_base+0xc/0x34>
Call Trace:
 [0000000000878380] lmb_alloc_base+0xc/0x34
 [000000000086c474] prom_early_alloc+0xc/0x60
 [000000000086c054] build_one_prop+0x28/0x138
 [000000000086c220] prom_create_node+0xbc/0xe8
 [000000000086c2f0] prom_build_tree+0x1c/0xac
 [000000000086c344] prom_build_tree+0x70/0xac
 [000000000086c344] prom_build_tree+0x70/0xac
 [000000000086c3d4] prom_build_devicetree+0x54/0x80
 [000000000086f7cc] paging_init+0x94c/0xd4c
 [000000000086b9fc] setup_arch+0x320/0x330
 [000000000086a544] start_kernel+0x6c/0x2ec
 [000000000071c664] tlb_fixup_done+0x80/0x9c
 [0000000000000000] (null)
Disabling lock debugging due to kernel taint
Caller[0000000000878380]: lmb_alloc_base+0xc/0x34
Caller[000000000086c474]: prom_early_alloc+0xc/0x60
Caller[000000000086c054]: build_one_prop+0x28/0x138
Caller[000000000086c220]: prom_create_node+0xbc/0xe8
Caller[000000000086c2f0]: prom_build_tree+0x1c/0xac
Caller[000000000086c344]: prom_build_tree+0x70/0xac
Caller[000000000086c344]: prom_build_tree+0x70/0xac
Caller[000000000086c3d4]: prom_build_devicetree+0x54/0x80
Caller[000000000086f7cc]: paging_init+0x94c/0xd4c
Caller[000000000086b9fc]: setup_arch+0x320/0x330
Caller[000000000086a544]: start_kernel+0x6c/0x2ec
Caller[000000000071c664]: tlb_fixup_done+0x80/0x9c
Caller[0000000000000000]: (null)
Instruction DUMP: a0043fff  9e03fff0  2efc3fc4 <c25be008> b0102000  81cfe008  01000000  106fffdb  82006010 
Kernel panic - not syncing: Attempted to kill the idle task!
Call Trace:
 [000000000045676c] do_exit+0x60c/0x6a0
 [00000000004279f4] die_if_kernel+0x194/0x340
 [000000000042885c] spitfire_data_access_exception+0xbc/0xe0
 [00000000004056c4] __spitfire_data_access_exception+0x34/0x44
 [0000000000878328] __lmb_alloc_base+0x14c/0x164
 [0000000000878380] lmb_alloc_base+0xc/0x34
 [000000000086c474] prom_early_alloc+0xc/0x60
 [000000000086c054] build_one_prop+0x28/0x138
 [000000000086c220] prom_create_node+0xbc/0xe8
 [000000000086c2f0] prom_build_tree+0x1c/0xac
 [000000000086c344] prom_build_tree+0x70/0xac
 [000000000086c344] prom_build_tree+0x70/0xac
 [000000000086c3d4] prom_build_devicetree+0x54/0x80
 [000000000086f7cc] paging_init+0x94c/0xd4c
 [000000000086b9fc] setup_arch+0x320/0x330
 [000000000086a544] start_kernel+0x6c/0x2ec
Press Stop-A (L1-A) to return to the boot prom

Sun Ultra 5/10 UPA/PCI (UltraSPARC-IIi 300MHz), No Keyboard
OpenBoot 3.31, 512 MB (60 ns) memory installed, Serial #10388221.
Ethernet address 8:0:20:9e:82:fd, Host ID: 809e82fd.



Initializing Memory

ok cd /pci/pci
ok ls
f009908c Grappler_906F@2
f00856e8 scsi@1
ok cd Grappler_906F@2
ok .properties
assigned-addresses       82021030 00000000 00020000 00000000 00008000 
                         82021014 00000000 00030000 00000000 00000100 
                         81021010 00000000 00000400 00000000 00000100 
driver,aapl,macosx,powerpc  4d 4b 58 54 4d 4f 53 58 00 00 7c bb 36 3b 7d 38 
driver,aapl,macos,powerpc  4a 6f 79 21 70 65 66 66 70 77 70 63 00 00 00 01 
power-consumption        00000000 00000000 
                         007270e0 007270e0 
                         00000000 00000000 
                         007b98a0 007b98a0 
reg                      00021000 00000000 00000000 00000000 00000000 
                         02021030 00000000 00000000 00000000 00008000 
                         02021014 00000000 00000000 00000000 00000100 
                         01021010 00000000 00000000 00000000 00000100 
model                    FAST
device_type              scsi
name                     Grappler_906F
fcode-rom-offset         00000000 
fast-back-to-back 
devsel-speed             00000001 
class-code               00010000 
interrupts               00000001 
max-latency              00000004 
More [<space>,<cr>,q,n,p,c] ?                               min-grant                00000004 
subsystem-vendor-id      000010cd 
subsystem-id             00001310 
revision-id              00000003 
device-id                00001300 
vendor-id                000010cd 
ok 
ok .version
Release 3.31 Version 0 created 2001/07/25 20:36
OBP 3.31.0 2001/07/25 20:36
POST 3.1.0 2000/06/27 13:56
ok

-- 
Meelis Roos (mroos@linux.ee)
