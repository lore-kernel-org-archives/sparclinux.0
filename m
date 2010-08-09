From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 09 Aug 2010 05:12:21 +0000
Subject: Re: [PATCH 2/3] sparc: make driver/of/pdt no longer sparc-specific
Message-Id: <AANLkTimG7u5eXWSn5VznKfuFcFD+evTzo1_QpAFmCdpL@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100808231116.21c7d6f3@dev.queued.net>
In-Reply-To: <20100808231116.21c7d6f3@dev.queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

Hi Andres, thanks for the patch.  Comments below.

g.

On Sun, Aug 8, 2010 at 9:11 PM, Andres Salomon <dilinger@queued.net> wrote:
>
> Clean up pdt.c:
> =A0- make build dependent upon config OF_PROMTREE
> =A0- #ifdef out the sparc-specific stuff
> =A0- create pdt-specific header
> =A0- create a pdt_ops struct that pdt uses to call arch-specific prom rou=
tines
>
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> =A0arch/sparc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/sparc/include/asm/prom.h =A0 | =A0 =A05 +-
> =A0arch/sparc/kernel/prom.h =A0 =A0 =A0 =A0| =A0 =A06 --
> =A0arch/sparc/kernel/prom_common.c | =A0 57 ++++++++++++++++++++++-
> =A0drivers/of/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++
> =A0drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/of/pdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 98 +++++++++++++=
++++++++++++-------------
> =A0include/linux/of_pdt.h =A0 =A0 =A0 =A0 =A0| =A0 42 +++++++++++++++++
> =A08 files changed, 171 insertions(+), 43 deletions(-)
> =A0create mode 100644 include/linux/of_pdt.h
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 13a9f2f..ed3f009 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -24,6 +24,7 @@ config SPARC
> =A0 =A0 =A0 =A0select HAVE_ARCH_KGDB if !SMP || SPARC64
> =A0 =A0 =A0 =A0select HAVE_ARCH_TRACEHOOK
> =A0 =A0 =A0 =A0select ARCH_WANT_OPTIONAL_GPIOLIB
> + =A0 =A0 =A0 select OF_PROMTREE

Group this with the select OF from earlier in the config SPARC option.

> =A0 =A0 =A0 =A0select RTC_CLASS
> =A0 =A0 =A0 =A0select RTC_DRV_M48T59
> =A0 =A0 =A0 =A0select HAVE_PERF_EVENTS
> diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
> index f845828..329a976 100644
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
> @@ -65,8 +66,8 @@ extern struct device_node *of_console_device;
> =A0extern char *of_console_path;
> =A0extern char *of_console_options;
>
> -extern void (*prom_build_more)(struct device_node *dp, struct device_nod=
e ***nextp);
> -extern char *build_full_name(struct device_node *dp);
> +extern void irq_trans_init(struct device_node *dp);
> +extern char *build_path_component(struct device_node *dp);
>
> =A0#endif /* __KERNEL__ */
> =A0#endif /* _SPARC_PROM_H */
> diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
> index eeb04a7..cf5fe1c 100644
> --- a/arch/sparc/kernel/prom.h
> +++ b/arch/sparc/kernel/prom.h
> @@ -4,12 +4,6 @@
> =A0#include <linux/spinlock.h>
> =A0#include <asm/prom.h>
>
> -extern void * prom_early_alloc(unsigned long size);
> -extern void irq_trans_init(struct device_node *dp);
> -
> -extern unsigned int prom_unique_id;
> -
> -extern char *build_path_component(struct device_node *dp);
> =A0extern void of_console_init(void);
>
> =A0extern unsigned int prom_early_allocated;
> diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_com=
mon.c
> index 7b454f6..4c5f67f 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c
> @@ -20,6 +20,7 @@
> =A0#include <linux/mutex.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/of.h>
> +#include <linux/of_pdt.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/oplib.h>
> =A0#include <asm/leon.h>
> @@ -117,6 +118,60 @@ int of_find_in_proplist(const char *list, const char=
 *match, int len)
> =A0}
> =A0EXPORT_SYMBOL(of_find_in_proplist);
>
> +/*
> + * SPARC32 and SPARC64's prom_firstprop/prom_nextprop do things differen=
tly
> + * here, despite sharing the same interface. =A0SPARC32 doesn't fill in =
'buf',
> + * returning NULL on an error. =A0SPARC64 fills in 'buf', but sets it to=
 an
> + * empty string upon error.
> + */
> +static int __init handle_prop_quirks(char *buf, const char *name)
> +{
> + =A0 =A0 =A0 if (!name || strlen(name) =3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> +#ifdef CONFIG_SPARC32
> + =A0 =A0 =A0 strcpy(buf, name);
> +#endif
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __init prom_common_firstprop(phandle node, char *buf)
> +{
> + =A0 =A0 =A0 const char *name;
> +
> + =A0 =A0 =A0 buf[0] =3D '\0';
> + =A0 =A0 =A0 name =3D prom_firstprop(node, buf);
> + =A0 =A0 =A0 return handle_prop_quirks(buf, name);
> +}
> +
> +static int __init prom_common_nextprop(phandle node, const char *prev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
> +{
> + =A0 =A0 =A0 const char *name;
> +
> + =A0 =A0 =A0 buf[0] =3D '\0';
> + =A0 =A0 =A0 name =3D prom_nextprop(node, prev, buf);
> + =A0 =A0 =A0 return handle_prop_quirks(buf, name);
> +}

Rather than having both prom_common_{firstprop,nextprop}(), there only
needs to be one hook; prom_common_nextprop().  Make it use the
firstprop behaviour when it is passed a NULL in the prev pointer.
This will simplify the users of this code further down.

> +
> =A0unsigned int prom_early_allocated __initdata;
>
> -#include "../../../drivers/of/pdt.c"
> +static struct of_pdt_ops prom_sparc_ops __initdata =3D {
> + =A0 =A0 =A0 .firstprop =3D prom_common_firstprop,
> + =A0 =A0 =A0 .nextprop =3D prom_common_nextprop,
> + =A0 =A0 =A0 .getproplen =3D (int (*)(phandle, const char *))prom_getpro=
plen,
> + =A0 =A0 =A0 .getproperty =3D (int (*)(phandle, const char *, char *, in=
t))prom_getproperty,
> + =A0 =A0 =A0 .getchild =3D (phandle (*)(phandle))prom_getchild,
> + =A0 =A0 =A0 .getsibling =3D (phandle (*)(phandle))prom_getsibling,

If you have to explicitly cast these function pointers, then you're
doing it wrong.  :-)  Listen to and fix the compiler complaint here.

> +};
> +
> +void __init prom_build_devicetree(void)
> +{
> + =A0 =A0 =A0 of_pdt_set_ops(&prom_sparc_ops);
> + =A0 =A0 =A0 of_pdt_build_devicetree(prom_root_node);

Maybe I'm being nitpicky here, but I would pass the ops structure into
of_pdt_build_devicetree() directly.  I don't like the implied state of
setting the ops pointer separate from parsing the tree.

> +
> + =A0 =A0 =A0 of_console_init();
> +
> + =A0 =A0 =A0 printk(KERN_INFO "PROM: Built device tree with %u bytes of =
memory.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0prom_early_allocated);

pr_info()

> +}
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 1678dbc..c8a4b7c 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -5,6 +5,10 @@ config OF_FLATTREE
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0depends on OF
>
> +config OF_PROMTREE
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on OF
> +

I can tell from the context here you're working from an older tree.
Please rebase onto Linus' current top-of-tree.  :-)  A bunch of OF
related patches have been merged for 2.6.36 that will conflict with
this patch.

> =A0config OF_DYNAMIC
> =A0 =A0 =A0 =A0def_bool y
> =A0 =A0 =A0 =A0depends on OF && PPC_OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index f232cc9..54e8517 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -1,5 +1,6 @@
> =A0obj-y =3D base.o
> =A0obj-$(CONFIG_OF_FLATTREE) +=3D fdt.o
> +obj-$(CONFIG_OF_PROMTREE) +=3D pdt.o
> =A0obj-$(CONFIG_OF_DEVICE) +=3D device.o platform.o
> =A0obj-$(CONFIG_OF_GPIO) =A0 +=3D gpio.o
> =A0obj-$(CONFIG_OF_I2C) =A0 +=3D of_i2c.o
> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> index 61d9477..22f46fb 100644
> --- a/drivers/of/pdt.c
> +++ b/drivers/of/pdt.c
> @@ -1,5 +1,4 @@
> -/* prom_common.c: OF device tree support common code.
> - *
> +/*

You should still retain a one-line description of what this file is for.

> =A0* Paul Mackerras =A0 =A0 =A0August 1996.
> =A0* Copyright (C) 1996-2005 Paul Mackerras.
> =A0*
> @@ -7,6 +6,7 @@
> =A0* =A0 =A0{engebret|bergner}@us.ibm.com
> =A0*
> =A0* =A0Adapted for sparc by David S. Miller davem@davemloft.net
> + * =A0Adapted for multiple architectures by Andres Salomon <dilinger@que=
ued.net>
> =A0*
> =A0* =A0 =A0 =A0This program is free software; you can redistribute it an=
d/or
> =A0* =A0 =A0 =A0modify it under the terms of the GNU General Public Licen=
se
> @@ -20,13 +20,44 @@
> =A0#include <linux/mutex.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/of.h>
> +#include <linux/of_pdt.h>
> =A0#include <asm/prom.h>
> -#include <asm/oplib.h>
> -#include <asm/leon.h>
>
> -void (*prom_build_more)(struct device_node *dp, struct device_node ***ne=
xtp);
> +void __initdata (*prom_build_more)(struct device_node *dp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node ***nextp);
> +
> +static struct of_pdt_ops prom_ops __initdata;

Why a full copy of the structure instead of a pointer?

> +
> +#if defined(CONFIG_SPARC)
> +static unsigned int prom_unique_id __initdata;
> +
> +#define inc_unique_id(p) do { \
> + =A0 =A0 =A0 (p)->unique_id =3D prom_unique_id++; \
> +} while (0)

Use a static inline.  C code is preferred over preprocessor code.
Also preserver the namespace and use the of_pdt_ prefix (that goes for
all the new functions here in this file).

> +
> +static inline const char *fetch_node_name(struct device_node *dp)
> +{
> + =A0 =A0 =A0 return dp->path_component_name;
> +}
> +
> +#else
> +
> +static inline void inc_unique_id(void *p)
> +{
> + =A0 =A0 =A0 /* unused on non-SPARC architectures */
> +}
> +
> +static inline const char *fetch_node_name(struct device_node *dp)
> +{
> + =A0 =A0 =A0 return dp->name;
> +}

It would be nice to rationalize the differences between how sparc and
powerpc use the ->name/->path_component_name fields; but I haven't
investigated what the differences are.

> +
> +static inline void irq_trans_init(struct device_node *dp)
> +{
> + =A0 =A0 =A0 /* unused on non-SPARC architectures */
> +}

For empty statics like this; I'm fine with this more concise form:

+static inline void inc_unique_id(void *p) { }
+static inline void irq_trans_init(struct device_node *dp) { }

(again, add the of_pdt_ prefix)

>
> -unsigned int prom_unique_id;
> +#endif /* !CONFIG_SPARC */
>
> =A0static struct property * __init build_one_prop(phandle node, char *pre=
v,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 char *special_name,
> @@ -35,7 +66,6 @@ static struct property * __init build_one_prop(phandle =
node, char *prev,
> =A0{
> =A0 =A0 =A0 =A0static struct property *tmp =3D NULL;
> =A0 =A0 =A0 =A0struct property *p;
> - =A0 =A0 =A0 const char *name;
>
> =A0 =A0 =A0 =A0if (tmp) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D tmp;
> @@ -43,7 +73,7 @@ static struct property * __init build_one_prop(phandle =
node, char *prev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D NULL;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D prom_early_alloc(sizeof(struct prope=
rty) + 32);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->unique_id =3D prom_unique_id++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 inc_unique_id(p);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0p->name =3D (char *) (p + 1);
> @@ -53,27 +83,24 @@ static struct property * __init build_one_prop(phandl=
e node, char *prev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->value =3D prom_early_alloc(special_len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(p->value, special_val, special_len);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev =3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D prom_firstprop(nod=
e, p->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D prom_nextprop(node=
, prev, p->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!name || strlen(name) =3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev =3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D prom_ops.firstprop(=
node, p->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D prom_ops.nextprop(n=
ode, prev, p->name);

As mentioned earlier, this is better with a single .nextprop() hook
that behaves differently when a NULL prev pointer is passed.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D p;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> -#ifdef CONFIG_SPARC32
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(p->name, name);
> -#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D prom_getproplen(node, p->name=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D prom_ops.getproplen(node, p->=
name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->length <=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->length =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int len;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->value =3D prom_early_al=
loc(p->length + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_getproperty(no=
de, p->name, p->value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_ops.getpropert=
y(node, p->name, p->value,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 p->length);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (len <=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->length =
=3D 0;
> @@ -106,10 +133,10 @@ static char * __init get_one_property(phandle node,=
 const char *name)
> =A0 =A0 =A0 =A0char *buf =3D "<NULL>";
> =A0 =A0 =A0 =A0int len;
>
> - =A0 =A0 =A0 len =3D prom_getproplen(node, name);
> + =A0 =A0 =A0 len =3D prom_ops.getproplen(node, name);
> =A0 =A0 =A0 =A0if (len > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf =3D prom_early_alloc(len);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_getproperty(node, name, buf, l=
en);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_ops.getproperty(node, name, bu=
f, len);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return buf;
> @@ -124,7 +151,7 @@ static struct device_node * __init prom_create_node(p=
handle node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> =A0 =A0 =A0 =A0dp =3D prom_early_alloc(sizeof(*dp));
> - =A0 =A0 =A0 dp->unique_id =3D prom_unique_id++;
> + =A0 =A0 =A0 inc_unique_id(dp);
> =A0 =A0 =A0 =A0dp->parent =3D parent;
>
> =A0 =A0 =A0 =A0kref_init(&dp->kref);
> @@ -140,13 +167,13 @@ static struct device_node * __init prom_create_node=
(phandle node,
> =A0 =A0 =A0 =A0return dp;
> =A0}
>
> -char * __init build_full_name(struct device_node *dp)
> +static char * __init build_full_name(struct device_node *dp)
> =A0{
> =A0 =A0 =A0 =A0int len, ourlen, plen;
> =A0 =A0 =A0 =A0char *n;
>
> =A0 =A0 =A0 =A0plen =3D strlen(dp->parent->full_name);
> - =A0 =A0 =A0 ourlen =3D strlen(dp->path_component_name);
> + =A0 =A0 =A0 ourlen =3D strlen(fetch_node_name(dp));
> =A0 =A0 =A0 =A0len =3D ourlen + plen + 2;
>
> =A0 =A0 =A0 =A0n =3D prom_early_alloc(len);
> @@ -155,7 +182,7 @@ char * __init build_full_name(struct device_node *dp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(n + plen, "/");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0plen++;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 strcpy(n + plen, dp->path_component_name);
> + =A0 =A0 =A0 strcpy(n + plen, fetch_node_name(dp));
>
> =A0 =A0 =A0 =A0return n;
> =A0}
> @@ -182,36 +209,39 @@ static struct device_node * __init prom_build_tree(=
struct device_node *parent,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*(*nextp) =3D dp;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*nextp =3D &dp->allnext;
>
> +#if defined(CONFIG_SPARC)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dp->path_component_name =3D build_path_com=
ponent(dp);
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dp->full_name =3D build_full_name(dp);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->child =3D prom_build_tree(dp, prom_getc=
hild(node), nextp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->child =3D prom_build_tree(dp, prom_ops.=
getchild(node), nextp);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prom_build_more)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prom_build_more(dp, nextp);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D prom_getsibling(node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D prom_ops.getsibling(node);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -void __init prom_build_devicetree(void)
> +void __init of_pdt_build_devicetree(int root_node)
> =A0{
> =A0 =A0 =A0 =A0struct device_node **nextp;
>
> - =A0 =A0 =A0 allnodes =3D prom_create_node(prom_root_node, NULL);
> + =A0 =A0 =A0 allnodes =3D prom_create_node(root_node, NULL);
> =A0 =A0 =A0 =A0allnodes->path_component_name =3D "";
> =A0 =A0 =A0 =A0allnodes->full_name =3D "/";
>
> =A0 =A0 =A0 =A0nextp =3D &allnodes->allnext;
> =A0 =A0 =A0 =A0allnodes->child =3D prom_build_tree(allnodes,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_getchild(allnodes->pha=
ndle),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_ops.getchild(allnodes-=
>phandle),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nextp);
> +}
>
> - =A0 =A0 =A0 of_console_init();
> +void __init of_pdt_set_ops(struct of_pdt_ops *ops)
> +{
> + =A0 =A0 =A0 BUG_ON(!ops);
>
> - =A0 =A0 =A0 printk("PROM: Built device tree with %u bytes of memory.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0prom_early_allocated);
> + =A0 =A0 =A0 prom_ops =3D *ops;

As mentioned above, why is the structure copied instead of just
storing the pointer.

> =A0}
> -
> diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
> new file mode 100644
> index 0000000..1324ba5
> --- /dev/null
> +++ b/include/linux/of_pdt.h
> @@ -0,0 +1,42 @@
> +/*
> + * Definitions for building a device tree by calling into the
> + * Open Firmware PROM.
> + *
> + * Copyright (C) 2010 =A0Andres Salomon <dilinger@queued.net>
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
> +extern void *prom_early_alloc(unsigned long size);
> +
> +/* overridable operations for calling into the PROM */
> +struct of_pdt_ops {
> + =A0 =A0 =A0 /* buffers passed should be 32 bytes; return 0 on success */
> + =A0 =A0 =A0 int (*firstprop)(phandle node, char *buf);
> + =A0 =A0 =A0 int (*nextprop)(phandle node, const char *prev, char *buf);
> +
> + =A0 =A0 =A0 /* for both functions, return proplen on success; -1 on err=
or */
> + =A0 =A0 =A0 int (*getproplen)(phandle node, const char *prop);
> + =A0 =A0 =A0 int (*getproperty)(phandle node, const char *prop, char *bu=
f,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int bufsize);
> +
> + =A0 =A0 =A0 /* phandles are 0 if no child or sibling exists */
> + =A0 =A0 =A0 phandle (*getchild)(phandle parent);
> + =A0 =A0 =A0 phandle (*getsibling)(phandle node);
> +};
> +
> +extern void of_pdt_set_ops(struct of_pdt_ops *ops);
> +
> +/* for building the device tree */
> +extern void of_pdt_build_devicetree(int root_node);
> +
> +extern void (*prom_build_more)(struct device_node *dp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node ***nextp);
> +
> +#endif /* _LINUX_OF_PDT_H */
> --
> 1.5.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
