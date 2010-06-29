From: Andres Salomon <dilinger@queued.net>
Date: Tue, 29 Jun 2010 14:23:39 +0000
Subject: Re: [PATCH 4/4] x86: OLPC: add OLPC device-tree support
Message-Id: <20100629102339.5e8a30b6@dev.queued.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220058.19e8f143@debian>
	<AANLkTinUy_FGuN9DiF5KtMCsqYUbByfS6g2Mdw0ATvtQ@mail.gmail.com>
In-Reply-To: <AANLkTinUy_FGuN9DiF5KtMCsqYUbByfS6g2Mdw0ATvtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, 29 Jun 2010 01:12:36 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> Hi Andres, comments below....

Thanks!


> 
> On Mon, Jun 28, 2010 at 7:00 PM, Andres Salomon <dilinger@queued.net>
> wrote:
> >
> > Make use of PROC_DEVICETREE to export the tree, and sparc's
> > PROMTREE code to call into OLPC's Open Firmware to build the tree.
> >
> > (Yes, I know this leaks memory by simply using kmalloc)
> >
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
> > ---
> >  arch/x86/Kconfig                 |    5 ++
> >  arch/x86/include/asm/olpc_prom.h |   42 +++++++++++
> >  arch/x86/include/asm/prom.h      |    5 ++
> >  arch/x86/kernel/Makefile         |    1 +
> >  arch/x86/kernel/olpc_ofw.c       |   13 ++++
> >  arch/x86/kernel/olpc_prom.c      |  148
> > ++++++++++++++++++++++++++++++++++++++ fs/proc/Kconfig
> >      |    2 +- 7 files changed, 215 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/x86/include/asm/olpc_prom.h
> >  create mode 100644 arch/x86/include/asm/prom.h
> >  create mode 100644 arch/x86/kernel/olpc_prom.c
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 71c194d..7aea004 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2071,6 +2071,11 @@ config OLPC_OPENFIRMWARE
> >          that is used on the OLPC XO-1 Children's Machine.
> >          If unsure, say N here.
> >
> > +config OF
> > +       def_bool y
> > +       depends on OLPC_OPENFIRMWARE
> > +       select OF_PROMTREE
> > +
> 
> This hunk will need to be respun on top of Stephen's CONFIG_OF change.
>  It's currently in my test-devicetree branch on
> git://git.secretlab.ca/git/linux-2.6

Yep, I've changed it locally.

> 
> >  endif # X86_32
> >
> >  config K8_NB
> > diff --git a/arch/x86/include/asm/olpc_prom.h
> > b/arch/x86/include/asm/olpc_prom.h new file mode 100644
> > index 0000000..96cdcee
> > --- /dev/null
> > +++ b/arch/x86/include/asm/olpc_prom.h
> > @@ -0,0 +1,42 @@
> > +#include <linux/of.h>  /* linux/of.h gets to determine #include
> > ordering */ +/*
> > + * Definitions for talking to the Open Firmware PROM on
> > + * Power Macintosh computers.
> > + *
> > + * Copyright (C) 1996-2005 Paul Mackerras.
> > + *
> > + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM
> > Corp.
> > + * Updates for SPARC by David S. Miller
> > + * Updates for x86/OLPC by Andres Salomon
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#ifndef _X86_PROM_OLPC_H
> > +#define _X86_PROM_OLPC_H
> > +#ifdef __KERNEL__
> > +
> > +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 2
> > +#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
> 
> Do you really need to override these from the default?
> 
> > +#define of_compat_cmp(s1, s2, l)       strncmp((s1), (s2), (l))
> > +#define of_prop_cmp(s1, s2)            strcasecmp((s1), (s2))
> > +#define of_node_cmp(s1, s2)            strcmp((s1), (s2))
> 
> Ditto here?

They're based upon what the old promfs patch used.  I need to test and
verify that strings are being mangled in the same way before I start
making changes here.


> 
> > +extern void prom_build_devicetree(void);
> > +
> > +extern void *prom_early_alloc(unsigned long size);
> > +
> > +extern char *prom_firstprop(phandle node, char *buf);
> > +extern char *prom_nextprop(phandle node, const char *prev, char
> > *buf); +extern int prom_getproplen(phandle node, const char *prop);
> > +extern int prom_getproperty(phandle node, const char *prop,
> > +                            char *buffer, int bufsize);
> > +extern phandle prom_getchild(phandle node);
> > +extern phandle prom_getsibling(phandle node);
> > +
> > +#endif /* __KERNEL__ */
> > +#endif /* _X86_PROM_OLPC_H */
> > diff --git a/arch/x86/include/asm/prom.h
> > b/arch/x86/include/asm/prom.h new file mode 100644
> > index 0000000..7b561b2
> > --- /dev/null
> > +++ b/arch/x86/include/asm/prom.h
> > @@ -0,0 +1,5 @@
> > +#ifdef CONFIG_OLPC_OPENFIRMWARE
> > +# include <asm/olpc_prom.h>
> > +#else
> > +# error "No OFW prom defined for x86!"
> > +#endif
> 
> Personally, I wouldn't bother with the header file redirection.

The reason for the header file redirection is because this is
OLPC-only; the x86 folks don't want me claiming this to be the One
True x86 OFW.

