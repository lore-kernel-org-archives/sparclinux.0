From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 23:41:10 +0000
Subject: Re: [PATCH 1/7] CONFIG_SPARC_LEON option
Message-Id: <646765f40906101641q26f3e593o5f4ed839b650cd21@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Konrad,

One more small comment =3D)

On Wed, Jun 10, 2009 at 20:09, <konrad@gaisler.com> wrote:
> From: Konrad Eisele <konrad@gaisler.com>
>
> This macro will shield, if undefined, the sun-sparc code
> from LEON specific code. In particular include/asm/leon.h
> will get empty through #ifdef arch/sparc/kernel/leon.c not
> compiled through Makefile:obj-$(CONFIG_SPARC_LEON)
> arch/sparc/mm/leon.c not compiled through
> Makefile:obj-$(CONFIG_SPARC_LEON)
> ---
> =A0arch/sparc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06
> =A0arch/sparc/include/asm/leon.h | =A0571 +++++++++++++++++++++++++++++++=
++++++++++
> =A0arch/sparc/kernel/leon_k.c =A0 =A0| =A0195 ++++++++++++++
> =A0arch/sparc/mm/leon_m.c =A0 =A0 =A0 =A0| =A0254 ++++++++++++++++++
> =A04 files changed, 1026 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/mm/leon_m.c b/arch/sparc/mm/leon_m.c
> new file mode 100644
> index 0000000..ef66716
> --- /dev/null
> +++ b/arch/sparc/mm/leon_m.c
> @@ -0,0 +1,254 @@
> +/*
> + * =A0linux/arch/sparc/mm/leon.c

This isn't consistent with the name of the file, something else you
might want to change if you re-spin this.

> + *
> + * Copyright (C) 2004 Konrad Eisele
> + * (eiselekd@web.de, konrad@gaisler.com), Gaisler Research
> + * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com),
> + * Konrad Eisele (konrad@gaisler.com) Aeroflex Gaisler AB
> + *
> + * do srmmu probe in software
> + */

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
