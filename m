From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 03 Aug 2009 05:54:41 +0000
Subject: Re: [PATCH v2 0/8] sparc: use asm-generic/dma-mapping-common.h and
Message-Id: <20090803055441.GA19428@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090714092354.GL19087@amd.com> <20090714.131224.205307048.davem@davemloft.net> <20090718110620.GC27287@elte.hu> <20090802.202135.63875488.davem@davemloft.net>
In-Reply-To: <20090802.202135.63875488.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: a.p.zijlstra@chello.nl, joerg.roedel@amd.com, fujita.tomonori@lab.ntt.co.jp, reif@earthlink.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org


* David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Sat, 18 Jul 2009 13:06:20 +0200
> 
> > I'm wondering why sparc32 frees from the middle of the kernel 
> > image. The way architectures generally do it is to put freeable 
> > pages into a separate section. That way it does not get mingled 
> > with the kernel core image area (which stays nicely continuous).
> 
> It's conditionally free'able, we actually use the pages if the 
> system is SMP and has more than cpu 0 installed.

Sounds similar to the alternate instructions section on x86:

 arch/x86/kernel/alternative.c:

        if (smp_alt_once)
                free_init_pages("SMP alternatives",
                                (unsigned long)__smp_locks,
                                (unsigned long)__smp_locks_end);

It's in a separate section and linked + freed separately. The linker 
script page-aligns it:

 arch/x86/kernel/vmlinux.lds.S:

        /*
         * smp_locks might be freed after init
         * start/end must be page aligned
         */
        . = ALIGN(PAGE_SIZE);
        .smp_locks : AT(ADDR(.smp_locks) - LOAD_OFFSET) {
                __smp_locks = .;
                *(.smp_locks)
                __smp_locks_end = .;
                . = ALIGN(PAGE_SIZE);
        }

So that it can be freed. It's also placed next to the regular init 
section to not create too many holes. It also keeps the 'kernel text 
area' continuous and things like core_kernel_text() & co still work 
fine.

	Ingo
