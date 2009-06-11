From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 11 Jun 2009 06:43:47 +0000
Subject: Re: [PATCH 5/7] Added support for AMBA bus. The device is a AMBA
Message-Id: <4A30A7A3.2050508@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1244629161-23939-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1244629161-23939-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Julian Calaby wrote:
> On Wed, Jun 10, 2009 at 20:19, <konrad@gaisler.com> wrote:
>> From: Konrad Eisele <konrad@gaisler.com>
>>
>> it is a child of prom node "ambapp" (AMBA plug and play).
>> Two functions leon_trans_init() and leon_node_init()
>> (defined in sparc/kernel/leon.c) are called in the
>> prom_build_tree() path if CONFIG_SPARC_LEON is defined.
>> leon_node_init() will build up the device tree using
>> AMBA plug and play.
>> ---
>>  arch/sparc/kernel/of_device_32.c |   45 +++++++++++++++++++++++++++++++++++++-
>>  arch/sparc/kernel/prom_32.c      |   38 ++++++++++++++++++++++++++++++++
>>  arch/sparc/kernel/prom_common.c  |   10 +++++++-
>>  3 files changed, 90 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
>> index 0a83bd7..e62daa2 100644
>> --- a/arch/sparc/kernel/of_device_32.c
>> +++ b/arch/sparc/kernel/of_device_32.c
>> @@ -125,7 +126,7 @@ static int of_out_of_range(const u32 *ad
>>        return 0;
>>  }
>>
>> -static int of_bus_default_map(u32 *addr, const u32 *range,
>> +SPARC_LEON_STATIC int of_bus_default_map(u32 *addr, const u32 *range,
>>                              int na, int ns, int pna)
>>  {
>>        u32 result[OF_MAX_ADDR_CELLS];
> 
> This is still ugly. Arguably, having it non-static wouldn't be a
> problem as it is used by the leon-specific code.
> 
> I understand that you want to make this entire patch set disappear
> when SPARC_LEON is unselected, but this is just making the existing
> code messy.

I might be able to remove SPARC_LEON_STATIC and revert it to the old
state.

> 
>> @@ -269,6 +270,37 @@ static unsigned long of_bus_sbus_get_fla
>>        return IORESOURCE_MEM;
>>  }
>>
>> +#ifdef CONFIG_SPARC_LEON
>> +
>> + /*
>> + * AMBAPP bus specific translator
>> + */
>> +
>> +int of_bus_ambapp_match(struct device_node *np)
>> +{
>> +       return !strcmp(np->name, "ambapp");
>> +}
>> +
>> +void of_bus_ambapp_count_cells(struct device_node *child,
>> +                                     int *addrc, int *sizec)
>> +{
>> +       if (addrc)
>> +               *addrc = 1;
>> +       if (sizec)
>> +               *sizec = 1;
>> +}
>> +
>> +int of_bus_ambapp_map(u32 *addr, const u32 *range, int na, int ns, int pna)
>> +{
>> +       return of_bus_default_map(addr, range, na, ns, pna);
>> +}
>> +
>> +unsigned long of_bus_ambapp_get_flags(const u32 *addr, unsigned long flags)
>> +{
>> +       return IORESOURCE_MEM;
>> +}
>> +
>> +#endif
>>
>>  /*
>>  * Array of bus specific translators
>> @@ -293,6 +325,17 @@ static struct of_bus of_busses[] = {
>>                .map = of_bus_sbus_map,
>>                .get_flags = of_bus_sbus_get_flags,
>>        },
>> +#ifdef CONFIG_SPARC_LEON
>> +       /* AMBA */
>> +       {
>> +               .name = "ambapp",
>> +               .addr_prop_name = "reg",
>> +               .match = of_bus_ambapp_match,
>> +               .count_cells = of_bus_ambapp_count_cells,
>> +               .map = of_bus_ambapp_map,
>> +               .get_flags = of_bus_ambapp_get_flags,
>> +       },
>> +#endif
>>        /* Default */
>>        {
>>                .name = "default",
>> diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
>> index fe43e80..5aee484 100644
>> --- a/arch/sparc/kernel/prom_32.c
>> +++ b/arch/sparc/kernel/prom_32.c
>> @@ -24,6 +24,7 @@ #include <linux/module.h>
>>
>>  #include <asm/prom.h>
>>  #include <asm/oplib.h>
>> +#include <asm/leon.h>
>>
>>  #include "prom.h"
>>
>> @@ -131,6 +132,39 @@ static void __init ebus_path_component(s
>>                regs->which_io, regs->phys_addr);
>>  }
>>
>> +#ifdef CONFIG_SPARC_LEON
>> +
>> +/* "name@irq,addrlo" */
>> +static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
>> +{
>> +       struct amba_prom_registers *regs; unsigned int *intr;
>> +       unsigned int *device, *vendor;
>> +       struct property *prop;
>> +
>> +       prop = of_find_property(dp, "reg", NULL);
>> +       if (!prop)
>> +               return;
>> +       regs = prop->value;
>> +       prop = of_find_property(dp, "interrupts", NULL);
>> +       if (!prop)
>> +               return;
>> +       intr = prop->value;
>> +       prop = of_find_property(dp, "vendor", NULL);
>> +       if (!prop)
>> +               return;
>> +       vendor = prop->value;
>> +       prop = of_find_property(dp, "device", NULL);
>> +       if (!prop)
>> +               return;
>> +       device = prop->value;
>> +
>> +       sprintf(tmp_buf, "%s:%d:%d@%x,%x",
>> +               dp->name, *vendor, *device,
>> +               *intr, regs->phys_addr);
>> +}
>> +
>> +#endif
>> +
>>  static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
>>  {
>>        struct device_node *parent = dp->parent;
>> @@ -143,6 +177,10 @@ static void __init __build_path_componen
>>                        return sbus_path_component(dp, tmp_buf);
>>                if (!strcmp(parent->type, "ebus"))
>>                        return ebus_path_component(dp, tmp_buf);
>> +#ifdef CONFIG_SPARC_LEON
>> +               if (!strcmp(parent->type, "ambapp"))
>> +                       return ambapp_path_component(dp, tmp_buf);
>> +#endif
>>
>>                /* "isa" is handled with platform naming */
>>        }
> 
> Speaking of things that are arguably unnecessary, the #ifdef
> CONFIG_SPARC_LEON guards in this part of the patch seem to be somewhat
> unnecessary - this code will not affect the existing code, apart from
> making it slightly bigger.
> 
> Thanks,
> 

I could remove the CONFIG_SPARC_LEON but on a sun-sparc machine this
never would be used because there is no amba bus there. I think weather
to remove it or not is something somebody other than me should decide
and patch it himself.

