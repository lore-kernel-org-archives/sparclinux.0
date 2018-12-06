From: Borislav Petkov <bp@alien8.de>
Date: Thu, 06 Dec 2018 21:12:52 +0000
Subject: Re: [PATCH v2 2/2] kgdb/treewide: constify struct kgdb_arch arch_kgdb_ops
Message-Id: <20181206211252.GJ3986@zn.tnic>
List-Id: <sparclinux.vger.kernel.org>
References: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr>
 <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
In-Reply-To: <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Rich Felker <dalias@libc.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>, Randy Dunlap <rdunlap@infradead.org>, Douglas Anderson <dianders@chromium.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, Ley Foon Tan <lftan@altera.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Thu, Dec 06, 2018 at 08:07:40PM +0000, Christophe Leroy wrote:
> checkpatch.pl reports the following:
> 
>   WARNING: struct kgdb_arch should normally be const
>   #28: FILE: arch/mips/kernel/kgdb.c:397:
>   +struct kgdb_arch arch_kgdb_ops = {
> 
> This report makes sense, as all other ops struct, this
> one should also be const. This patch does the change.
> 
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Added CCs to all maintainers/supporters identified by get_maintainer.pl and Acks from Daniel and Paul.
> 
>  arch/arc/kernel/kgdb.c        | 2 +-
>  arch/arm/kernel/kgdb.c        | 2 +-
>  arch/arm64/kernel/kgdb.c      | 2 +-
>  arch/h8300/kernel/kgdb.c      | 2 +-
>  arch/hexagon/kernel/kgdb.c    | 2 +-
>  arch/microblaze/kernel/kgdb.c | 2 +-
>  arch/mips/kernel/kgdb.c       | 2 +-
>  arch/nios2/kernel/kgdb.c      | 2 +-
>  arch/powerpc/kernel/kgdb.c    | 2 +-
>  arch/sh/kernel/kgdb.c         | 2 +-
>  arch/sparc/kernel/kgdb_32.c   | 2 +-
>  arch/sparc/kernel/kgdb_64.c   | 2 +-
>  arch/x86/kernel/kgdb.c        | 2 +-
>  include/linux/kgdb.h          | 2 +-
>  14 files changed, 14 insertions(+), 14 deletions(-)

...

> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 8e36f249646e..e7effc02f13c 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -804,7 +804,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: */
>  	.gdb_bpt_instr		= { 0xcc },
>  	.flags			= KGDB_HW_BREAKPOINT,

For the x86 bits:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
