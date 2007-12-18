From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 18 Dec 2007 05:37:29 +0000
Subject: Re: [PATCH] Avoid overflows in kernel/time.c (version 4)
Message-Id: <20071218053729.GA13238@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200712172345.lBHNjgGq021212@tazenda.hos.anvin.org>
In-Reply-To: <200712172345.lBHNjgGq021212@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Richard Henderson <rth@twiddle.net>, Michael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, "William L. Irwin" <sparclinux@vger.kernel.org>, Chris Zankel <chris@zankel.net>, Jan Engelhardt <jengelh@computergmbh.de>

> diff --git a/kernel/Makefile b/kernel/Makefile
> index dfa9695..749825a 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -80,3 +80,11 @@ quiet_cmd_ikconfiggz = IKCFG   $@
>  targets += config_data.h
>  $(obj)/config_data.h: $(obj)/config_data.gz FORCE
>  	$(call if_changed,ikconfiggz)
> +
> +$(obj)/time.o: $(obj)/timeconst.h
> +
> +quiet_cmd_timeconst  = TIMEC   $@
> +      cmd_timeconst  = $(PERL) $< $(CONFIG_HZ) > $@
> +targets += timeconst.h
> +$(obj)/timeconst.h: $(src)/timeconst.pl $(wildcard include/config/hz.h) FORCE
> +	$(call if_changed,timeconst)

The prerequisite $(wildcard include/config/hz.h) is not needed.
You will run the perl script if:
- timeconst.h is missing
- if commandline changes (new CONFIG_HZ value)

Otherwise it looks OK to me.

	Sam
