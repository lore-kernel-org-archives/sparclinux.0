From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 00:02:48 +0000
Subject: Re: [PATCH 2/7] Redefine MMU register access asi if CONFIG_LEON
Message-Id: <646765f40906091702s12bba20na12cacedc0943dee@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45D8.7080609@gaisler.com>
In-Reply-To: <4A2E45D8.7080609@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Jun 9, 2009 at 21:22, Konrad Eisele<konrad@gaisler.com> wrote:
> From fb5efd06d7e8ed5bc09b1be66cda8167342a2737 Mon Sep 17 00:00:00 2001
> From: Konrad Eisele <konrad@gaisler.com>
> Date: Tue, 9 Jun 2009 12:51:43 +0200
> Subject: [PATCH 2/7] Redefine MMU register access asi if CONFIG_LEON
> is defined
>
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
> ---
> =A0arch/sparc/include/asm/asi.h | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
> index 74703c5..aa498f8 100644
> --- a/arch/sparc/include/asm/asi.h
> +++ b/arch/sparc/include/asm/asi.h
> @@ -259,4 +259,9 @@ #define ASI_BLK_S =A0 =A0 =A0 =A0 =A0 0xf1 /* Seconda=
ry, bl
> =A0#define ASI_BLK_PL =A0 =A0 =A0 =A0 =A0 =A0 0xf8 /* Primary, blk ld/st,=
 little =A0 =A0 =A0*/
> =A0#define ASI_BLK_SL =A0 =A0 =A0 =A0 =A0 =A0 0xf9 /* Secondary, blk ld/s=
t, little =A0 =A0*/
>
> +#ifdef CONFIG_LEON
> +#undef =A0ASI_M_MMUREGS
> +#define ASI_M_MMUREGS =A0 =A0 =A0 =A0 =A00x19
> +#endif /* CONFIG_LEON */
> +
> =A0#endif /* _SPARC_ASI_H */

Would it not be better to put the ifdefs around the original
definition of ASI_M_MMUREGS?

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
