From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 07 Dec 2018 11:15:14 +0000
Subject: Re: [PATCH v2 2/2] kgdb/treewide: constify struct kgdb_arch arch_kgdb_ops
Message-Id: <87va45k2pp.fsf@concordia.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr>
 <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
In-Reply-To: <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>"GitAuthor: Christophe Leroy" <christophe.leroy@c-s.fr>, Douglas Anderson <dianders@chromium.org>, Randy Dunlap <rdunlap@infradead.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> checkpatch.pl reports the following:
>
>   WARNING: struct kgdb_arch should normally be const
>   #28: FILE: arch/mips/kernel/kgdb.c:397:
>   +struct kgdb_arch arch_kgdb_ops = {
>
> This report makes sense, as all other ops struct, this
> one should also be const. This patch does the change.
...

> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 59c578f865aa..bdb588b1d8fb 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -477,7 +477,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  /*
>   * Global data
>   */
> -struct kgdb_arch arch_kgdb_ops;
> +const struct kgdb_arch arch_kgdb_ops;
>  
>  static int kgdb_not_implemented(struct pt_regs *regs)
>  {

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
