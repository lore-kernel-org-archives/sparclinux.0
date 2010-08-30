From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 30 Aug 2010 18:14:57 +0000
Subject: Re: [PATCH 9/9] x86: OLPC: add OLPC device-tree support
Message-Id: <AANLkTi=EMkZLiAG7-ni8_7K=qtAriv=AfSUZ58661jNY@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100829235100.6dcedcb8@debxo> <20100830000751.2b845d05@debxo>
In-Reply-To: <20100830000751.2b845d05@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

On Sun, Aug 29, 2010 at 10:07 PM, Andres Salomon <dilinger@queued.net> wrot=
e:
>
> Make use of PROC_DEVICETREE to export the tree, and sparc's PROMTREE code=
 to
> call into OLPC's Open Firmware to build the tree.
>
> This also adds an init hook to proc_device_tree_init so that we can ensure
> the device tree has been built prior to the proc_root_init stuff attempti=
ng
> to populate /proc/device-tree.

I'm not clear as to why this is needed.  I would expect OLPC platform
setup code would take care of extracting the device tree well before
the kernel gets to setting up the representation in /proc/device-tree.

g.

>
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> =A0arch/x86/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0arch/x86/include/asm/olpc_ofw.h | =A0 =A04 +
> =A0arch/x86/include/asm/prom.h =A0 =A0 | =A0 =A01 +
> =A0arch/x86/kernel/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/x86/kernel/olpc_ofw.c =A0 =A0 =A0| =A0 =A08 ++
> =A0arch/x86/kernel/olpc_prom.c =A0 =A0 | =A0152 +++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/of/pdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0fs/proc/proc_devtree.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0include/linux/of_pdt.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A09 files changed, 175 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/x86/include/asm/prom.h
> =A0create mode 100644 arch/x86/kernel/olpc_prom.c
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index cea0cd9..7d4ef72 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2069,6 +2069,8 @@ config OLPC_OPENFIRMWARE
> =A0 =A0 =A0 =A0bool "Support for OLPC's Open Firmware"
> =A0 =A0 =A0 =A0depends on !X86_64 && !X86_PAE
> =A0 =A0 =A0 =A0default y if OLPC
> + =A0 =A0 =A0 select OF
> + =A0 =A0 =A0 select OF_PROMTREE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option adds support for the implementation of Ope=
n Firmware
> =A0 =A0 =A0 =A0 =A0that is used on the OLPC XO-1 Children's Machine.
> diff --git a/arch/x86/include/asm/olpc_ofw.h b/arch/x86/include/asm/olpc_=
ofw.h
> index 08fde47..13075df 100644
> --- a/arch/x86/include/asm/olpc_ofw.h
> +++ b/arch/x86/include/asm/olpc_ofw.h
> @@ -28,4 +28,8 @@ static inline void setup_olpc_ofw_pgd(void) { }
>
> =A0#endif /* !CONFIG_OLPC_OPENFIRMWARE */
>
> +#ifdef CONFIG_PROC_DEVICETREE
> +extern void olpc_prom_build_devicetree(void);
> +#endif /* CONFIG_PROC_DEVICETREE */
> +
> =A0#endif /* _ASM_X86_OLPC_OFW_H */
> diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
> new file mode 100644
> index 0000000..b4ec95f
> --- /dev/null
> +++ b/arch/x86/include/asm/prom.h
> @@ -0,0 +1 @@
> +/* dummy prom.h; here to make linux/of.h's #includes happy */
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
> index 3218aa7..6c4d243 100644
> --- a/arch/x86/kernel/olpc_ofw.c
> +++ b/arch/x86/kernel/olpc_ofw.c
> @@ -1,5 +1,7 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_pdt.h>
> =A0#include <linux/init.h>
> =A0#include <asm/page.h>
> =A0#include <asm/setup.h>
> @@ -38,6 +40,12 @@ void __init setup_olpc_ofw_pgd(void)
> =A0 =A0 =A0 =A0/* implicit optimization barrier here due to uninline func=
tion return */
>
> =A0 =A0 =A0 =A0early_iounmap(base, sizeof(olpc_ofw_pgd) * PTRS_PER_PGD);
> +
> +#ifdef CONFIG_PROC_DEVICETREE
> + =A0 =A0 =A0 /* OFW set up succesfully; use it for the device tree */
> + =A0 =A0 =A0 of_pdt_init_devicetree =3D olpc_prom_build_devicetree;
> +#endif
> +
> =A0}
>
> =A0int __olpc_ofw(const char *name, int nr_args, const void **args, int n=
r_res,
> diff --git a/arch/x86/kernel/olpc_prom.c b/arch/x86/kernel/olpc_prom.c
> new file mode 100644
> index 0000000..fb04d8a
> --- /dev/null
> +++ b/arch/x86/kernel/olpc_prom.c
> @@ -0,0 +1,152 @@
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
> + * =A0Adapted for x86/OLPC by Andres Salomon <dilinger@queued.net>
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
> +
> +static phandle __init olpc_prom_getsibling(phandle node)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node };
> + =A0 =A0 =A0 void *res[] =3D { &node };
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (olpc_ofw("peer", args, res) || node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return node;
> +}
> +
> +static phandle __init olpc_prom_getchild(phandle node)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node };
> + =A0 =A0 =A0 void *res[] =3D { &node };
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (olpc_ofw("child", args, res) || node =3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("PROM: %s: fetching child failed!\n"=
, __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return node;
> +}
> +
> +static int __init olpc_prom_getproplen(phandle node, const char *prop)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node, prop };
> + =A0 =A0 =A0 int len;
> + =A0 =A0 =A0 void *res[] =3D { &len };
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 if (olpc_ofw("getproplen", args, res)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("PROM: %s: getproplen failed!\n", __=
func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return len;
> +}
> +
> +static int __init olpc_prom_getproperty(phandle node, const char *prop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf, int bufsize)
> +{
> + =A0 =A0 =A0 int plen;
> +
> + =A0 =A0 =A0 plen =3D olpc_prom_getproplen(node, prop);
> + =A0 =A0 =A0 if (plen > bufsize || plen < 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const void *args[] =3D { (void *)node, prop=
, buf, (void *)plen };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *res[] =3D { &plen };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (olpc_ofw("getprop", args, res)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("PROM: %s: getprop f=
ailed!\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return plen;
> +}
> +
> +static int __init olpc_prom_nextprop(phandle node, const char *prev, cha=
r *buf)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node, prev, buf };
> + =A0 =A0 =A0 int success;
> + =A0 =A0 =A0 void *res[] =3D { &success };
> +
> + =A0 =A0 =A0 buf[0] =3D '\0';
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 if (olpc_ofw("nextprop", args, res) || success !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __init olpc_prom_pkg2path(phandle node, char *buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const int buflen, int *len)
> +{
> + =A0 =A0 =A0 const void *args[] =3D { (void *)node, buf, (void *)buflen =
};
> + =A0 =A0 =A0 void *res[] =3D { len };
> +
> + =A0 =A0 =A0 if (node =3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 if (olpc_ofw("package-to-path", args, res) || *len < 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +void * __init prom_early_alloc(unsigned long size)
> +{
> + =A0 =A0 =A0 /* this is called late enough that we can alloc normally */
> + =A0 =A0 =A0 return kzalloc(size, GFP_KERNEL);
> +}
> +
> +static struct of_pdt_ops prom_olpc_ops __initdata =3D {
> + =A0 =A0 =A0 .nextprop =3D olpc_prom_nextprop,
> + =A0 =A0 =A0 .getproplen =3D olpc_prom_getproplen,
> + =A0 =A0 =A0 .getproperty =3D olpc_prom_getproperty,
> + =A0 =A0 =A0 .getchild =3D olpc_prom_getchild,
> + =A0 =A0 =A0 .getsibling =3D olpc_prom_getsibling,
> + =A0 =A0 =A0 .pkg2path =3D olpc_prom_pkg2path,
> +};
> +
> +void __init olpc_prom_build_devicetree(void)
> +{
> + =A0 =A0 =A0 phandle root;
> +
> + =A0 =A0 =A0 root =3D olpc_prom_getsibling(0);
> + =A0 =A0 =A0 if (root < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("PROM: unable to get root node from =
OFW!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 of_pdt_build_devicetree(root, &prom_olpc_ops);
> +}
> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> index 28295d0..07e3daa 100644
> --- a/drivers/of/pdt.c
> +++ b/drivers/of/pdt.c
> @@ -29,6 +29,8 @@ static struct of_pdt_ops *of_pdt_prom_ops __initdata;
> =A0void __initdata (*of_pdt_build_more)(struct device_node *dp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_node ***nextp);
>
> +void __initdata (*of_pdt_init_devicetree)(void);
> +
> =A0#if defined(CONFIG_SPARC)
> =A0unsigned int of_pdt_unique_id __initdata;
>
> diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
> index d9396a4..9779039 100644
> --- a/fs/proc/proc_devtree.c
> +++ b/fs/proc/proc_devtree.c
> @@ -11,6 +11,7 @@
> =A0#include <linux/stat.h>
> =A0#include <linux/string.h>
> =A0#include <linux/of.h>
> +#include <linux/of_pdt.h>
> =A0#include <linux/module.h>
> =A0#include <linux/slab.h>
> =A0#include <asm/prom.h>
> @@ -228,6 +229,9 @@ void __init proc_device_tree_init(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *root;
>
> + =A0 =A0 =A0 if (of_pdt_init_devicetree)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_pdt_init_devicetree();
> +
> =A0 =A0 =A0 =A0proc_device_tree =3D proc_mkdir("device-tree", NULL);
> =A0 =A0 =A0 =A0if (proc_device_tree =3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
> index 9945e58..b4bd0ee 100644
> --- a/include/linux/of_pdt.h
> +++ b/include/linux/of_pdt.h
> @@ -38,6 +38,7 @@ extern void *prom_early_alloc(unsigned long size);
>
> =A0/* for building the device tree */
> =A0extern void of_pdt_build_devicetree(phandle root_node, struct of_pdt_o=
ps *ops);
> +extern void (*of_pdt_init_devicetree)(void);
>
> =A0extern void (*of_pdt_build_more)(struct device_node *dp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_node ***nextp);
> --
> 1.5.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
