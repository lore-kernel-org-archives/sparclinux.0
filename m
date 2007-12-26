From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Wed, 26 Dec 2007 12:29:07 +0000
Subject: Re: 2.6.24-rc6-mm1: some section mismatches on sparc64
Message-Id: <200712261329.08313.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20071222233056.d652743e.akpm@linux-foundation.org>
In-Reply-To: <20071222233056.d652743e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hello,

WARNING: vmlinux.o(.text+0x46b04): Section mismatch: reference to .init.text:sun4v_ktsb_register (between 'smp_callin' and 'smp_fill_in_sib_core_maps')
WARNING: vmlinux.o(.text+0x4756c): Section mismatch: reference to .init.text:sun4v_register_mondo_queues (between 'after_lock_tlb' and 'hv_cpu_startup')
WARNING: vmlinux.o(.text+0x477ac): Section mismatch: reference to .init.text:sun4v_register_mondo_queues (between 'hv_cpu_startup' and 'sys32_exit')
WARNING: vmlinux.o(.text+0x55258): Section mismatch: reference to .init.text:__alloc_bootmem (between 'kernel_map_range' and 'kernel_map_pages')
WARNING: vmlinux.o(.text+0x55278): Section mismatch: reference to .init.text:__alloc_bootmem (between 'kernel_map_range' and 'kernel_map_pages')
WARNING: vmlinux.o(.text+0x1fdfe4): Section mismatch: reference to .init.text:sunserial_console_match (between 'hv_probe' and 'serial_in')
WARNING: vmlinux.o(.text+0x20011c): Section mismatch: reference to .init.text:sunserial_console_match (between 'su_probe' and 'sunsu_console_putchar')
WARNING: vmlinux.o(.sun4v_2insn_patch+0x3d8): Section mismatch: reference to .init.text:
WARNING: vmlinux.o(__ksymtab+0x62c0): Section mismatch: reference to .init.text:sunserial_console_match (between '__ksymtab_sunserial_console_match' and '__ksymtab_sunserial_unregister_minors')

Regards,

	Mariusz
