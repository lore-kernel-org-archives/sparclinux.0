From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 03 Nov 2009 22:45:37 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <646765f40911031445s6b008cddl504cd2a883158956@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Nov 3, 2009 at 01:28, Kristoffer Glembo <kristoffer@gaisler.com> wr=
ote:
> Added mmu_inval_dma_area for LEON which flushes dcache if snooping is not=
 enabled
> and created LEON specific dma_ops.
>
> Best regards,
> Kristoffer Glembo
>
> ---
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index 9f61fd8..63aab03 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -415,8 +631,6 @@ static int __init sparc_register_ioport(void)
>
> =A0arch_initcall(sparc_register_ioport);
>
> -#endif /* CONFIG_SBUS */
> -
> =A0#ifdef CONFIG_PCI
>
> =A0/* Allocate and map kernel buffer using consistent mode DMA for a devi=
ce.

Should the arch_initcall() still be protected by the CONFIG_SBUS
ifdefs after this patch?

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
