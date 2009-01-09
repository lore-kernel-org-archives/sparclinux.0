From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 09 Jan 2009 19:32:57 +0000
Subject: Re: [PATCH v2 0/5] Eliminate most of sparc_ksyms_*.c
Message-Id: <20090109193257.GB19482@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1C6.1090700@gmail.com>
In-Reply-To: <4965F1C6.1090700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 08, 2009 at 11:20:46PM +0100, Arnd Bergmann wrote:
> On Thursday 08 January 2009, Sam Ravnborg wrote:
> > Arnd Bergman once posted a patchset that allow us to do the export in .S files.
> > 
> > Google for "add support for exporting symbols from .S files"
> > 
> > Could we resurface this patchset?
> 
> The patch should still work. The only concern with this was that it
> still isn't sufficient to kill ksyms.c on architectures that export
> symbols from libgcc.

We have the opportunity to move all EXPORT_SYMBOLS() to
the place where the functions are defined.
The documentation effect that tell the reader:

   "Hey, I may be used by a module so take extra care"

That is enough to warrant the inclusion of this patch.
The aim here is IMO not to kill all the *ksyms.c files but
rather to document which functions are exported at their
definition.

I could see there were some comments about different .align
and the like.

Can I ask you to repolish these bits and submit it to linux-arch.

Thanks,
	Sam
