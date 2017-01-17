From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jan 2017 04:23:59 +0000
Subject: Re: [PATCH v4 3/4] sparc64: Add support for ADI register fields, ASIs and traps
Message-Id: <20170116.232359.2135717859694837287.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1483999591.git.khalid.aziz@oracle.com>
        <cover.1483999591.git.khalid.aziz@oracle.com>
        <cdd798bcaff601b83855525989e30f5c5017d32f.1483999591.git.khalid.aziz@oracle.com>
In-Reply-To: <cdd798bcaff601b83855525989e30f5c5017d32f.1483999591.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, tushar.n.dave@oracle.com, akpm@linux-foundation.org, nitin.m.gupta@oracle.com, gerald.schaefer@de.ibm.com, hughd@google.com, kirill.shutemov@linux.intel.com, adam.buchbinder@gmail.com, minchan@kernel.org, allen.pais@oracle.com, viro@zeniv.linux.org.uk, aryabinin@virtuozzo.com, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, khalid@gonehiking.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 11 Jan 2017 09:12:53 -0700

> +#define SUN4V_MCD_PRECISE				\
> +	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
> +	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
> +	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
> +	ba,pt	%xcc, etrap;				\
> +	rd	%pc, %g7;				\
> +	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
> +	nop;						\
> +	nop;

Always indent instructions which sit in the delay slot of a non-annulled
branch, call, or jmpl by one extra space.  For example:

	ba,pt	%xcc, 1f
	 nop

> +sun4v_mcd_detect_precise:
> +	or	%l4, %g0, %o1
> +	or 	%l5, %g0, %o2
> +	call	sun4v_mem_corrupt_detect_precise
> +	add	%sp, PTREGS_OFF, %o0

Likewise.

Also, just do a normal "mov x, y" instead of the "or x, %g0, y" thing.
