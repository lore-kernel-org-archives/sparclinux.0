From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 30 Jun 2010 21:13:26 +0000
Subject: Re: [PATCH 4/4] x86: OLPC: add OLPC device-tree support
Message-Id: <AANLkTik7rqaGz7RtsOlhoSZw_-6bhv43YlWETsB17__4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220058.19e8f143@debian>
	<AANLkTinUy_FGuN9DiF5KtMCsqYUbByfS6g2Mdw0ATvtQ@mail.gmail.com>
	<20100629102339.5e8a30b6@dev.queued.net>
In-Reply-To: <20100629102339.5e8a30b6-ztAUm9HJea/EueBKFXcDjA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, Jun 29, 2010 at 8:23 AM, Andres Salomon <dilinger@queued.net> wrote:
> On Tue, 29 Jun 2010 01:12:36 -0700
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> Hi Andres, comments below....
>
> Thanks!
>
>
>>
>> On Mon, Jun 28, 2010 at 7:00 PM, Andres Salomon <dilinger@queued.net>
>> wrote:
>> >
>> > Make use of PROC_DEVICETREE to export the tree, and sparc's
>> > PROMTREE code to call into OLPC's Open Firmware to build the tree.
>> >
>> > (Yes, I know this leaks memory by simply using kmalloc)
>> >
>> > Signed-off-by: Andres Salomon <dilinger@queued.net>
>> > ---
>> > =A0arch/x86/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++
>> > =A0arch/x86/include/asm/olpc_prom.h | =A0 42 +++++++++++
>> > =A0arch/x86/include/asm/prom.h =A0 =A0 =A0| =A0 =A05 ++
>> > =A0arch/x86/kernel/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
>> > =A0arch/x86/kernel/olpc_ofw.c =A0 =A0 =A0 | =A0 13 ++++
>> > =A0arch/x86/kernel/olpc_prom.c =A0 =A0 =A0| =A0148
>> > ++++++++++++++++++++++++++++++++++++++ fs/proc/Kconfig
>> > =A0 =A0 =A0| =A0 =A02 +- 7 files changed, 215 insertions(+), 1 deletio=
ns(-)
>> > =A0create mode 100644 arch/x86/include/asm/olpc_prom.h
>> > =A0create mode 100644 arch/x86/include/asm/prom.h
>> > =A0create mode 100644 arch/x86/kernel/olpc_prom.c
>> >
>> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > index 71c194d..7aea004 100644
>> > --- a/arch/x86/Kconfig
>> > +++ b/arch/x86/Kconfig
>> > @@ -2071,6 +2071,11 @@ config OLPC_OPENFIRMWARE
>> > =A0 =A0 =A0 =A0 =A0that is used on the OLPC XO-1 Children's Machine.
>> > =A0 =A0 =A0 =A0 =A0If unsure, say N here.
>> >
>> > +config OF
>> > + =A0 =A0 =A0 def_bool y
>> > + =A0 =A0 =A0 depends on OLPC_OPENFIRMWARE
>> > + =A0 =A0 =A0 select OF_PROMTREE
>> > +
>>
>> This hunk will need to be respun on top of Stephen's CONFIG_OF change.
>> =A0It's currently in my test-devicetree branch on
>> git://git.secretlab.ca/git/linux-2.6
>
> Yep, I've changed it locally.
>
>>
>> > =A0endif # X86_32
>> >
>> > =A0config K8_NB
>> > diff --git a/arch/x86/include/asm/olpc_prom.h
>> > b/arch/x86/include/asm/olpc_prom.h new file mode 100644
>> > index 0000000..96cdcee
>> > --- /dev/null
>> > +++ b/arch/x86/include/asm/olpc_prom.h
>> > @@ -0,0 +1,42 @@
>> > +#include <linux/of.h> =A0/* linux/of.h gets to determine #include
>> > ordering */ +/*
>> > + * Definitions for talking to the Open Firmware PROM on
>> > + * Power Macintosh computers.
>> > + *
>> > + * Copyright (C) 1996-2005 Paul Mackerras.
>> > + *
>> > + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM
>> > Corp.
>> > + * Updates for SPARC by David S. Miller
>> > + * Updates for x86/OLPC by Andres Salomon
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU General Public License
>> > + * as published by the Free Software Foundation; either version
>> > + * 2 of the License, or (at your option) any later version.
>> > + */
>> > +
>> > +#ifndef _X86_PROM_OLPC_H
>> > +#define _X86_PROM_OLPC_H
>> > +#ifdef __KERNEL__
>> > +
>> > +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 2
>> > +#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
>>
>> Do you really need to override these from the default?
>>
>> > +#define of_compat_cmp(s1, s2, l) =A0 =A0 =A0 strncmp((s1), (s2), (l))
>> > +#define of_prop_cmp(s1, s2) =A0 =A0 =A0 =A0 =A0 =A0strcasecmp((s1), (=
s2))
>> > +#define of_node_cmp(s1, s2) =A0 =A0 =A0 =A0 =A0 =A0strcmp((s1), (s2))
>>
>> Ditto here?
>
> They're based upon what the old promfs patch used. =A0I need to test and
> verify that strings are being mangled in the same way before I start
> making changes here.

The defaults should do the right thing.  I would be very surprised if
stfncmp() was what you wanted to use because truncates compatible
values on compare.  I believe Sparc has historical reasons for using
it, but new platforms shouldn't need it.

On that point, I think I'm going to change the default override to
specifically test for CONFIG_SPARC instead of doing the weird
defined(OF_ROOT_NODE_ADDR_CELLS_DEFAULT)/defined(of_compat_cmp) I
currently have it doing.  That would probably make this separate
header completely unnecessary (see below).

>> > +extern void prom_build_devicetree(void);
>> > +
>> > +extern void *prom_early_alloc(unsigned long size);
>> > +
>> > +extern char *prom_firstprop(phandle node, char *buf);
>> > +extern char *prom_nextprop(phandle node, const char *prev, char
>> > *buf); +extern int prom_getproplen(phandle node, const char *prop);
>> > +extern int prom_getproperty(phandle node, const char *prop,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *buffer,=
 int bufsize);
>> > +extern phandle prom_getchild(phandle node);
>> > +extern phandle prom_getsibling(phandle node);
>> > +
>> > +#endif /* __KERNEL__ */
>> > +#endif /* _X86_PROM_OLPC_H */
>> > diff --git a/arch/x86/include/asm/prom.h
>> > b/arch/x86/include/asm/prom.h new file mode 100644
>> > index 0000000..7b561b2
>> > --- /dev/null
>> > +++ b/arch/x86/include/asm/prom.h
>> > @@ -0,0 +1,5 @@
>> > +#ifdef CONFIG_OLPC_OPENFIRMWARE
>> > +# include <asm/olpc_prom.h>
>> > +#else
>> > +# error "No OFW prom defined for x86!"
>> > +#endif
>>
>> Personally, I wouldn't bother with the header file redirection.
>
> The reason for the header file redirection is because this is
> OLPC-only; the x86 folks don't want me claiming this to be the One
> True x86 OFW.

However, the #ifdef/#elseif/#else/#endif approach also makes the
assumption that only one kind of OFW will be supported by any given
kernel.  Or for that matter, both OFW and the flattened tree also
become mutually exclusive due to the default behaviour override.

Besides, aren't the function declarations just the interface defined
by the prom extraction code?  Is there any need to #ifdef that API?  I
would think those function prototypes should be defined by the header
for the prom extraction code.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
