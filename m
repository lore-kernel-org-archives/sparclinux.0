From: Daniel Smolik <marvin@mydatex.cz>
Date: Thu, 31 Jan 2008 20:03:03 +0000
Subject: section mismatch 2.6.24
Message-Id: <47A22977.5020302@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
I today start compile 2.6.24 and get this warnning:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x3ffac): Section mismatch: reference to 
.init.text:sun4v_ktsb_register (between 'smp_callin' and 
'smp_fill_in_sib_core_maps')
WARNING: vmlinux.o(.text+0x4092c): Section mismatch: reference to 
.init.text:sun4v_register_mondo_queues (between 'after_lock_tlb' and 
'hv_cpu_startup')
WARNING: vmlinux.o(.text+0x40b6c): Section mismatch: reference to 
.init.text:sun4v_register_mondo_queues (between 'hv_cpu_startup' and 
'hv_cpu_startup_end')
WARNING: vmlinux.o(.sun4v_2insn_patch+0x3d8): Section mismatch: 
reference to .init.text:

Have anybody solution ?

			Dan




