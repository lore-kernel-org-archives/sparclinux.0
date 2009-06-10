From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 10:57:56 +0000
Subject: Re: [PATCH 2/7] Redefine MMU register access asi if CONFIG_LEON
Message-Id: <646765f40906100357x5f789av2e68a3fc0bd9ab08@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45D8.7080609@gaisler.com>
In-Reply-To: <4A2E45D8.7080609@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, Jun 10, 2009 at 20:11, <konrad@gaisler.com> wrote:
> From: Konrad Eisele <konrad@gaisler.com>
>
>> Would it not be better to put the ifdefs around the original
>> definition of ASI_M_MMUREGS?
>
> Done
>
>
> is defined
> ---
> =A0arch/sparc/include/asm/asi.h | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
> index 74703c5..b2e3db6 100644
> --- a/arch/sparc/include/asm/asi.h
> +++ b/arch/sparc/include/asm/asi.h
> @@ -40,7 +40,11 @@ #define ASI_M_RES00 =A0 =A0 =A0 =A0 0x00 =A0 /* Do
> =A0#define ASI_M_UNA01 =A0 =A0 =A0 =A0 0x01 =A0 /* Same here... */
> =A0#define ASI_M_MXCC =A0 =A0 =A0 =A0 =A00x02 =A0 /* Access to TI VIKING =
MXCC registers */
> =A0#define ASI_M_FLUSH_PROBE =A0 0x03 =A0 /* Reference MMU Flush/Probe; r=
w, ss */
> +#ifndef CONFIG_SPARC_LEON
> =A0#define ASI_M_MMUREGS =A0 =A0 =A0 0x04 =A0 /* MMU Registers; rw, ss */
> +#else
> +#define ASI_M_MMUREGS =A0 =A0 =A0 0x19
> +#endif /* CONFIG_SPARC_LEON */

If you do another round of changes to these patches, you may want to
write it as:

#ifdef CONFIG_SPARC_LEON
#define ASI_M_MMUREGS       0x19
#else
#define ASI_M_MMUREGS       0x04   /* MMU Registers; rw, ss */
#endif /* CONFIG_SPARC_LEON */

and put some whitespace around it so it stands out.

You could also comment it similarly to the other entries in this file.

> =A0#define ASI_M_TLBDIAG =A0 =A0 =A0 0x05 =A0 /* MMU TLB only Diagnostics=
 */
> =A0#define ASI_M_DIAGS =A0 =A0 =A0 =A0 0x06 =A0 /* Reference MMU Diagnost=
ics */
> =A0#define ASI_M_IODIAG =A0 =A0 =A0 =A00x07 =A0 /* MMU I/O TLB only Diagn=
ostics */

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
