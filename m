From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Thu, 04 May 2006 13:21:25 +0000
Subject: Re: kernel oops with 2.6.17-rc1 & 2.6.17-rc2
Message-Id: <200605041521.25687.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200604280042.08024.pkarlsen@mandriva.com>
In-Reply-To: <200604280042.08024.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Mandag 01 mai 2006 07:51, skrev du :
> From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
> Date: Fri, 28 Apr 2006 00:42:07 +0200
>
> > When running 2.6.17-rc1 or rc2 I seem to get a lot of these oops, not
> > certain about what exactly causes those, but might seem to happen during
> > a little load..
> > 2.6.16 runs fine without this ever happening.
> >
> > Machine is a blade 100..
>
> I did some investigating.  Do you have preemption enabled?  That's the
> only way this bug could possibly trigger.
Yupps
>
> Jim reported a nearly identical OOPS to your's and his provided config
> has preemption enabled.
>
> This patch should fix the problem:
>
> diff --git a/arch/sparc64/mm/tlb.c b/arch/sparc64/mm/tlb.c
> index a079cf4..3f10fc9 100644
> --- a/arch/sparc64/mm/tlb.c
> +++ b/arch/sparc64/mm/tlb.c
> @@ -8,6 +8,7 @@ #include <linux/init.h>
>  #include <linux/percpu.h>
>  #include <linux/mm.h>
>  #include <linux/swap.h>
> +#include <linux/preempt.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -24,6 +25,8 @@ void flush_tlb_pending(void)
>  {
>  	struct mmu_gather *mp =3D &__get_cpu_var(mmu_gathers);
>
> +	preempt_disable();
> +
>  	if (mp->tlb_nr) {
>  		flush_tsb_user(mp);
>
> @@ -38,6 +41,8 @@ #endif
>  		}
>  		mp->tlb_nr =3D 0;
>  	}
> +
> +	preempt_enable();
>  }
>
>  void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr, pte_t *pte=
p,
> pte_t orig) -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
This didn't do the trick, it made things crash at once, spitting out severa=
l=20
pages of  errors.. :\
A lot of these with tracebacks..
BUG: scheduling while atomic: swapper/0x00000011/1

--=20
Regards,
Per =D8yvind Karlsen
Mandrakesoft becomes Mandriva
