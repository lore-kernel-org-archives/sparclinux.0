From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 22:05:58 +0000
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
Message-Id: <AANLkTi=2nb5oQ47Uzf+vDz0uT+O3_xrbV3bbo-WafCMq@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100726220405.1550.63442.stgit@angua>
In-Reply-To: <20100726220405.1550.63442.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.cras

On Mon, Jul 26, 2010 at 4:04 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> of_node_to_nid() is only relevant in a few architectures. =A0Don't force
> everyone to implement it anyway. =A0This patch also adds asm-generic/of.h
> which will be used to contain other overrideable symbols.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Oops.  The patch subject I will change before mergine.

g.

> ---
>
> Changes in v3: don't use asm-generic, just keep macros in of.h
> Changes in v2: address comments from sfr, add asm-generic/of.h
>
> =A0arch/microblaze/include/asm/topology.h | =A0 10 ----------
> =A0arch/powerpc/include/asm/prom.h =A0 =A0 =A0 =A0| =A0 =A05 +++++
> =A0arch/powerpc/include/asm/topology.h =A0 =A0| =A0 =A07 -------
> =A0arch/sparc/include/asm/prom.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0include/linux/of.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 =
+++++
> =A05 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/arch/microblaze/include/asm/topology.h b/arch/microblaze/inc=
lude/asm/topology.h
> index 96bcea5..5428f33 100644
> --- a/arch/microblaze/include/asm/topology.h
> +++ b/arch/microblaze/include/asm/topology.h
> @@ -1,11 +1 @@
> =A0#include <asm-generic/topology.h>
> -
> -#ifndef _ASM_MICROBLAZE_TOPOLOGY_H
> -#define _ASM_MICROBLAZE_TOPOLOGY_H
> -
> -struct device_node;
> -static inline int of_node_to_nid(struct device_node *device)
> -{
> - =A0 =A0 =A0 return 0;
> -}
> -#endif /* _ASM_MICROBLAZE_TOPOLOGY_H */
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/p=
rom.h
> index da7dd63..dca25a5 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -103,6 +103,11 @@ struct device_node *of_find_next_cache_node(struct d=
evice_node *np);
> =A0/* Get the MAC address */
> =A0extern const void *of_get_mac_address(struct device_node *np);
>
> +#ifdef CONFIG_NUMA
> +extern int of_node_to_nid(struct device_node *device);
> +#define of_node_to_nid of_node_to_nid
> +#endif
> +
> =A0/**
> =A0* of_irq_map_pci - Resolve the interrupt for a PCI device
> =A0* @pdev: =A0 =A0 =A0the device whose interrupt is to be resolved
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/a=
sm/topology.h
> index 32adf72..09dd38c 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -41,8 +41,6 @@ static inline int cpu_to_node(int cpu)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_all_mask =
: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node_to_cpuma=
sk_map[node])
>
> -int of_node_to_nid(struct device_node *device);
> -
> =A0struct pci_bus;
> =A0#ifdef CONFIG_PCI
> =A0extern int pcibus_to_node(struct pci_bus *bus);
> @@ -94,11 +92,6 @@ extern void sysfs_remove_device_from_node(struct sys_d=
evice *dev, int nid);
>
> =A0#else
>
> -static inline int of_node_to_nid(struct device_node *device)
> -{
> - =A0 =A0 =A0 return 0;
> -}
> -
> =A0static inline void dump_numa_cpu_topology(void) {}
>
> =A0static inline int sysfs_add_device_to_node(struct sys_device *dev, int=
 nid)
> diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
> index c82a7da..73befa5 100644
> --- a/arch/sparc/include/asm/prom.h
> +++ b/arch/sparc/include/asm/prom.h
> @@ -43,6 +43,7 @@ extern int of_getintprop_default(struct device_node *np,
> =A0extern int of_find_in_proplist(const char *list, const char *match, in=
t len);
> =A0#ifdef CONFIG_NUMA
> =A0extern int of_node_to_nid(struct device_node *dp);
> +#define of_node_to_nid of_node_to_nid
> =A0#else
> =A0#define of_node_to_nid(dp) =A0 =A0 (-1)
> =A0#endif
> diff --git a/include/linux/of.h b/include/linux/of.h
> index b0756f3..cc936ca 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -146,6 +146,11 @@ static inline unsigned long of_read_ulong(const __be=
32 *cell, int size)
>
> =A0#define OF_BAD_ADDR =A0 =A0((u64)-1)
>
> +#ifndef of_node_to_nid
> +static inline int of_node_to_nid(struct device_node *np) { return 0; }
> +#define of_node_to_nid of_node_to_nid
> +#endif
> +
> =A0extern struct device_node *of_find_node_by_name(struct device_node *fr=
om,
> =A0 =A0 =A0 =A0const char *name);
> =A0#define for_each_node_by_name(dn, name) \
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
