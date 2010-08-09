From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 09 Aug 2010 05:14:01 +0000
Subject: Re: [PATCH 3/3] sparc: add pdt/of_pdt namespace to pdt code
Message-Id: <AANLkTinSLVAqGZgv+i5eRai4up3X0oR6nPWyQsgz48H+@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100808231142.61da6c64@dev.queued.net>
In-Reply-To: <20100808231142.61da6c64@dev.queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

On Sun, Aug 8, 2010 at 9:11 PM, Andres Salomon <dilinger@queued.net> wrote:
>
> For symbols still lacking namespace qualifiers, add of_pdt to non-static
> stuff and pdt_ to static names.

Don't bother with 2 different prefixes.  Just use of_pdt for
everything.  the static stuff just won't appear in the global
namespace.

>
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> =A0arch/sparc/kernel/leon_kernel.c | =A0 =A02 +-
> =A0drivers/of/pdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 40 +++++++++++++=
++++++-------------------
> =A0include/linux/of_pdt.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A03 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_ker=
nel.c
> index 6a7b4db..2d51527 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -282,5 +282,5 @@ void __init leon_init_IRQ(void)
>
> =A0void __init leon_init(void)
> =A0{
> - =A0 =A0 =A0 prom_build_more =3D &leon_node_init;
> + =A0 =A0 =A0 of_pdt_build_more =3D &leon_node_init;
> =A0}
> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> index 22f46fb..ad31d5d 100644
> --- a/drivers/of/pdt.c
> +++ b/drivers/of/pdt.c
> @@ -23,7 +23,7 @@
> =A0#include <linux/of_pdt.h>
> =A0#include <asm/prom.h>
>
> -void __initdata (*prom_build_more)(struct device_node *dp,
> +void __initdata (*of_pdt_build_more)(struct device_node *dp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_node ***nextp);
>
> =A0static struct of_pdt_ops prom_ops __initdata;
> @@ -59,7 +59,7 @@ static inline void irq_trans_init(struct device_node *d=
p)
>
> =A0#endif /* !CONFIG_SPARC */
>
> -static struct property * __init build_one_prop(phandle node, char *prev,
> +static struct property * __init pdt_build_one_prop(phandle node, char *p=
rev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 char *special_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 void *special_val,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 int special_len)
> @@ -110,17 +110,17 @@ static struct property * __init build_one_prop(phan=
dle node, char *prev,
> =A0 =A0 =A0 =A0return p;
> =A0}
>
> -static struct property * __init build_prop_list(phandle node)
> +static struct property * __init pdt_build_prop_list(phandle node)
> =A0{
> =A0 =A0 =A0 =A0struct property *head, *tail;
>
> - =A0 =A0 =A0 head =3D tail =3D build_one_prop(node, NULL,
> + =A0 =A0 =A0 head =3D tail =3D pdt_build_one_prop(node, NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
.node", &node, sizeof(node));
>
> - =A0 =A0 =A0 tail->next =3D build_one_prop(node, NULL, NULL, NULL, 0);
> + =A0 =A0 =A0 tail->next =3D pdt_build_one_prop(node, NULL, NULL, NULL, 0=
);
> =A0 =A0 =A0 =A0tail =3D tail->next;
> =A0 =A0 =A0 =A0while(tail) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tail->next =3D build_one_prop(node, tail->n=
ame,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tail->next =3D pdt_build_one_prop(node, tai=
l->name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0NULL, NULL, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tail =3D tail->next;
> =A0 =A0 =A0 =A0}
> @@ -128,7 +128,7 @@ static struct property * __init build_prop_list(phand=
le node)
> =A0 =A0 =A0 =A0return head;
> =A0}
>
> -static char * __init get_one_property(phandle node, const char *name)
> +static char * __init pdt_get_one_property(phandle node, const char *name)
> =A0{
> =A0 =A0 =A0 =A0char *buf =3D "<NULL>";
> =A0 =A0 =A0 =A0int len;
> @@ -142,7 +142,7 @@ static char * __init get_one_property(phandle node, c=
onst char *name)
> =A0 =A0 =A0 =A0return buf;
> =A0}
>
> -static struct device_node * __init prom_create_node(phandle node,
> +static struct device_node * __init pdt_create_node(phandle node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_node *parent)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *dp;
> @@ -156,18 +156,18 @@ static struct device_node * __init prom_create_node=
(phandle node,
>
> =A0 =A0 =A0 =A0kref_init(&dp->kref);
>
> - =A0 =A0 =A0 dp->name =3D get_one_property(node, "name");
> - =A0 =A0 =A0 dp->type =3D get_one_property(node, "device_type");
> + =A0 =A0 =A0 dp->name =3D pdt_get_one_property(node, "name");
> + =A0 =A0 =A0 dp->type =3D pdt_get_one_property(node, "device_type");
> =A0 =A0 =A0 =A0dp->phandle =3D node;
>
> - =A0 =A0 =A0 dp->properties =3D build_prop_list(node);
> + =A0 =A0 =A0 dp->properties =3D pdt_build_prop_list(node);
>
> =A0 =A0 =A0 =A0irq_trans_init(dp);
>
> =A0 =A0 =A0 =A0return dp;
> =A0}
>
> -static char * __init build_full_name(struct device_node *dp)
> +static char * __init pdt_build_full_name(struct device_node *dp)
> =A0{
> =A0 =A0 =A0 =A0int len, ourlen, plen;
> =A0 =A0 =A0 =A0char *n;
> @@ -187,7 +187,7 @@ static char * __init build_full_name(struct device_no=
de *dp)
> =A0 =A0 =A0 =A0return n;
> =A0}
>
> -static struct device_node * __init prom_build_tree(struct device_node *p=
arent,
> +static struct device_node * __init pdt_build_tree(struct device_node *pa=
rent,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 phandle node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node ***nextp)
> =A0{
> @@ -195,7 +195,7 @@ static struct device_node * __init prom_build_tree(st=
ruct device_node *parent,
> =A0 =A0 =A0 =A0struct device_node *dp;
>
> =A0 =A0 =A0 =A0while (1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp =3D prom_create_node(node, parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp =3D pdt_create_node(node, parent);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!dp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -212,12 +212,12 @@ static struct device_node * __init prom_build_tree(=
struct device_node *parent,
> =A0#if defined(CONFIG_SPARC)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dp->path_component_name =3D build_path_com=
ponent(dp);
> =A0#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->full_name =3D build_full_name(dp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->full_name =3D pdt_build_full_name(dp);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->child =3D prom_build_tree(dp, prom_ops.=
getchild(node), nextp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->child =3D pdt_build_tree(dp, prom_ops.g=
etchild(node), nextp);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prom_build_more)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_build_more(dp, nextp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_pdt_build_more)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_pdt_build_more(dp, nextp=
);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node =3D prom_ops.getsibling(node);
> =A0 =A0 =A0 =A0}
> @@ -229,12 +229,12 @@ void __init of_pdt_build_devicetree(int root_node)
> =A0{
> =A0 =A0 =A0 =A0struct device_node **nextp;
>
> - =A0 =A0 =A0 allnodes =3D prom_create_node(root_node, NULL);
> + =A0 =A0 =A0 allnodes =3D pdt_create_node(root_node, NULL);
> =A0 =A0 =A0 =A0allnodes->path_component_name =3D "";
> =A0 =A0 =A0 =A0allnodes->full_name =3D "/";
>
> =A0 =A0 =A0 =A0nextp =3D &allnodes->allnext;
> - =A0 =A0 =A0 allnodes->child =3D prom_build_tree(allnodes,
> + =A0 =A0 =A0 allnodes->child =3D pdt_build_tree(allnodes,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prom_ops.getchild(allnodes=
->phandle),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nextp);
> =A0}
> diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
> index 1324ba5..ea7a17b 100644
> --- a/include/linux/of_pdt.h
> +++ b/include/linux/of_pdt.h
> @@ -36,7 +36,7 @@ extern void of_pdt_set_ops(struct of_pdt_ops *ops);
> =A0/* for building the device tree */
> =A0extern void of_pdt_build_devicetree(int root_node);
>
> -extern void (*prom_build_more)(struct device_node *dp,
> +extern void (*of_pdt_build_more)(struct device_node *dp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_node ***nextp);
>
> =A0#endif /* _LINUX_OF_PDT_H */
> --
> 1.5.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
