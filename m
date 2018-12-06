From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 06 Dec 2018 14:09:02 +0000
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Message-Id: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
In-Reply-To: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Rich Felker <dalias@libc.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-mips@vger.kernel.org, Borislav Petkov <bp@alien8.de>, nios2-dev@lists.rocketboards.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>, Randy Dunlap <rdunlap@infradead.org>, Douglas Anderson <dianders@chromium.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, Ley Foon Tan <lftan@altera.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
> MIPS is the only architecture modifying arch_kgdb_ops during init.
> This patch makes the init static, so that it can be changed to
> const in following patch, as recommended by checkpatch.pl
> 
> Suggested-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

From my side this is
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Since this is a dependency for the next patch I'd be happy to take via
my tree... but would need an ack from the MIPS guys to do that.


Daniel.

> ---
>  arch/mips/kernel/kgdb.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index eb6c0d582626..31eff1bec577 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  	return -1;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops;
> +struct kgdb_arch arch_kgdb_ops = {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
> +#else
> +	.gdb_bpt_instr = { break_op, 0x00, 0x00, spec_op << 2 },
> +#endif
> +};
>  
>  int kgdb_arch_init(void)
>  {
> -	union mips_instruction insn = {
> -		.r_format = {
> -			.opcode = spec_op,
> -			.func	= break_op,
> -		}
> -	};
> -	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
> -
>  	register_die_notifier(&kgdb_notifier);
>  
>  	return 0;
> -- 
> 2.13.3
> 
