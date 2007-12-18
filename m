From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Tue, 18 Dec 2007 12:32:42 +0000
Subject: Re: [PATCH] Avoid overflows in kernel/time.c (version 3)
Message-Id: <Pine.LNX.4.64.0712181331240.32270@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <200712172228.lBHMSW3i019555@tazenda.hos.anvin.org>
 <Pine.LNX.4.64.0712180028430.32270@fbirervta.pbzchgretzou.qr>
 <47670759.4040208@zytor.com>
In-Reply-To: <47670759.4040208@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Richard Henderson <rth@twiddle.net>, Michael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, "William L. Irwin" <sparclinux@vger.kernel.org>, Chris Zankel <chris@zankel.net>


On Dec 17 2007 15:33, H. Peter Anvin wrote:
>> Could this live in scripts/ too? (And use CodingStyle?)
>
> Why should it live in scripts/ rather than where it is used?  scripts/ is used
> either for global scripts or scripts which are used manually. Other scripts are
> not centralized there.
>
> CodingStyle is applicable to C code, not to scripts as far as I can tell.
>
Checkpatch adheres to it. And indent, which is applicable to almost all
languages, is a strong point in CodingStyle.
