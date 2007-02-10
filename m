From: Daniel Smolik <marvin@mydatex.cz>
Date: Sat, 10 Feb 2007 21:40:53 +0000
Subject: compile kernel for SS5 on E450
Message-Id: <45CE3BE5.7090208@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I get 2pcs. E450 and 2 pcs SS5. With some small problem I install Sarge 
via netowork on this machines. But I would like to compile kernel for 
SS5 on E450 (faster machine).

I do
sparc32 bash
  make menuconfig; make

  but on the end I get this:

WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_analog from 
                                                             .text 
between 'bw2_do_default_mode' (at offset 0x1112a8) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_analog from 
                                                             .text 
between 'bw2_do_default_mode' (at offset 0x1112c0) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_76hz from . 
                                                            text between 
'bw2_do_default_mode' (at offset 0x111324) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_76hz from . 
                                                            text between 
'bw2_do_default_mode' (at offset 0x111334) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_66hz from . 
                                                            text between 
'bw2_do_default_mode' (at offset 0x111338) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_66hz from . 
                                                            text between 
'bw2_do_default_mode' (at offset 0x111340) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_ecl 
from .t 
                                     ext between 'bw2_do_default_mode' 
(at offset 0x111348) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_ecl 
from .t 
                                     ext between 'bw2_do_default_mode' 
(at offset 0x111350) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_1600 from . 
                                                            text between 
'bw2_do_default_mode' (at offset 0x11136c) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:bw2regs_1600 from . 
                                                            text between 
'bw2_do_default_mode' (at offset 0x111374) and 'bw2_init_one'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:__cg14_mmap_map fro 
                                                            m .text 
between 'cg14_init_one' (at offset 0x111a78) and 'cg14_probe'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:__cg14_mmap_map fro 
                                                            m .text 
between 'cg14_init_one' (at offset 0x111a80) and 'cg14_probe'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:sunzilog_init_kbdms 
                                                             from .text 
between 'sunzilog_init_hw' (at offset 0x130848) and 'zs_probe'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:sunzilog_register_s 
                                                            erio from 
.text between 'sunzilog_init_hw' (at offset 0x130884) and 'zs_probe'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:detect_one_esp from 
                                                             .text 
between 'esp_sbus_probe' (at offset 0x146f28) and 'esp_sbus_remove'
WARNING: drivers/net/sunbmac.o - Section mismatch: reference to 
.init.text: from 
                                               .text between 
'bigmac_sbus_probe' (at offset 0x18c0) and 'bigmac_sbus_remove'
WARNING: drivers/net/sunqe.o - Section mismatch: reference to 
.init.text:qec_eth 
                                                er_init from .text 
between 'qec_sbus_probe' (at offset 0x1004) and 'qec_sbus_rem 
 
                    ove'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to 
.init.text:qp 
                                           ti_map_regs from .text 
between 'qpti_sbus_probe' (at offset 0x1b94) and 'qpti_sb 
 
                us_remove'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to 
.init.text:qp 
                                           ti_register_irq from .text 
between 'qpti_sbus_probe' (at offset 0x1ba8) and 'qpt 
 
            i_sbus_remove'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to 
.init.text:qp 
                                           ti_get_scsi_id from .text 
between 'qpti_sbus_probe' (at offset 0x1bbc) and 'qpti 
 
             _sbus_remove'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to 
.init.text:qp 
                                           ti_map_queues from .text 
between 'qpti_sbus_probe' (at offset 0x1be0) and 'qpti_ 
 
              sbus_remove'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to 
.init.text: f 
                                           rom .text between 
'qpti_sbus_probe' (at offset 0x1d14) and 'qpti_sbus_remove'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to 
.init.text:qp 
                                           ti_chain_del from .text after 
'qpti_sbus_remove' (at offset 0x1dd4)
WARNING: "iounmap" [drivers/rtc/rtc-v3020.ko] undefined!
WARNING: "ioremap" [drivers/rtc/rtc-v3020.ko] undefined!
WARNING: "iounmap" [drivers/rtc/rtc-ds1742.ko] undefined!
WARNING: "ioremap" [drivers/rtc/rtc-ds1742.ko] undefined!
WARNING: "iounmap" [drivers/rtc/rtc-ds1553.ko] undefined!
WARNING: "ioremap" [drivers/rtc/rtc-ds1553.ko] undefined!
WARNING: "iounmap" [drivers/parport/parport_ax88796.ko] undefined!
WARNING: "ioremap" [drivers/parport/parport_ax88796.ko] undefined!
WARNING: "__strnlen_user" [drivers/input/misc/uinput.ko] undefined!
WARNING: "insw" [drivers/ide/ide-core.ko] undefined!
WARNING: "outsl" [drivers/ide/ide-core.ko] undefined!
WARNING: "outsw" [drivers/ide/ide-core.ko] undefined!
WARNING: "insl" [drivers/ide/ide-core.ko] undefined!
WARNING: "floppy_hardint" [drivers/block/floppy.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2


Is it my fault or do I some wrong ?

		Thanks
				Dan


