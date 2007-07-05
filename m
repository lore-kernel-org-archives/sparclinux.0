From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Jul 2007 12:25:27 +0000
Subject: Re: dead(?) CONFIG vars
Message-Id: <Pine.LNX.4.64.0707051418440.23477@anakin>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hi Robert,

On Thu, 5 Jul 2007, Robert P. J. Day wrote:
> ===== AP1000 =====
> arch/m68k/sun3/prom/printf.c:40:#ifdef CONFIG_AP1000
> arch/m68k/sun3/prom/init.c:34:#ifdef CONFIG_AP1000

The AP1000 was actually a SPARC system (cluster). The only reason these
tests ended up in arch/m68k/ are because lots of Sun3 code got copied from
SPARC.

I guess these #ifdefs can be nuked.

> include/linux/major.h:66:#define APBLOCK_MAJOR		38   /* AP1000 Block device */
> include/linux/major.h:67:#define DDV_MAJOR		39   /* AP1000 DDV block device */
> include/linux/if_arp.h:69:#define ARPHRD_BIF      775             /* AP1000 BIF                   */
> net/ipv4/arp.c:60: *		Alan Cox 	:	Took the AP1000 nasty FDDI hack and
> net/ieee80211/ieee80211_rx.c:1139:			 * Orinoco AP1000. */
> usr/include/linux/major.h:66:#define APBLOCK_MAJOR		38   /* AP1000 Block device */
> usr/include/linux/major.h:67:#define DDV_MAJOR		39   /* AP1000 DDV block device */
> usr/include/linux/if_arp.h:69:#define ARPHRD_BIF      775             /* AP1000 BIF                   */

For these you want to talk to Paul Mackerras and the sparclinux people (in CC).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
