From: Joe Perches <joe@perches.com>
Date: Thu, 01 Feb 2018 20:32:02 +0000
Subject: Re: [PATCH v11 03/10] sparc64: Add support for ADI register fields, ASIs and traps
Message-Id: <1517517122.7489.47.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
	 <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
In-Reply-To: <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: mhocko@suse.com, mingo@kernel.org, gregkh@linuxfoundation.org, glx@linutronix.de, kstewart@linuxfoundation.org, vijay.ac.kumar@oracle.com, kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com, tom.hromatka@oracle.com, allen.pais@oracle.com, rob.gardner@oracle.com, david.j.aldridge@oracle.com, babu.moger@oracle.com, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, vegard.nossum@oracle.com, pombredanne@nexb.com, jane.chu@oracle.com, anthony.yznaga@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On Thu, 2018-02-01 at 11:01 -0700, Khalid Aziz wrote:
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
[]
> @@ -164,6 +164,8 @@ bool kern_addr_valid(unsigned long addr);
>  #define _PAGE_E_4V	  _AC(0x0000000000000800,UL) /* side-Effect          */
>  #define _PAGE_CP_4V	  _AC(0x0000000000000400,UL) /* Cacheable in P-Cache */
>  #define _PAGE_CV_4V	  _AC(0x0000000000000200,UL) /* Cacheable in V-Cache */
> +/* Bit 9 is used to enable MCD corruption detection instead on M7 */
> +#define _PAGE_MCD_4V      _AC(0x0000000000000200,UL) /* Memory Corruption    */

trivia:

There are some whitespace alignment issues here

> diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
[]
> @@ -219,6 +219,16 @@
>  	nop;						\
>  	nop;
>  
> +#define SUN4V_MCD_PRECISE				\
> +	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
> +	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
> +	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
> +	ba,pt	%xcc, etrap;				\
> +	 rd	%pc, %g7;				\
> +	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
> +	 nop;						\
> +	nop;

and here and elsewhere.

It would be nicer to make all these use
similar indentation.

> diff --git a/arch/sparc/kernel/sun4v_mcd.S b/arch/sparc/kernel/sun4v_mcd.S
[]
> +sun4v_mcd_detect_precise:
> +	mov	%l4, %o1
> +	mov 	%l5, %o2
> +	call	sun4v_mem_corrupt_detect_precise
> +	 add	%sp, PTREGS_OFF, %o0
> +	ba,a,pt	%xcc, rtrap
> +	 nop

etc...

