From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 09 Aug 2010 05:15:56 +0000
Subject: Re: [PATCH 1/3] sparc: break out some PROM device-tree building code
Message-Id: <AANLkTikJf0ZzgXv3nVBMvXVWpfaGuB-qeUsEYZHRuJMF@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100808231030.1d555250@dev.queued.net>
In-Reply-To: <20100808231030.1d555250@dev.queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

On Sun, Aug 8, 2010 at 9:10 PM, Andres Salomon <dilinger@queued.net> wrote:
>
> Transitioning into making this useful for architectures other than sparc.
>
> Signed-off-by: Andres Salomon <dilinger@queued.net>

I assume this is just a verbatim copy.  If so, looks fine to me, but I
won't pick it up yet since you'll be respinning patches 2 and 3
anyway.

g.

> ---
> =A0arch/sparc/kernel/prom_common.c | =A0190 +----------------------------=
------
> =A0drivers/of/pdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0217 +++++++++++++=
++++++++++++++++++++++++++
> =A02 files changed, 218 insertions(+), 189 deletions(-)
> =A0create mode 100644 drivers/of/pdt.c
>
> diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_com=
mon.c
> index 40123a6..7b454f6 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c
> @@ -26,8 +26,6 @@
>
> =A0#include "prom.h"
>
> -void (*prom_build_more)(struct device_node *dp, struct device_node ***ne=
xtp);
> -
> =A0struct device_node *of_console_device;
> =A0EXPORT_SYMBOL(of_console_device);
>
> @@ -119,192 +117,6 @@ int of_find_in_proplist(const char *list, const cha=
r *match, int len)
> =A0}
> =A0EXPORT_SYMBOL(of_find_in_proplist);
>
> -unsigned int prom_unique_id;
> -
> -static struct property * __init build_one_prop(phandle node, char *prev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0char *special_name,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0void *special_val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int special_len)
> -{
> - =A0 =A0 =A0 static struct property *tmp =3D NULL;
> - =A0 =A0 =A0 struct property *p;
> - =A0 =A0 =A0 const char *name;
> -
> - =A0 =A0 =A0 if (tmp) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D tmp;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(p, 0, sizeof(*p) + 32);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D NULL;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D prom_early_alloc(sizeof(struct proper=
ty) + 32);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->unique_id =3D prom_unique_id++;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 p->name =3D (char *) (p + 1);
> - =A0 =A0 =A0 if (special_name) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(p->name, special_name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D special_len;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->value =3D prom_early_alloc(special_len);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(p->value, special_val, special_len);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev =3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D prom_firstprop(nod=
e, p->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D prom_nextprop(node=
, prev, p->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!name || strlen(name) =3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D p;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -#ifdef CONFIG_SPARC32
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(p->name, name);
> -#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D prom_getproplen(node, p->name=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->length <=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->value =3D prom_early_all=
oc(p->length + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_getproperty(no=
de, p->name, p->value,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0p->length);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len <=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->length =
=3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned char *)p->value)=
[p->length] =3D '\0';
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return p;
> -}
> -
> -static struct property * __init build_prop_list(phandle node)
> -{
> - =A0 =A0 =A0 struct property *head, *tail;
> -
> - =A0 =A0 =A0 head =3D tail =3D build_one_prop(node, NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
".node", &node, sizeof(node));
> -
> - =A0 =A0 =A0 tail->next =3D build_one_prop(node, NULL, NULL, NULL, 0);
> - =A0 =A0 =A0 tail =3D tail->next;
> - =A0 =A0 =A0 while(tail) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tail->next =3D build_one_prop(node, tail->n=
ame,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 NULL, NULL, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tail =3D tail->next;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return head;
> -}
> -
> -static char * __init get_one_property(phandle node, const char *name)
> -{
> - =A0 =A0 =A0 char *buf =3D "<NULL>";
> - =A0 =A0 =A0 int len;
> -
> - =A0 =A0 =A0 len =3D prom_getproplen(node, name);
> - =A0 =A0 =A0 if (len > 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf =3D prom_early_alloc(len);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D prom_getproperty(node, name, buf, l=
en);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return buf;
> -}
> -
> -static struct device_node * __init prom_create_node(phandle node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *parent)
> -{
> - =A0 =A0 =A0 struct device_node *dp;
> -
> - =A0 =A0 =A0 if (!node)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> -
> - =A0 =A0 =A0 dp =3D prom_early_alloc(sizeof(*dp));
> - =A0 =A0 =A0 dp->unique_id =3D prom_unique_id++;
> - =A0 =A0 =A0 dp->parent =3D parent;
> -
> - =A0 =A0 =A0 kref_init(&dp->kref);
> -
> - =A0 =A0 =A0 dp->name =3D get_one_property(node, "name");
> - =A0 =A0 =A0 dp->type =3D get_one_property(node, "device_type");
> - =A0 =A0 =A0 dp->phandle =3D node;
> -
> - =A0 =A0 =A0 dp->properties =3D build_prop_list(node);
> -
> - =A0 =A0 =A0 irq_trans_init(dp);
> -
> - =A0 =A0 =A0 return dp;
> -}
> -
> -char * __init build_full_name(struct device_node *dp)
> -{
> - =A0 =A0 =A0 int len, ourlen, plen;
> - =A0 =A0 =A0 char *n;
> -
> - =A0 =A0 =A0 plen =3D strlen(dp->parent->full_name);
> - =A0 =A0 =A0 ourlen =3D strlen(dp->path_component_name);
> - =A0 =A0 =A0 len =3D ourlen + plen + 2;
> -
> - =A0 =A0 =A0 n =3D prom_early_alloc(len);
> - =A0 =A0 =A0 strcpy(n, dp->parent->full_name);
> - =A0 =A0 =A0 if (!of_is_root_node(dp->parent)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(n + plen, "/");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 plen++;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 strcpy(n + plen, dp->path_component_name);
> -
> - =A0 =A0 =A0 return n;
> -}
> -
> -static struct device_node * __init prom_build_tree(struct device_node *p=
arent,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0phandle node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_node ***nextp)
> -{
> - =A0 =A0 =A0 struct device_node *ret =3D NULL, *prev_sibling =3D NULL;
> - =A0 =A0 =A0 struct device_node *dp;
> -
> - =A0 =A0 =A0 while (1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp =3D prom_create_node(node, parent);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dp)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev_sibling)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_sibling->sibling =3D d=
p;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dp;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_sibling =3D dp;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(*nextp) =3D dp;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *nextp =3D &dp->allnext;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->path_component_name =3D build_path_comp=
onent(dp);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->full_name =3D build_full_name(dp);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->child =3D prom_build_tree(dp, prom_getc=
hild(node), nextp);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prom_build_more)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_build_more(dp, nextp);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D prom_getsibling(node);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return ret;
> -}
> -
> =A0unsigned int prom_early_allocated __initdata;
>
> -void __init prom_build_devicetree(void)
> -{
> - =A0 =A0 =A0 struct device_node **nextp;
> -
> - =A0 =A0 =A0 allnodes =3D prom_create_node(prom_root_node, NULL);
> - =A0 =A0 =A0 allnodes->path_component_name =3D "";
> - =A0 =A0 =A0 allnodes->full_name =3D "/";
> -
> - =A0 =A0 =A0 nextp =3D &allnodes->allnext;
> - =A0 =A0 =A0 allnodes->child =3D prom_build_tree(allnodes,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 prom_getchild(allnodes->phandle),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &nextp);
> - =A0 =A0 =A0 of_console_init();
> -
> - =A0 =A0 =A0 printk("PROM: Built device tree with %u bytes of memory.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0prom_early_allocated);
> -}
> +#include "../../../drivers/of/pdt.c"
> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> new file mode 100644
> index 0000000..61d9477
> --- /dev/null
> +++ b/drivers/of/pdt.c
> @@ -0,0 +1,217 @@
> +/* prom_common.c: OF device tree support common code.
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
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <asm/prom.h>
> +#include <asm/oplib.h>
> +#include <asm/leon.h>
> +
> +void (*prom_build_more)(struct device_node *dp, struct device_node ***ne=
xtp);
> +
> +unsigned int prom_unique_id;
> +
> +static struct property * __init build_one_prop(phandle node, char *prev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0char *special_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0void *special_val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int special_len)
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->unique_id =3D prom_unique_id++;
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
> +static struct device_node * __init prom_create_node(phandle node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *parent)
> +{
> + =A0 =A0 =A0 struct device_node *dp;
> +
> + =A0 =A0 =A0 if (!node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 dp =3D prom_early_alloc(sizeof(*dp));
> + =A0 =A0 =A0 dp->unique_id =3D prom_unique_id++;
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
> +char * __init build_full_name(struct device_node *dp)
> +{
> + =A0 =A0 =A0 int len, ourlen, plen;
> + =A0 =A0 =A0 char *n;
> +
> + =A0 =A0 =A0 plen =3D strlen(dp->parent->full_name);
> + =A0 =A0 =A0 ourlen =3D strlen(dp->path_component_name);
> + =A0 =A0 =A0 len =3D ourlen + plen + 2;
> +
> + =A0 =A0 =A0 n =3D prom_early_alloc(len);
> + =A0 =A0 =A0 strcpy(n, dp->parent->full_name);
> + =A0 =A0 =A0 if (!of_is_root_node(dp->parent)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(n + plen, "/");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plen++;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 strcpy(n + plen, dp->path_component_name);
> +
> + =A0 =A0 =A0 return n;
> +}
> +
> +static struct device_node * __init prom_build_tree(struct device_node *p=
arent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0phandle node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_node ***nextp)
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->path_component_name =3D build_path_comp=
onent(dp);
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
> +
> +void __init prom_build_devicetree(void)
> +{
> + =A0 =A0 =A0 struct device_node **nextp;
> +
> + =A0 =A0 =A0 allnodes =3D prom_create_node(prom_root_node, NULL);
> + =A0 =A0 =A0 allnodes->path_component_name =3D "";
> + =A0 =A0 =A0 allnodes->full_name =3D "/";
> +
> + =A0 =A0 =A0 nextp =3D &allnodes->allnext;
> + =A0 =A0 =A0 allnodes->child =3D prom_build_tree(allnodes,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_getchild(allnodes->pha=
ndle),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &nextp);
> +
> + =A0 =A0 =A0 of_console_init();
> +
> + =A0 =A0 =A0 printk("PROM: Built device tree with %u bytes of memory.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0prom_early_allocated);
> +}
> +
> --
> 1.5.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
