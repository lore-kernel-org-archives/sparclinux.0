From: Andres Salomon <dilinger@queued.net>
Date: Wed, 30 Jun 2010 21:32:18 +0000
Subject: Re: [PATCH 4/4] x86: OLPC: add OLPC device-tree support
Message-Id: <20100630173218.2bdd18d4@dev.queued.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220058.19e8f143@debian>
	<AANLkTinUy_FGuN9DiF5KtMCsqYUbByfS6g2Mdw0ATvtQ@mail.gmail.com>
	<20100629102339.5e8a30b6@dev.queued.net>
	<AANLkTik7rqaGz7RtsOlhoSZw_-6bhv43YlWETsB17__4@mail.gmail.com>
In-Reply-To: <AANLkTik7rqaGz7RtsOlhoSZw_-6bhv43YlWETsB17__4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Wed, 30 Jun 2010 15:13:26 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Jun 29, 2010 at 8:23 AM, Andres Salomon <dilinger@queued.net>
> wrote:
> > On Tue, 29 Jun 2010 01:12:36 -0700
> > Grant Likely <grant.likely@secretlab.ca> wrote:
[...]
> >> > +extern void prom_build_devicetree(void);
> >> > +
> >> > +extern void *prom_early_alloc(unsigned long size);
> >> > +
> >> > +extern char *prom_firstprop(phandle node, char *buf);
> >> > +extern char *prom_nextprop(phandle node, const char *prev, char
> >> > *buf); +extern int prom_getproplen(phandle node, const char
> >> > *prop); +extern int prom_getproperty(phandle node, const char
> >> > *prop,
> >> > +                            char *buffer, int bufsize);
> >> > +extern phandle prom_getchild(phandle node);
> >> > +extern phandle prom_getsibling(phandle node);
> >> > +
> >> > +#endif /* __KERNEL__ */
> >> > +#endif /* _X86_PROM_OLPC_H */
> >> > diff --git a/arch/x86/include/asm/prom.h
> >> > b/arch/x86/include/asm/prom.h new file mode 100644
> >> > index 0000000..7b561b2
> >> > --- /dev/null
> >> > +++ b/arch/x86/include/asm/prom.h
> >> > @@ -0,0 +1,5 @@
> >> > +#ifdef CONFIG_OLPC_OPENFIRMWARE
> >> > +# include <asm/olpc_prom.h>
> >> > +#else
> >> > +# error "No OFW prom defined for x86!"
> >> > +#endif
> >>
> >> Personally, I wouldn't bother with the header file redirection.
> >
> > The reason for the header file redirection is because this is
> > OLPC-only; the x86 folks don't want me claiming this to be the One
> > True x86 OFW.
> 
> However, the #ifdef/#elseif/#else/#endif approach also makes the
> assumption that only one kind of OFW will be supported by any given
> kernel.  Or for that matter, both OFW and the flattened tree also
> become mutually exclusive due to the default behaviour override.
> 
> Besides, aren't the function declarations just the interface defined
> by the prom extraction code?  Is there any need to #ifdef that API?  I
> would think those function prototypes should be defined by the header
> for the prom extraction code.

Mm, both are good points; I suppose for now it doesn't hurt to lose the
#ifdefs, and deal w/ additional x86 proms support if it comes up.

