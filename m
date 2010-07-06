From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 06 Jul 2010 09:21:21 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building code
Message-Id: <AANLkTikDdAuDOxBVgV_QDY-YZOOZCyl1O5aYzDXCjW10@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220037.5744c207@debian>
In-Reply-To: <20100628220037.5744c207@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net

On Mon, Jun 28, 2010 at 8:00 PM, Andres Salomon <dilinger@queued.net> wrote:
>
> Stick code into drivers/of/pdt.c (Prom Device Tree) that other
> architectures with OpenFirmware resident in memory can make use of.
>
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Some more comments below...

BTW, for the changes, you might what to split this patch into two
pieces.  One to verbatim copy the code from prom_common.c, and a
second to adapt it for non-sparc.  That will make the changes obvious
to future readers.  It will also make review easier.

> ---
> =A0arch/sparc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/sparc/include/asm/prom.h =A0 | =A0 15 +++-
> =A0arch/sparc/kernel/prom.h =A0 =A0 =A0 =A0| =A0 14 ---
> =A0arch/sparc/kernel/prom_common.c | =A0173 +----------------------------=
--
> =A0drivers/of/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/of/pdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0225 +++++++++++++=
++++++++++++++++++++++++++
> =A0include/linux/of_pdt.h =A0 =A0 =A0 =A0 =A0| =A0 37 +++++++
> =A08 files changed, 282 insertions(+), 188 deletions(-)
> =A0create mode 100644 drivers/of/pdt.c
> =A0create mode 100644 include/linux/of_pdt.h
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 6f1470b..b4cb63b 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -150,6 +150,7 @@ config ARCH_NO_VIRT_TO_BUS
>
> =A0config OF
> =A0 =A0 =A0 =A0def_bool y
> + =A0 =A0 =A0 select OF_PROMTREE
>
> =A0config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> =A0 =A0 =A0 =A0def_bool y if SPARC64
> diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
> index f845828..0834c2a 100644
> --- a/arch/sparc/include/asm/prom.h
> +++ b/arch/sparc/include/asm/prom.h
> @@ -18,6 +18,7 @@
> =A0* 2 of the License, or (at your option) any later version.
> =A0*/
> =A0#include <linux/types.h>
> +#include <linux/of_pdt.h>
> =A0#include <linux/proc_fs.h>
> =A0#include <linux/mutex.h>
> =A0#include <asm/atomic.h>
> @@ -65,8 +66,18 @@ extern struct device_node *of_console_device;
> =A0extern char *of_console_path;
> =A0extern char *of_console_options;
>
> -extern void (*prom_build_more)(struct device_node *dp, struct device_nod=
e ***nextp);
> -extern char *build_full_name(struct device_node *dp);
> +/* stuff used by of/pdt */
> +extern void * prom_early_alloc(unsigned long size);
> +extern void irq_trans_init(struct device_node *dp);
> +extern char *build_path_component(struct device_node *dp);
> +
> +extern char *prom_firstprop(int node, char *buffer);
> +extern char *prom_nextprop(int node, const char *oprop, char *buffer);
> +extern int prom_getproplen(int node, const char *prop);
> +extern int prom_getproperty(int node, const char *prop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buffer, int b=
ufsize);
> +extern int prom_getchild(int node);
> +extern int prom_getsibling(int node);

These become the API required by of/pdt.  They should be defined in a
arch-independent header file.  Something like include/linux/of_pdt.h

Right now only OLPC will be using this, so static function definitions
are just fine.  However, if there is ever more than one method for
talking to OFW, then these hooks will need to be converted into an ops
structure so the right one can be passed in at runtime.

> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> new file mode 100644
> index 0000000..b24167f
> --- /dev/null
> +++ b/drivers/of/pdt.c
> @@ -0,0 +1,225 @@
> +/*
> + * Paul Mackerras =A0 =A0 =A0August 1996.
> + * Copyright (C) 1996-2005 Paul Mackerras.
> + *
> + * =A0Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
> + * =A0 =A0{engebret|bergner}@us.ibm.com
> + *
> + * =A0Adapted for sparc by David S. Miller davem@davemloft.net
> + * =A0Adapted for multiple architectures by Andres Salomon <dilinger@que=
ued.net>
> + *
> + * =A0 =A0 =A0This program is free software; you can redistribute it and=
/or
> + * =A0 =A0 =A0modify it under the terms of the GNU General Public License
> + * =A0 =A0 =A0as published by the Free Software Foundation; either versi=
on
> + * =A0 =A0 =A02 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_pdt.h>
> +#include <asm/prom.h>
> +
> +/* TODO: mark this stuff as __initdata */
> +void (*prom_build_more)(struct device_node *dp, struct device_node ***ne=
xtp);

So do it.  :-)

> +
> +#if defined(CONFIG_SPARC)
> +static unsigned int prom_unique_id;
> +
> +#define inc_unique_id(p) do { \
> + =A0 =A0 =A0 (p)->unique_id =3D prom_unique_id++; \
> +} while (0)
> +
> +static inline const char *fetch_node_name(struct device_node *dp)
> +{
> + =A0 =A0 =A0 return dp->path_component_name;
> +}
> +
> +#else
> +
> +#define inc_unique_id(p) =A0 =A0 =A0 do { } while(0)

Use an empty static inline instead.

> +
> +static inline const char *fetch_node_name(struct device_node *dp)
> +{
> + =A0 =A0 =A0 return dp->name;
> +}
> +
> +static inline void irq_trans_init(struct device_node *dp)
> +{
> + =A0 =A0 =A0 /* unused on non-SPARC architectures */
> +}
> +
> +#endif /* !CONFIG_SPARC */
> +
> +static struct property * __init build_one_prop(phandle node, char *prev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0char *special_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0void *special_val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int special_len)

I'd like to see all the static symbols in this file prefixed with
something unique to avoid collisions with the global namespace.
of_pdt_* would be good.  I'm doing this with the other files in
drivers/of whenever I can too.

> +{
> + =A0 =A0 =A0 static struct property *tmp =3D NULL;
> + =A0 =A0 =A0 struct property *p;
> + =A0 =A0 =A0 const char *name;
> +
> + =A0 =A0 =A0 if (tmp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D tmp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(p, 0, sizeof(*p) + 32);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D NULL;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D prom_early_alloc(sizeof(struct proper=
ty) + 32);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 inc_unique_id(p);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 p->name =3D (char *) (p + 1);
> + =A0 =A0 =A0 if (special_name) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(p->name, special_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D special_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->value =3D prom_early_alloc(special_len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(p->value, special_val, special_len);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev =3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D prom_firstprop(nod=
e, p->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D prom_nextprop(node=
, prev, p->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!name || strlen(name) =3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D p;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#ifdef CONFIG_SPARC32
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(p->name, name);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D prom_getproplen(node, p->name=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->length <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->value =3D prom_early_all=
oc(p->length + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_getproperty(no=
de, p->name, p->value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0p->length);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned char *)p->value)=
[p->length] =3D '\0';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return p;
> +}
> +
> +static struct property * __init build_prop_list(phandle node)
> +{
> + =A0 =A0 =A0 struct property *head, *tail;
> +
> + =A0 =A0 =A0 head =3D tail =3D build_one_prop(node, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
".node", &node, sizeof(node));
> +
> + =A0 =A0 =A0 tail->next =3D build_one_prop(node, NULL, NULL, NULL, 0);
> + =A0 =A0 =A0 tail =3D tail->next;
> + =A0 =A0 =A0 while(tail) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tail->next =3D build_one_prop(node, tail->n=
ame,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 NULL, NULL, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tail =3D tail->next;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return head;
> +}
> +
> +static char * __init get_one_property(phandle node, const char *name)
> +{
> + =A0 =A0 =A0 char *buf =3D "<NULL>";
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 len =3D prom_getproplen(node, name);
> + =A0 =A0 =A0 if (len > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf =3D prom_early_alloc(len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_getproperty(node, name, buf, l=
en);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return buf;
> +}
> +
> +struct device_node * __init prom_create_node(phandle node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0struct device_node *parent)
> +{
> + =A0 =A0 =A0 struct device_node *dp;
> +
> + =A0 =A0 =A0 if (!node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 dp =3D prom_early_alloc(sizeof(*dp));
> + =A0 =A0 =A0 inc_unique_id(dp);
> + =A0 =A0 =A0 dp->parent =3D parent;
> +
> + =A0 =A0 =A0 kref_init(&dp->kref);
> +
> + =A0 =A0 =A0 dp->name =3D get_one_property(node, "name");
> + =A0 =A0 =A0 dp->type =3D get_one_property(node, "device_type");
> + =A0 =A0 =A0 dp->phandle =3D node;
> +
> + =A0 =A0 =A0 dp->properties =3D build_prop_list(node);
> +
> + =A0 =A0 =A0 irq_trans_init(dp);
> +
> + =A0 =A0 =A0 return dp;
> +}
> +
> +static char * __init build_full_name(struct device_node *dp)
> +{
> + =A0 =A0 =A0 int len, ourlen, plen;
> + =A0 =A0 =A0 char *n;
> +
> + =A0 =A0 =A0 plen =3D strlen(dp->parent->full_name);
> + =A0 =A0 =A0 ourlen =3D strlen(fetch_node_name(dp));
> + =A0 =A0 =A0 len =3D ourlen + plen + 2;
> +
> + =A0 =A0 =A0 n =3D prom_early_alloc(len);
> + =A0 =A0 =A0 strcpy(n, dp->parent->full_name);
> + =A0 =A0 =A0 if (!is_root_node(dp->parent)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(n + plen, "/");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plen++;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 strcpy(n + plen, fetch_node_name(dp));
> +
> + =A0 =A0 =A0 return n;
> +}
> +
> +struct device_node * __init prom_build_tree(struct device_node *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 phandle node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct device_node ***nextp)
> +{
> + =A0 =A0 =A0 struct device_node *ret =3D NULL, *prev_sibling =3D NULL;
> + =A0 =A0 =A0 struct device_node *dp;
> +
> + =A0 =A0 =A0 while (1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp =3D prom_create_node(node, parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev_sibling)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_sibling->sibling =3D d=
p;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_sibling =3D dp;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(*nextp) =3D dp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *nextp =3D &dp->allnext;
> +
> +#if defined(CONFIG_SPARC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->path_component_name =3D build_path_comp=
onent(dp);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->full_name =3D build_full_name(dp);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->child =3D prom_build_tree(dp, prom_getc=
hild(node), nextp);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prom_build_more)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_build_more(dp, nextp);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D prom_getsibling(node);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}

prom_build_devicetree() should also be factored out.

> diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
> new file mode 100644
> index 0000000..f62616e
> --- /dev/null
> +++ b/include/linux/of_pdt.h
> @@ -0,0 +1,37 @@
> +#include <linux/of.h> =A0/* linux/of.h gets to determine #include orderi=
ng */

Do you really need this #include in this way?  Can it be moved inside
the #ifndef OF_PDT block below?

> +/*
> + * Definitions for building a device tree by calling into the
> + * Open Firmware PROM.
> + *
> + * Copyright (C) 1996-2005 Paul Mackerras.
> + * Copyright (C) 2010 =A0Andres Salomon <dilinger@queued.net>
> + *
> + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
> + * Updates for SPARC by David S. Miller
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _LINUX_OF_PDT_H
> +#define _LINUX_OF_PDT_H
> +
> +extern struct device_node *prom_create_node(phandle node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct device_node *parent);
> +extern struct device_node *prom_build_tree(struct device_node *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0phandle node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0struct device_node ***nextp);
> +
> +extern void (*prom_build_more)(struct device_node *dp, struct device_nod=
e ***nextp);
> +
> +static inline int is_root_node(const struct device_node *dp)
> +{
> + =A0 =A0 =A0 if (!dp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return (dp->parent =3D NULL);
> +}

This doesn't look like a pdt specific function, it could go in
include/linux/of.h.

Another general comment, I'm still not thrilled with this code having
its own independent method for building the tree, but I doubt the
existing add/remove nodes and properties code is usable early enough
to be suitable for sparc.  How early do you extract the device tree on
OLPC?  How are you going to use the data?

Anyway, enough comments for tonight.  I'll may have more on then next
round.  Time to go to bed.

g.
