From: Adrian Bunk <bunk@fs.tum.de>
Date: Thu, 12 Aug 2004 00:10:03 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <20040812001003.GV26174@fs.tum.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de> <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org>
In-Reply-To: <20040811214032.GC7207@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, zippel@linux-m68k.org, Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net

On Wed, Aug 11, 2004 at 11:40:32PM +0200, Sam Ravnborg wrote:
> 
> Roman, a related Q.
> Why not error out, or at least warn when encountering an unknow
> symbol in a 'depends on' statement?
>...

That doesn't sound like a good idea, consider e.g.:

config BAGETLANCE
        tristate "Baget AMD LANCE support"
        depends on NET_ETHERNET && BAGET_MIPS


> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

