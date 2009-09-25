From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 Sep 2009 21:15:38 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925141538.aaf00a21.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 25 Sep 2009 14:07:21 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: akpm@linux-foundation.org
> Date: Fri, 18 Sep 2009 12:59:03 -0700
> 
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> I had this in my tree but it breaks the build, so please toss
> this from your queue.  Thanks.
> 
> In file included from include/asm-generic/hardirq.h:6,
>                  from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/hardirq_32.h:11,
>                  from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/hardirq.h:6,
>                  from include/linux/hardirq.h:10,
>                  from include/linux/interrupt.h:12,
>                  from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/irq_32.h:9,
>                  from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/irq.h:6,
>                  from include/linux/irqnr.h:10,
>                  from include/linux/random.h:12,
>                  from include/linux/stackprotector.h:6,
>                  from init/main.c:17:
> include/linux/irq.h:216: error: ___NR_IRQS___ undeclared here (not in a function)

hm, I tried to fix this but my sparc32 cross-compiler broke.

ARCH=sparc:

scripts/mod/empty.c:1: error: -m64 is not supported by this configuration
scripts/mod/empty.c:1: error: -mlong-double-64 not allowed with -m64
scripts/mod/empty.c:1: error: -mcmodel= is not supported on 32 bit systems

  /opt/crosstool/gcc-4.1.0-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-unknown-linux-gnu-gcc -Wp,-MD,scripts/mod/.empty.o.d  -nostdinc -isystem /opt/crosstool/gcc-4.1.0-glibc-2.3.6/sparc-unknown-linux-gnu/lib/gcc/sparc-unknown-linux-gnu/4.1.0/include -Iinclude  -I/usr/src/devel/arch/sparc/include -include include/linux/autoconf.h -D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs -pg -fno-omit-frame-pointer -fno-optimize-sibling-calls -pg    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(empty)"  -D"KBUILD_MODNAME=KBUILD_STR(empty)" -D"DEBUG_HASHC" -D"DEBUG_HASH2P" -c -o scripts/mod/.tmp_empty.o scripts/mod/empty.c

How'd that -m64 get in there?

I haven't tested sparc32 in some time so perhaps I've forgotten the magic sauce.
