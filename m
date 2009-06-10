From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 23:54:44 +0000
Subject: Re: [PATCH 7/7] sparc-leon specific SRMMU initialization and
Message-Id: <646765f40906101654o3273d45dx814a82c39efb9722@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45EE.40007@gaisler.com>
In-Reply-To: <4A2E45EE.40007@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Konrad,

A couple of comments.

On Wed, Jun 10, 2009 at 20:24, <konrad@gaisler.com> wrote:
> From: Konrad Eisele <konrad@gaisler.com>
>
> sparc-leon specific SRMMU initialization and
> bootup fixes. The sparc-leon caches are virtually tagged so a flush is ne=
eded on ctx
> switch.
> ---
> =A0arch/sparc/mm/srmmu.c | =A0 67 +++++++++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 67 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 06c9a7d..0cf201b 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -46,6 +46,10 @@ #include <asm/tsunami.h>
> =A0#include <asm/swift.h>
> =A0#include <asm/turbosparc.h>
>
> +#ifdef CONFIG_SPARC_LEON
> +#include <asm/leon.h>
> +#endif
> +

Hm, you don't need to ifdef this anymore =3D)

> =A0#include <asm/btfixup.h>
>
> =A0enum mbus_module srmmu_modtype;
> @@ -568,6 +572,11 @@ static void srmmu_switch_mm(struct mm_st
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0srmmu_ctxd_set(&srmmu_context_table[mm->co=
ntext], mm->pgd);
> =A0 =A0 =A0 =A0}
>
> +#ifdef CONFIG_SPARC_LEON
> + =A0 =A0 =A0 flush_tlb_mm(0);
> + =A0 =A0 =A0 if (leon_flush_during_switch)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 leon_flush_cache_all();
> +#endif
> =A0 =A0 =A0 =A0if (is_hypersparc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hyper_flush_whole_icache();
>

Hmm... it would be nice to match the style of the statement after
this, something like:

if (is_leon) {
    flush_tlb_mm(0);
    if (leon_flush_during_switch)
        leon_flush_cache_all();
}

But that would mean that the leon_flush_during_switch and
leon_flush_cache_all() would have to be defined for the non-SPARC_LEON
case, which isn't what you're trying to do here, however if
leon_flush_cache_all() is defined as a blank function, the compiler
*should* optimise all this away.

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
