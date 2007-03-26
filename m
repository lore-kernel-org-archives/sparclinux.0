From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Mon, 26 Mar 2007 14:47:31 +0000
Subject: More sparc32 esp failures
Message-Id: <1174920451.6493.40.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This one doesn't even have a CDROM.
SPARCstation 4, No Keyboard
ROM Rev. 2.24, 160 MB memory installed

sd 0:0:3:0: Attached scsi disk sda
esp0: Aborting command
esp0: dumping state
esp0: dma -- cond_reg<a6400310> addr<f00106c1>
esp0: SW [sreg<11> sstep<04> ireg<18>]
esp0: HW reread [sreg<01> sstep<c4> ireg<00>]
esp0: current command [tgt<03> lun<01> pphase<CLUELESS> cphase<DATAIN>]
esp0: disconnected
esp0: Aborting command
esp0: dumping state
esp0: dma -- cond_reg<a6400310> addr<f00106c1>
esp0: SW [sreg<11> sstep<04> ireg<18>]
esp0: HW reread [sreg<01> sstep<c4> ireg<00>]
esp0: current command [tgt<03> lun<01> pphase<UNISSUED>
cphase<UNISSUED>]
esp0: disconnected
esp0: Resetting scsi bus
esp0: Gross error sreg@
esp0: SCSI bus reset interrupt
esp0: DMA error a440030e
esp0: Resetting scsi bus
esp0: SCSI bus reset interrupt
kernel BUG at arch/sparc/mm/iommu.c:298!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Kernel bad trap [#1]
PSR: 04401fc3 PC: f001f2d0 NPC: f001f2d4 Y: 00000000    Not tainted
PC: <iommu_release_one+0x30/0x74>
%G: f00dbf5c 044010e2  00000001 04401fe1  f002fe54 f0239948  f000e000
00000000
%O: 0000002c f01d1b00  0000012a f000fbac  f00dbf5c 00000000  f000fa28
f001f2c8
RPC: <iommu_release_one+0x28/0x74>
%L: 04401fc4 f00307b0  f00307dc 00000040  00000080 00000000  f000e000
f00110ec
%I: 21212000 00000001  00000001 f023d800  f0239800 f0239800  f000fa90
f001f340
Caller[f001f340]: iommu_release_scsi_sgl+0x2c/0x54
Caller[fe683388]: esp_finish_reset+0x20/0xb4 [esp]
Caller[fe68588c]: esp_intr+0x2dc/0x328 [esp]
Caller[f0012d54]: handler_irq+0x90/0xdc
Caller[f0010830]: patch_handler_irq+0x8/0x24
Caller[f0035038]: __do_softirq+0x28/0xc0
Caller[f0035110]: do_softirq+0x40/0x50
Caller[f0012d90]: handler_irq+0xcc/0xdc
Caller[f0010830]: patch_handler_irq+0x8/0x24
Caller[f00146f8]: cpu_idle+0xc0/0xfc
Caller[f02101e4]: _etext+0x6cda4/0x6dbb8
Caller[f020f790]: _etext+0x6c350/0x6dbb8
Caller[00000000]: 0x8
Instruction DUMP: 9210212a  7fffcc20  90122300 <91d02005> 82260001
8a102000  b330600c  10800009  872e6002
Kernel panic - not syncing: Aiee, killing interrupt handler!
Press Stop-A (L1-A) to return to the boot prom
BUG: warning at kernel/panic.c:137/panic() (Not tainted)
[f001250c : die_if_kernel+0x118/0x11c ] [f0012610 : do_hw_interrupt
+0x50/0x8c ] [f00107ec : bad_trap_handler+0x28/0x30 ] [f001f2c8 :
iommu_release_one+0x28/0x74 ] [f001f340 : iommu_release_scsi_sgl
+0x2c/0x54 ] [fe683388 : esp_finish_reset+0x20/0xb4 [esp] ] [fe68588c :
esp_intr+0x2dc/0x328 [esp] ] [f0012d54 : handler_irq+0x90/0xdc ]
[f0010830 : patch_handler_irq+0x8/0x24 ] [f0035038 : __do_softirq
+0x28/0xc0 ] [f0035110 : do_softirq+0x40/0x50 ] [f0012d90 : handler_irq
+0xcc/0xdc ] [f0010830 : patch_handler_irq+0x8/0x24 ] [f00146f8 :
cpu_idle+0xc0/0xfc ] [f02101e4 : _etext+0x6cda4/0x6dbb8 ] [f020f790 :
_etext+0x6c350/0x6dbb8 ]

This is only triggered when CONFIG_SCSI_MULTI_LUN=y.


