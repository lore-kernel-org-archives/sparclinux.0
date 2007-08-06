From: Andrew Walrond <andrew@walrond.org>
Date: Mon, 06 Aug 2007 10:26:14 +0000
Subject: Re: Sparc-2.6.24 GIT tree
Message-Id: <46B6F746.9000705@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070805.180930.21926239.davem@davemloft.net>
In-Reply-To: <20070805.180930.21926239.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> 
> I use arch/sparc64/defconfig, enable CONFIG_FUSION* and CONFIG_SMP,
> works fine on all my Niagara boxes.

Do these warnings matter?

 v2.6.22.1 $ make image
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  MODPOST vmlinux
WARNING: arch/sparc64/kernel/built-in.o(.text+0x1bdf0): Section
mismatch: reference to .init.text:sun4v_init_mondo_queues (between
'after_lock_tlb' and 'sparc64_cpu_startup_end')
WARNING: arch/sparc64/kernel/built-in.o(.text+0x1beac): Section
mismatch: reference to .init.text:smp_callin (between 'after_lock_tlb'
and 'sparc64_cpu_startup_end')
  STRIP   arch/sparc64/boot/image
  kernel: arch/sparc64/boot/image is ready


