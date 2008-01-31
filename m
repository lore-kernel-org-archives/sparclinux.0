From: David Miller <davem@davemloft.net>
Date: Thu, 31 Jan 2008 23:59:12 +0000
Subject: Re: section mismatch 2.6.24
Message-Id: <20080131.155912.193706750.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <47A22977.5020302@mydatex.cz>
In-Reply-To: <47A22977.5020302@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@mydatex.cz>
Date: Thu, 31 Jan 2008 21:03:03 +0100

> Hi,
> I today start compile 2.6.24 and get this warnning:
> 
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x3ffac): Section mismatch: reference to 
> .init.text:sun4v_ktsb_register (between 'smp_callin' and 
> 'smp_fill_in_sib_core_maps')
> WARNING: vmlinux.o(.text+0x4092c): Section mismatch: reference to 
> .init.text:sun4v_register_mondo_queues (between 'after_lock_tlb' and 
> 'hv_cpu_startup')
> WARNING: vmlinux.o(.text+0x40b6c): Section mismatch: reference to 
> .init.text:sun4v_register_mondo_queues (between 'hv_cpu_startup' and 
> 'hv_cpu_startup_end')
> WARNING: vmlinux.o(.sun4v_2insn_patch+0x3d8): Section mismatch: 
> reference to .init.text:
> 
> Have anybody solution ?

These warnings are harmless, please just ignore them.
