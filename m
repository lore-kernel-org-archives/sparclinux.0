From: Adrian Bunk <bunk@fs.tum.de>
Date: Sat, 14 Aug 2004 20:47:12 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <20040814204711.GD1387@fs.tum.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de> <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org> <20040812001003.GV26174@fs.tum.de> <Pine.LNX.4.58.0408121056270.20634@scrub.home>
In-Reply-To: <Pine.LNX.4.58.0408121056270.20634@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net

On Thu, Aug 12, 2004 at 10:59:25AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 12 Aug 2004, Adrian Bunk wrote:
> 
> > > Roman, a related Q.
> > > Why not error out, or at least warn when encountering an unknow
> > > symbol in a 'depends on' statement?
> > >...
> > 
> > That doesn't sound like a good idea, consider e.g.:
> > 
> > config BAGETLANCE
> >         tristate "Baget AMD LANCE support"
> >         depends on NET_ETHERNET && BAGET_MIPS
> 
> This is less a problem, as here it's clear that you want a boolean result, 
> but something like "FOO=n" is really a string compare and FOO could be of 
> any type (that 99% of all symbols are boolean/tristate symbols doesn't 
> really help).

Wouldn't it be better to require a string or hex to always be quoted  
like "somestring"?

This way y/m/n would always have a non-string type.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

