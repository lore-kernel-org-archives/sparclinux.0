From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 15 Aug 2004 19:37:30 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <Pine.GSO.4.58.0408152136400.9281@waterleaf.sonytel.be>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
 <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
 <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org>
 <20040812001003.GV26174@fs.tum.de> <Pine.LNX.4.58.0408121056270.20634@scrub.home>
 <20040814204711.GD1387@fs.tum.de> <Pine.LNX.4.61.0408151928490.12687@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0408151928490.12687@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com, "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net

On Sun, 15 Aug 2004, Roman Zippel wrote:
> On Sat, 14 Aug 2004, Adrian Bunk wrote:
> > > This is less a problem, as here it's clear that you want a boolean result,
> > > but something like "FOO=n" is really a string compare and FOO could be of
> > > any type (that 99% of all symbols are boolean/tristate symbols doesn't
> > > really help).
> >
> > Wouldn't it be better to require a string or hex to always be quoted
> > like "somestring"?
>
> What about normal numbers? I don't think requiring quotes everywhere for
> this is a good idea.

And numbers (both decimal and hex) can easily be distinguished from y, n, and m
anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
