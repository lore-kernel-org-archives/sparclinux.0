From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 14 Feb 2010 14:08:52 +0000
Subject: Re: [PATCH 4/9] of/flattree: Don't assume HAVE_LMB
Message-Id: <fa686aa41002140608q77af6878n70821d874ea7ecde@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua> <20100213160247.4767.74578.stgit@angua>
	<4B7801FA.9080203@petalogix.com>
In-Reply-To: <4B7801FA.9080203@petalogix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: michal.simek@petalogix.com
Cc: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org, jeremy.kerr@canonical.com, davem@davemloft.net, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Sun, Feb 14, 2010 at 7:00 AM, Michal Simek
<michal.simek@petalogix.com> wrote:
> Grant Likely wrote:
>>
>> From: Jeremy Kerr <jeremy.kerr@canonical.com>
>>
>> We don't always have lmb available, so make arches provide an
>> early_init_dt_alloc_memory_arch() to handle the allocation of
>> memory in the fdt code.
>>
>> When we don't have lmb.h included, we need asm/page.h for __va.
>>
>> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> =A0arch/microblaze/kernel/prom.c | =A0 =A05 +++++
>> =A0arch/powerpc/kernel/prom.c =A0 =A0| =A0 =A05 +++++
>> =A0drivers/of/fdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09 ++++++---
>> =A0include/linux/of_fdt.h =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A04 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom=
.c
>> index 050b799..a7dcaf0 100644
>> --- a/arch/microblaze/kernel/prom.c
>> +++ b/arch/microblaze/kernel/prom.c
>> @@ -55,6 +55,11 @@ void __init early_init_dt_add_memory_arch(u64 base, u=
64
>> size)
>> =A0 =A0 =A0 =A0lmb_add(base, size);
>> =A0}
>> =A0+u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>> +{
>> + =A0 =A0 =A0 return lmb_alloc(size, align);
>> +}
>> +
>> =A0#ifdef CONFIG_EARLY_PRINTK
>> =A0/* MS this is Microblaze specifig function */
>> =A0static int __init early_init_dt_scan_serial(unsigned long node,
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 43c78d7..5bbbdb2 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -510,6 +510,11 @@ void __init early_init_dt_add_memory_arch(u64 base,
>> u64 size)
>> =A0 =A0 =A0 =A0memstart_addr =3D min((u64)memstart_addr, base);
>> =A0}
>> =A0+u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>> +{
>> + =A0 =A0 =A0 return lmb_alloc(size, align);
>> +}
>> +
>> =A0#ifdef CONFIG_BLK_DEV_INITRD
>> =A0void __init early_init_dt_setup_initrd_arch(unsigned long start,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long end)
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index b51f797..406757a 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -10,16 +10,18 @@
>> =A0*/
>> =A0=A0#include <linux/kernel.h>
>> -#include <linux/lmb.h>
>> =A0#include <linux/initrd.h>
>> =A0#include <linux/of.h>
>> =A0#include <linux/of_fdt.h>
>> -
>> +#include <linux/string.h>
>> +#include <linux/errno.h>
>> =A0=A0#ifdef CONFIG_PPC
>> =A0#include <asm/machdep.h>
>> =A0#endif /* CONFIG_PPC */
>
> It is not part of your patch but I think that will be great completely
> remove this CONFIG_PPC part from generic OF file.
> Would it be possible to include your asm/machdep.h through asm/page.h or =
any
> other file?

Yup.  I'll get there unless someone else beats me to it.  :-)

>
> Michal
>
>> =A0+#include <asm/page.h>
>> +
>> =A0int __initdata dt_root_addr_cells;
>> =A0int __initdata dt_root_size_cells;
>> =A0@@ -560,7 +562,8 @@ void __init unflatten_device_tree(void)
>> =A0 =A0 =A0 =A0pr_debug(" =A0size is %lx, allocating...\n", size);
>> =A0 =A0 =A0 =A0 =A0/* Allocate memory for the expanded device tree */
>> - =A0 =A0 =A0 mem =3D lmb_alloc(size + 4, __alignof__(struct device_node=
));
>> + =A0 =A0 =A0 mem =3D early_init_dt_alloc_memory_arch(size + 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __alignof__(struct device_=
node));
>> =A0 =A0 =A0 =A0mem =3D (unsigned long) __va(mem);
>> =A0 =A0 =A0 =A0 =A0((__be32 *)mem)[size / 4] =3D cpu_to_be32(0xdeadbeef);
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index c9cb8a7..a1ca92c 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -78,6 +78,7 @@ extern void early_init_dt_check_for_initrd(unsigned lo=
ng
>> node);
>> =A0extern int early_init_dt_scan_memory(unsigned long node, const char
>> *uname,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
int depth, void *data);
>> =A0extern void early_init_dt_add_memory_arch(u64 base, u64 size);
>> +extern u64 early_init_dt_alloc_memory_arch(u64 size, u64 align);
>> =A0extern u64 dt_mem_next_cell(int s, __be32 **cellp);
>> =A0=A0/*
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>
>
> --
> Michal Simek, Ing. (M.Eng)
> PetaLogix - Linux Solutions for a Reconfigurable World
> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
