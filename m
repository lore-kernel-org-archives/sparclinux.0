From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 17 Dec 2007 23:33:45 +0000
Subject: Re: [PATCH] Avoid overflows in kernel/time.c (version 3)
Message-Id: <47670759.4040208@zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200712172228.lBHMSW3i019555@tazenda.hos.anvin.org> <Pine.LNX.4.64.0712180028430.32270@fbirervta.pbzchgretzou.qr>
In-Reply-To: <Pine.LNX.4.64.0712180028430.32270@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Richard Henderson <rth@twiddle.net>, Michael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, "William L. Irwin" <sparclinux@vger.kernel.org>, Chris Zankel <chris@zankel.net>

Jan Engelhardt wrote:
> On Dec 17 2007 13:53, H. Peter Anvin wrote:
> 
>> index 0000000..fd46b3d
>> --- /dev/null
>> +++ b/kernel/timeconst.pl
> 
> Could this live in scripts/ too? (And use CodingStyle?)

Why should it live in scripts/ rather than where it is used?  scripts/ 
is used either for global scripts or scripts which are used manually. 
Other scripts are not centralized there.

CodingStyle is applicable to C code, not to scripts as far as I can tell.

	-hpa

