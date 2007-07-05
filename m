From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Jul 2007 12:49:52 +0000
Subject: Re: dead(?) CONFIG vars
Message-Id: <Pine.LNX.4.64.0707051449310.23477@anakin>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0707051418440.23477@anakin>
In-Reply-To: <Pine.LNX.4.64.0707051418440.23477@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hi Robert,

On Thu, 5 Jul 2007, Robert P. J. Day wrote:
> On Thu, 5 Jul 2007, Geert Uytterhoeven wrote:
> > On Thu, 5 Jul 2007, Robert P. J. Day wrote:
> > > ===== AP1000 =====
> > > arch/m68k/sun3/prom/printf.c:40:#ifdef CONFIG_AP1000
> > > arch/m68k/sun3/prom/init.c:34:#ifdef CONFIG_AP1000
> >
> > The AP1000 was actually a SPARC system (cluster). The only reason these
> > tests ended up in arch/m68k/ are because lots of Sun3 code got copied from
> > SPARC.
> >
> > I guess these #ifdefs can be nuked.
> >
> > > include/linux/major.h:66:#define APBLOCK_MAJOR		38   /* AP1000 Block device */
> > > include/linux/major.h:67:#define DDV_MAJOR		39   /* AP1000 DDV block device */
> > > include/linux/if_arp.h:69:#define ARPHRD_BIF      775             /* AP1000 BIF                   */
> > > net/ipv4/arp.c:60: *		Alan Cox 	:	Took the AP1000 nasty FDDI hack and
> > > net/ieee80211/ieee80211_rx.c:1139:			 * Orinoco AP1000. */
> > > usr/include/linux/major.h:66:#define APBLOCK_MAJOR		38   /* AP1000 Block device */
> > > usr/include/linux/major.h:67:#define DDV_MAJOR		39   /* AP1000 DDV block device */
> > > usr/include/linux/if_arp.h:69:#define ARPHRD_BIF      775             /* AP1000 BIF                   */
> >
> > For these you want to talk to Paul Mackerras and the sparclinux people (in CC).
> 
> oh, i realize that some of that content is not relevant for you.  all
> i'm doing is printing out *everywhere* in the tree that symbol appears
> so you can see if it affects you in any way, besides that part that
> just affects your particular architecture.
> 
> do you want me to submit a patch removing that stuff related just to
> m68k?  or do you want to handle it yourself?  i'm fine either way.

Feel free to remove it from m68k. Thx!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
