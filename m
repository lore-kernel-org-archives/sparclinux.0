From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 07 Aug 2004 20:36:28 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <Pine.GSO.4.58.0408072234290.23642@waterleaf.sonytel.be>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
 <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
In-Reply-To: <200408072013.01168.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com, "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sat, 7 Aug 2004, Arnd Bergmann wrote:
> > On Sat, Aug 07, 2004 at 06:10:51PM +0100, Christoph Hellwig wrote:
> > > What about switching them to use drivers/Kconfig instead?
>
> I'd prefer not to switch s390 to use drivers/Kconfig unless someone
> volunteers to clean up all included Kconfig files by adding proper
> 'depends on PCI' etc. flags. Otherwise too many broken options are
> offered.

I've been `fixing up' many of them lately. Please give it a try.
Anyway, probably all additional clean ups you do for s390 are useful for m68k
as well ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
