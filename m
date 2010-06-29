From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 29 Jun 2010 08:12:36 +0000
Subject: Re: [PATCH 4/4] x86: OLPC: add OLPC device-tree support
Message-Id: <AANLkTinUy_FGuN9DiF5KtMCsqYUbByfS6g2Mdw0ATvtQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220058.19e8f143@debian>
In-Reply-To: <20100628220058.19e8f143@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net

Hi Andres, comments below....

On Mon, Jun 28, 2010 at 7:00 PM, Andres Salomon <dilinger@queued.net> wrote:
>
> Make use of PROC_DEVICETREE to export the tree, and sparc's PROMTREE code=
 to
> call into OLPC's Open Firmware to build the tree.
>
> (Yes, I know this leaks memory by simply using kmalloc)
>
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> =A0arch/x86/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++
> =A0arch/x86/include/asm/olpc_prom.h | =A0 42 +++++++++++
> =A0arch/x86/include/asm/prom.h =A0 =A0 =A0| =A0 =A05 ++
> =A0arch/x86/kernel/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/x86/kernel/olpc_ofw.c =A0 =A0 =A0 | =A0 13 ++++
> =A0arch/x86/kernel/olpc_prom.c =A0 =A0 =A0| =A0148 ++++++++++++++++++++++=
++++++++++++++++
> =A0fs/proc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A07 files changed, 215 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/x86/include/asm/olpc_prom.h
> =A0create mode 100644 arch/x86/include/asm/prom.h
> =A0create mode 100644 arch/x86/kernel/olpc_prom.c
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 71c194d..7aea004 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2071,6 +2071,11 @@ config OLPC_OPENFIRMWARE
> =A0 =A0 =A0 =A0 =A0that is used on the OLPC XO-1 Children's Machine.
> =A0 =A0 =A0 =A0 =A0If unsure, say N here.
>
> +config OF
> + =A0 =A0 =A0 def_bool y
> + =A0 =A0 =A0 depends on OLPC_OPENFIRMWARE
> + =A0 =A0 =A0 select OF_PROMTREE
> +

This hunk will need to be respun on top of Stephen's CONFIG_OF change.
 It's currently in my test-devicetree branch on
git://git.secretlab.ca/git/linux-2.6

> =A0endif # X86_32
>
> =A0config K8_NB
> diff --git a/arch/x86/include/asm/olpc_prom.h b/arch/x86/include/asm/olpc=
_prom.h
> new file mode 100644
> index 0000000..96cdcee
> --- /dev/null
> +++ b/arch/x86/include/asm/olpc_prom.h
> @@ -0,0 +1,42 @@
> +#include <linux/of.h> =A0/* linux/of.h gets to determine #include orderi=
ng */
> +/*
> + * Definitions for talking to the Open Firmware PROM on
> + * Power Macintosh computers.
> + *
> + * Copyright (C) 1996-2005 Paul Mackerras.
> + *
> + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
> + * Updates for SPARC by David S. Miller
> + * Updates for x86/OLPC by Andres Salomon
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _X86_PROM_OLPC_H
> +#define _X86_PROM_OLPC_H
> +#ifdef __KERNEL__
> +
> +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 2
> +#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1

Do you really need to override these from the default?

> +#define of_compat_cmp(s1, s2, l) =A0 =A0 =A0 strncmp((s1), (s2), (l))
> +#define of_prop_cmp(s1, s2) =A0 =A0 =A0 =A0 =A0 =A0strcasecmp((s1), (s2))
> +#define of_node_cmp(s1, s2) =A0 =A0 =A0 =A0 =A0 =A0strcmp((s1), (s2))

Ditto here?

> +extern void prom_build_devicetree(void);
> +
> +extern void *prom_early_alloc(unsigned long size);
> +
> +extern char *prom_firstprop(phandle node, char *buf);
> +extern char *prom_nextprop(phandle node, const char *prev, char *buf);
> +extern int prom_getproplen(phandle node, const char *prop);
> +extern int prom_getproperty(phandle node, const char *prop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *buffer, in=
t bufsize);
> +extern phandle prom_getchild(phandle node);
> +extern phandle prom_getsibling(phandle node);
> +
> +#endif /* __KERNEL__ */
> +#endif /* _X86_PROM_OLPC_H */
> diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
> new file mode 100644
> index 0000000..7b561b2
> --- /dev/null
> +++ b/arch/x86/include/asm/prom.h
> @@ -0,0 +1,5 @@
> +#ifdef CONFIG_OLPC_OPENFIRMWARE
> +# include <asm/olpc_prom.h>
> +#else
> +# error "No OFW prom defined for x86!"
> +#endif

Personally, I wouldn't bother with the header file redirection.

> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 0925676..3d7e535 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -105,6 +105,7 @@ scx200-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D =
scx200_32.o
>
> =A0obj-$(CONFIG_OLPC) =A0 =A0 =A0 =A0 =A0 =A0 +=3D olpc.o
> =A0obj-$(CONFIG_OLPC_OPENFIRMWARE) =A0 =A0 =A0 =A0+=3D olpc_ofw.o
> +obj-$(CONFIG_PROC_DEVICETREE) =A0+=3D olpc_prom.o
> =A0obj-$(CONFIG_X86_MRST) =A0 =A0 =A0 =A0 +=3D mrst.o
>
> =A0microcode-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=
=3D microcode_core.o
> diff --git a/arch/x86/kernel/olpc_ofw.c b/arch/x86/kernel/olpc_ofw.c
> index 3e13a4b..8838edb 100644
> --- a/arch/x86/kernel/olpc_ofw.c
> +++ b/arch/x86/kernel/olpc_ofw.c
> @@ -6,6 +6,7 @@
> =A0#include <asm/io.h>
> =A0#include <asm/pgtable.h>
> =A0#include <asm/olpc_ofw.h>
> +#include <asm/prom.h>
>
> =A0/* address of OFW callback interface; will be NULL if OFW isn't found =
*/
> =A0static int (*olpc_ofw_cif)(int *);
> @@ -103,3 +104,15 @@ void __init olpc_ofw_detect(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long)olpc_ofw_ci=
f, (-start) >> 20);
> =A0 =A0 =A0 =A0reserve_top_address(-start);
> =A0}
> +
> +#ifdef CONFIG_PROC_DEVICETREE
> +static int __init olpc_ofw_build_devicetree(void)
> +{
> + =A0 =A0 =A0 /* initialize the device-tree that proc uses */
> + =A0 =A0 =A0 if (olpc_ofw_cif)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_build_devicetree();
> +
> + =A0 =A0 =A0 return 0;
> +}
> +arch_initcall(olpc_ofw_build_devicetree);
> +#endif /* CONFIG_PROC_DEVICETREE */
> diff --git a/arch/x86/kernel/olpc_prom.c b/arch/x86/kernel/olpc_prom.c
> new file mode 100644
> index 0000000..1128f3f
> --- /dev/null
> +++ b/arch/x86/kernel/olpc_prom.c
> @@ -0,0 +1,148 @@
> +/*
> + * olpc_prom.c: OLPC-specific OFW device tree support code.
> + *
> + * Paul Mackerras =A0 =A0 =A0August 1996.
> + * Copyright (C) 1996-2005 Paul Mackerras.
> + *
> + * =A0Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
> + * =A0 =A0{engebret|bergner}@us.ibm.com
> + *
> + * =A0Adapted for sparc by David S. Miller davem@davemloft.net
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
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_pdt.h>
> +#include <asm/olpc_ofw.h>
> +#include <asm/prom.h>
> +
> +phandle prom_getsibling(phandle node)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node };
> + =A0 =A0 =A0 void *res[] =3D { &node };
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 if (olpc_ofw("peer", args, res) || node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 return node;
> +}
> +
> +phandle prom_getchild(phandle node)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node };
> + =A0 =A0 =A0 void *res[] =3D { &node };
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (olpc_ofw("child", args, res) || node =3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PROM: %s: fetching child f=
ailed!\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return node;
> +}
> +
> +int prom_getproplen(phandle node, const char *prop)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node, prop };
> + =A0 =A0 =A0 int len;
> + =A0 =A0 =A0 void *res[] =3D { &len };
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (olpc_ofw("getproplen", args, res)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PROM: %s: getproplen faile=
d!\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return len;
> +}
> +
> +int prom_getproperty(phandle node, const char *prop, char *buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int bufsize)
> +{
> + =A0 =A0 =A0 int plen;
> +
> + =A0 =A0 =A0 plen =3D prom_getproplen(node, prop);
> + =A0 =A0 =A0 if (plen > bufsize || plen < 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const void *args[] =3D { (void *)node, prop=
, buf, (void *)plen };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *res[] =3D { &plen };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (olpc_ofw("getprop", args, res)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PROM: %s: =
getprop failed!\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 //((unsigned char *)buf)[plen] =3D '\0';
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +char *prom_firstprop(phandle node, char *buf)
> +{
> + =A0 =A0 =A0 buf[0] =3D '\0';
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 return prom_nextprop(node, "", buf);
> +}
> +
> +char *prom_nextprop(phandle node, const char *prev, char *buf)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node, prev, buf };
> + =A0 =A0 =A0 int success;
> + =A0 =A0 =A0 void *res[] =3D { &success };
> +
> + =A0 =A0 =A0 buf[0] =3D '\0';
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 if (olpc_ofw("nextprop", args, res) || success !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PROM: %s: nextprop failed!=
\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return buf;
> +}
> +
> +void * __init prom_early_alloc(unsigned long size)
> +{
> + =A0 =A0 =A0 /* unlike SPARC, we don't bother keeping track of prom memo=
ry */
> + =A0 =A0 =A0 return kzalloc(size, GFP_KERNEL);
> +}
> +
> +void __init prom_build_devicetree(void)
> +{
> + =A0 =A0 =A0 struct device_node **nextp;
> + =A0 =A0 =A0 phandle root;
> +
> + =A0 =A0 =A0 root =3D prom_getsibling(0);
> + =A0 =A0 =A0 if (root < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PROM: unable to get root n=
ode from OFW!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 allnodes =3D prom_create_node(root, NULL);
> + =A0 =A0 =A0 allnodes->full_name =3D "/";
> +
> + =A0 =A0 =A0 nextp =3D &allnodes->allnext;
> + =A0 =A0 =A0 allnodes->child =3D prom_build_tree(allnodes,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_getchild(allnodes->pha=
ndle), &nextp);
> +}
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 858a859..86f67ce 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -41,7 +41,7 @@ config PROC_VMCORE
>
> =A0config PROC_DEVICETREE
> =A0 =A0 =A0 =A0bool "Support for device tree in /proc"
> - =A0 =A0 =A0 depends on PROC_FS && (PPC || MICROBLAZE)
> + =A0 =A0 =A0 depends on PROC_FS && (PPC || MICROBLAZE || OLPC_OPENFIRMWA=
RE)

This change should no longer be necessary with the way I've modified patch =
3/4.

Cheers,
g.
