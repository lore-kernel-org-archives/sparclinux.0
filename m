From: David Miller <davem@davemloft.net>
Date: Thu, 19 Mar 2009 01:48:19 +0000
Subject: Re: question on sparc64 switch_to macro
Message-Id: <20090318.184819.116970122.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903141853.n2EIrqn13598@elf.torek.net>
In-Reply-To: <200903141853.n2EIrqn13598@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Sat, 14 Mar 2009 17:32:39 -0600

> +/* Macros below and sparc64GetNpc() code is mainly borrowed 
> + * from gdb::sparc-tdep.c and gdb::sparc64-linux-tdep.c 
> + */
> +
> +#define X_OP(i)		(((i) >> 30) & 0x3)
> +#define X_RD(i)		(((i) >> 25) & 0x1f)
> +#define X_A(i)			(((i) >> 29) & 1)
> +#define X_COND(i)		(((i) >> 25) & 0xf)
> +#define X_OP2(i)		(((i) >> 22) & 0x7)
> +#define X_IMM22(i)	((i) & 0x3fffff)
> +#define X_OP3(i)		(((i) >> 19) & 0x3f)
> +#define X_RS1(i)		(((i) >> 14) & 0x1f)
> +#define X_RS2(i)		((i) & 0x1f)
> +#define X_I(i)			(((i) >> 13) & 1)
> +
> +/* Sign extension macros.  */
> +#define X_DISP22(i)		((X_IMM22 (i) ^ 0x200000) - 0x200000)
> +#define X_DISP19(i)		((((i) & 0x7ffff) ^ 0x40000) - 0x40000)
> +#define X_SIMM13(i)		((((i) & 0x1fff) ^ 0x1000) - 0x1000)
> +
> +
> +static unsigned long sparc64GetNpc(unsigned long pc, unsigned long *npc, const struct pt_regs *regs)

arch/sparc/kernel/kprobes.c has this same code, I think it would
be wise to put that into a common place and use it instead of adding
yet another copy of the same logic.

Otherwise, looks mostly fine.

