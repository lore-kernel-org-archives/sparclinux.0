From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 23:34:14 +0000
Subject: Re: [PATCH 5/7] Added support for AMBA bus. The device is a AMBA bus
Message-Id: <646765f40906101634m6d61bc66se94f3317761a57da@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1244629161-23939-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1244629161-23939-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, Jun 10, 2009 at 20:19, <konrad@gaisler.com> wrote:
> From: Konrad Eisele <konrad@gaisler.com>
>
> it is a child of prom node "ambapp" (AMBA plug and play).
> Two functions leon_trans_init() and leon_node_init()
> (defined in sparc/kernel/leon.c) are called in the
> prom_build_tree() path if CONFIG_SPARC_LEON is defined.
> leon_node_init() will build up the device tree using
> AMBA plug and play.
> ---
> =A0arch/sparc/kernel/of_device_32.c | =A0 45 ++++++++++++++++++++++++++++=
+++++++++-
> =A0arch/sparc/kernel/prom_32.c =A0 =A0 =A0| =A0 38 ++++++++++++++++++++++=
++++++++++
> =A0arch/sparc/kernel/prom_common.c =A0| =A0 10 +++++++-
> =A03 files changed, 90 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_devi=
ce_32.c
> index 0a83bd7..e62daa2 100644
> --- a/arch/sparc/kernel/of_device_32.c
> +++ b/arch/sparc/kernel/of_device_32.c
> @@ -125,7 +126,7 @@ static int of_out_of_range(const u32 *ad
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int of_bus_default_map(u32 *addr, const u32 *range,
> +SPARC_LEON_STATIC int of_bus_default_map(u32 *addr, const u32 *range,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int na, int ns=
, int pna)
>  {
>        u32 result[OF_MAX_ADDR_CELLS];

This is still ugly. Arguably, having it non-static wouldn't be a
problem as it is used by the leon-specific code.

I understand that you want to make this entire patch set disappear
when SPARC_LEON is unselected, but this is just making the existing
code messy.

> @@ -269,6 +270,37 @@ static unsigned long of_bus_sbus_get_fla
> =A0 =A0 =A0 =A0return IORESOURCE_MEM;
> =A0}
>
> +#ifdef CONFIG_SPARC_LEON
> +
> + /*
> + * AMBAPP bus specific translator
> + */
> +
> +int of_bus_ambapp_match(struct device_node *np)
> +{
> + =A0 =A0 =A0 return !strcmp(np->name, "ambapp");
> +}
> +
> +void of_bus_ambapp_count_cells(struct device_node *child,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int *addrc, int *sizec)
> +{
> + =A0 =A0 =A0 if (addrc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *addrc =3D 1;
> + =A0 =A0 =A0 if (sizec)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *sizec =3D 1;
> +}
> +
> +int of_bus_ambapp_map(u32 *addr, const u32 *range, int na, int ns, int p=
na)
> +{
> + =A0 =A0 =A0 return of_bus_default_map(addr, range, na, ns, pna);
> +}
> +
> +unsigned long of_bus_ambapp_get_flags(const u32 *addr, unsigned long fla=
gs)
> +{
> + =A0 =A0 =A0 return IORESOURCE_MEM;
> +}
> +
> +#endif
>
> =A0/*
> =A0* Array of bus specific translators
> @@ -293,6 +325,17 @@ static struct of_bus of_busses[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.map =3D of_bus_sbus_map,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.get_flags =3D of_bus_sbus_get_flags,
> =A0 =A0 =A0 =A0},
> +#ifdef CONFIG_SPARC_LEON
> + =A0 =A0 =A0 /* AMBA */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "ambapp",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr_prop_name =3D "reg",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .match =3D of_bus_ambapp_match,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .count_cells =3D of_bus_ambapp_count_cells,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .map =3D of_bus_ambapp_map,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .get_flags =3D of_bus_ambapp_get_flags,
> + =A0 =A0 =A0 },
> +#endif
> =A0 =A0 =A0 =A0/* Default */
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "default",
> diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
> index fe43e80..5aee484 100644
> --- a/arch/sparc/kernel/prom_32.c
> +++ b/arch/sparc/kernel/prom_32.c
> @@ -24,6 +24,7 @@ #include <linux/module.h>
>
> =A0#include <asm/prom.h>
> =A0#include <asm/oplib.h>
> +#include <asm/leon.h>
>
> =A0#include "prom.h"
>
> @@ -131,6 +132,39 @@ static void __init ebus_path_component(s
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs->which_io, regs->phys_addr);
> =A0}
>
> +#ifdef CONFIG_SPARC_LEON
> +
> +/* "name@irq,addrlo" */
> +static void __init ambapp_path_component(struct device_node *dp, char *t=
mp_buf)
> +{
> + =A0 =A0 =A0 struct amba_prom_registers *regs; unsigned int *intr;
> + =A0 =A0 =A0 unsigned int *device, *vendor;
> + =A0 =A0 =A0 struct property *prop;
> +
> + =A0 =A0 =A0 prop =3D of_find_property(dp, "reg", NULL);
> + =A0 =A0 =A0 if (!prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 regs =3D prop->value;
> + =A0 =A0 =A0 prop =3D of_find_property(dp, "interrupts", NULL);
> + =A0 =A0 =A0 if (!prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 intr =3D prop->value;
> + =A0 =A0 =A0 prop =3D of_find_property(dp, "vendor", NULL);
> + =A0 =A0 =A0 if (!prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 vendor =3D prop->value;
> + =A0 =A0 =A0 prop =3D of_find_property(dp, "device", NULL);
> + =A0 =A0 =A0 if (!prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 device =3D prop->value;
> +
> + =A0 =A0 =A0 sprintf(tmp_buf, "%s:%d:%d@%x,%x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dp->name, *vendor, *device,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *intr, regs->phys_addr);
> +}
> +
> +#endif
> +
> =A0static void __init __build_path_component(struct device_node *dp, char=
 *tmp_buf)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *parent =3D dp->parent;
> @@ -143,6 +177,10 @@ static void __init __build_path_componen
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sbus_path_component=
(dp, tmp_buf);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!strcmp(parent->type, "ebus"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ebus_path_component=
(dp, tmp_buf);
> +#ifdef CONFIG_SPARC_LEON
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(parent->type, "ambapp"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ambapp_path_componen=
t(dp, tmp_buf);
> +#endif
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* "isa" is handled with platform naming */
> =A0 =A0 =A0 =A0}

Speaking of things that are arguably unnecessary, the #ifdef
CONFIG_SPARC_LEON guards in this part of the patch seem to be somewhat
unnecessary - this code will not affect the existing code, apart from
making it slightly bigger.

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
