From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 11 Aug 2004 21:40:32 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <20040811214032.GC7207@mars.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de> <20040811201725.GJ26174@fs.tum.de>
In-Reply-To: <20040811201725.GJ26174@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Arnd Bergmann <arnd@arndb.de>, zippel@linux-m68k.org, Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net

On Wed, Aug 11, 2004 at 10:17:25PM +0200, Adrian Bunk wrote:
> On Sat, Aug 07, 2004 at 08:12:56PM +0200, Arnd Bergmann wrote:
> >...
> > On Samstag, 7. August 2004 19:25, Adrian Bunk wrote:
> > > Is there eny reason for such options that are never visible nor enabled,  
> > > or could they be removed?
> > 
> > Yes, the reason is that some other options depend on them. We added the
> > PCMCIA option to arch/s390/Kconfig to stop kbuild from asking about
> > some drivers that won't work anyway.
> > 
> > E.g. drivers/scsi/pcmcia starts with
> > 
> > menu "PCMCIA SCSI adapter support"
> > 	depends on SCSI!=n && PCMCIA!=n && MODULES
> > 
> > which evaluate to true if the PCMCIA option is not known. Changing
> > that to
> > 
> > menu "PCMCIA SCSI adapter support"
> > 	depends on SCSI && PCMCIA && MODULES
> > 
> > solves this in a different way, but I'm not 100% sure if it still has
> > the same meaning.
> 
> Roman, is it intentional that PCMCIA!=n is true if there's no PCMCIA 
> option, or is it simply a bug?

Roman, a related Q.
Why not error out, or at least warn when encountering an unknow
symbol in a 'depends on' statement?

I took a quick look, but did not initially see how to actually implemnt it.
Considering something in the bottom of menu_finalize()?

	Sam
