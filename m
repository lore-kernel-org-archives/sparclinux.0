From: Meelis Roos <mroos@ut.ee>
Date: Fri, 02 May 2014 04:51:13 +0000
Subject: Re: [PATCH 07/10] sparc64: Fix top-level fault handling bugs.
Message-Id: <alpine.SOC.1.00.1405020747150.25063@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175538.1736831666738622015.davem@davemloft.net>
In-Reply-To: <20140430.175538.1736831666738622015.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> Make get_user_insn() able to cope with huge PMDs.
>=20
> Next, make do_fault_siginfo() more robust when get_user_insn() can't
> actually fetch the instruction.  In particular, use the MMU announced
> fault address when that happens, instead of calling
> compute_effective_address() and computing garbage.
>=20
> Signed-off-by: David S. Miller <davem@davemloft.net>

This patch happens to introduce a compile failure on a computer that has=20
THP diabled:

  CC      arch/sparc/mm/fault_64.o
arch/sparc/mm/fault_64.c: In function =A1get_user_insn=A2:
arch/sparc/mm/fault_64.c:117:3: error: implicit declaration of function =A1=
pmd_pfn=A2 [-Werror=3Dimplicit-function-declaration]

arch/sparc/include/asm/pgtable_64.h has pmd_pfn declared only for THP.

> ---
>  arch/sparc/mm/fault_64.c | 75 ++++++++++++++++++++++++++++++------------=
------
>  1 file changed, 47 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
> index 69bb818..cf0d05d 100644
> --- a/arch/sparc/mm/fault_64.c
> +++ b/arch/sparc/mm/fault_64.c
> @@ -96,38 +96,48 @@ static unsigned int get_user_insn(unsigned long tpc)
>  	pte_t *ptep, pte;
>  	unsigned long pa;
>  	u32 insn =3D 0;
> -	unsigned long pstate;
> =20
>  	if (pgd_none(*pgdp))
> -		goto outret;
> +		goto out;
>  	pudp =3D pud_offset(pgdp, tpc);
>  	if (pud_none(*pudp))
> -		goto outret;
> -	pmdp =3D pmd_offset(pudp, tpc);
> -	if (pmd_none(*pmdp))
> -		goto outret;
> +		goto out;
> =20
>  	/* This disables preemption for us as well. */
> -	__asm__ __volatile__("rdpr %%pstate, %0" : "=3Dr" (pstate));
> -	__asm__ __volatile__("wrpr %0, %1, %%pstate"
> -				: : "r" (pstate), "i" (PSTATE_IE));
> -	ptep =3D pte_offset_map(pmdp, tpc);
> -	pte =3D *ptep;
> -	if (!pte_present(pte))
> -		goto out;
> +	local_irq_disable();
> +
> +	pmdp =3D pmd_offset(pudp, tpc);
> +	if (pmd_none(*pmdp))
> +		goto out_irq_enable;
> =20
> -	pa  =3D (pte_pfn(pte) << PAGE_SHIFT);
> -	pa +=3D (tpc & ~PAGE_MASK);
> +	if (pmd_trans_huge(*pmdp)) {
> +		if (pmd_trans_splitting(*pmdp))
> +			goto out_irq_enable;
> =20
> -	/* Use phys bypass so we don't pollute dtlb/dcache. */
> -	__asm__ __volatile__("lduwa [%1] %2, %0"
> -			     : "=3Dr" (insn)
> -			     : "r" (pa), "i" (ASI_PHYS_USE_EC));
> +		pa  =3D pmd_pfn(*pmdp) << PAGE_SHIFT;
> +		pa +=3D tpc & ~HPAGE_MASK;
> =20
> +		/* Use phys bypass so we don't pollute dtlb/dcache. */
> +		__asm__ __volatile__("lduwa [%1] %2, %0"
> +				     : "=3Dr" (insn)
> +				     : "r" (pa), "i" (ASI_PHYS_USE_EC));
> +	} else {
> +		ptep =3D pte_offset_map(pmdp, tpc);
> +		pte =3D *ptep;
> +		if (pte_present(pte)) {
> +			pa  =3D (pte_pfn(pte) << PAGE_SHIFT);
> +			pa +=3D (tpc & ~PAGE_MASK);
> +
> +			/* Use phys bypass so we don't pollute dtlb/dcache. */
> +			__asm__ __volatile__("lduwa [%1] %2, %0"
> +					     : "=3Dr" (insn)
> +					     : "r" (pa), "i" (ASI_PHYS_USE_EC));
> +		}
> +		pte_unmap(ptep);
> +	}
> +out_irq_enable:
> +	local_irq_enable();
>  out:
> -	pte_unmap(ptep);
> -	__asm__ __volatile__("wrpr %0, 0x0, %%pstate" : : "r" (pstate));
> -outret:
>  	return insn;
>  }
> =20
> @@ -153,7 +163,8 @@ show_signal_msg(struct pt_regs *regs, int sig, int co=
de,
>  }
> =20
>  static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
> -			     unsigned int insn, int fault_code)
> +			     unsigned long fault_addr, unsigned int insn,
> +			     int fault_code)
>  {
>  	unsigned long addr;
>  	siginfo_t info;
> @@ -161,10 +172,18 @@ static void do_fault_siginfo(int code, int sig, str=
uct pt_regs *regs,
>  	info.si_code =3D code;
>  	info.si_signo =3D sig;
>  	info.si_errno =3D 0;
> -	if (fault_code & FAULT_CODE_ITLB)
> +	if (fault_code & FAULT_CODE_ITLB) {
>  		addr =3D regs->tpc;
> -	else
> -		addr =3D compute_effective_address(regs, insn, 0);
> +	} else {
> +		/* If we were able to probe the faulting instruction, use it
> +		 * to compute a precise fault address.  Otherwise use the fault
> +		 * time provided address which may only have page granularity.
> +		 */
> +		if (insn)
> +			addr =3D compute_effective_address(regs, insn, 0);
> +		else
> +			addr =3D fault_addr;
> +	}
>  	info.si_addr =3D (void __user *) addr;
>  	info.si_trapno =3D 0;
> =20
> @@ -239,7 +258,7 @@ static void __kprobes do_kernel_fault(struct pt_regs =
*regs, int si_code,
>  		/* The si_code was set to make clear whether
>  		 * this was a SEGV_MAPERR or SEGV_ACCERR fault.
>  		 */
> -		do_fault_siginfo(si_code, SIGSEGV, regs, insn, fault_code);
> +		do_fault_siginfo(si_code, SIGSEGV, regs, address, insn, fault_code);
>  		return;
>  	}
> =20
> @@ -525,7 +544,7 @@ do_sigbus:
>  	 * Send a sigbus, regardless of whether we were in kernel
>  	 * or user mode.
>  	 */
> -	do_fault_siginfo(BUS_ADRERR, SIGBUS, regs, insn, fault_code);
> +	do_fault_siginfo(BUS_ADRERR, SIGBUS, regs, address, insn, fault_code);
> =20
>  	/* Kernel mode? Handle exceptions or die */
>  	if (regs->tstate & TSTATE_PRIV)
>=20

--=20
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
