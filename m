From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 23:26:29 +0000
Subject: Re: [PATCH v1 4/9] sparc/PCI: convert devtree bus addresses to resource
Message-Id: <CAErSpo7MqqyaBN-u2hADM5swC9ZkN+0eD_XOtcqg3L8Z3F3YeQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com> <20120307010027.27465.93846.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307010027.27465.93846.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Tue, Mar 6, 2012 at 6:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Normal PCI enumeration via PCI config space uses __pci_read_base(), where
> the PCI core applies any bus-to-resource offset. =A0But sparc doesn't use
> that path when enumerating via the device tree.
>
> This adds the corresponding bus-to-resource conversion in the paths that
> read BAR values from the OF device tree.
>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> =A0arch/sparc/kernel/pci.c | =A0 66 +++++++++++++++++++++----------------=
----------
> =A01 files changed, 29 insertions(+), 37 deletions(-)
>
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index 253e8ac..b4fbfe4 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -202,6 +202,7 @@ static void pci_parse_of_addrs(struct platform_device=
 *op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device=
_node *node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_de=
v *dev)
> =A0{
> + =A0 =A0 =A0 struct pci_bus_region region;
> =A0 =A0 =A0 =A0struct resource *op_res;
> =A0 =A0 =A0 =A0const u32 *addrs;
> =A0 =A0 =A0 =A0int proplen;
> @@ -236,10 +237,11 @@ static void pci_parse_of_addrs(struct platform_devi=
ce *op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "PCI: bad =
cfg reg num 0x%x\n", i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D op_res->start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D op_res->end;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D flags;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->name =3D pci_name(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.start =3D op_res->start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.end =3D op_res->end;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);

I think this piece is incorrect; I can't find any place in the
existing code that applies a bus-to-resource conversion to these
resources, so I shouldn't be adding one.

I posted an updated series that changes this and folds these fixes
into the original patches to preserve bisectability.

Bjorn

> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -375,13 +377,6 @@ static void __devinit apb_calc_first_last(u8 map, u3=
2 *first_p, u32 *last_p)
> =A0 =A0 =A0 =A0*last_p =3D last;
> =A0}
>
> -static void pci_resource_adjust(struct resource *res,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct reso=
urce *root)
> -{
> - =A0 =A0 =A0 res->start +=3D root->start;
> - =A0 =A0 =A0 res->end +=3D root->start;
> -}
> -
> =A0/* For PCI bus devices which lack a 'ranges' property we interrogate
> =A0* the config space values to set the resources, just like the generic
> =A0* Linux PCI probing code does.
> @@ -390,7 +385,8 @@ static void __devinit pci_cfg_fake_ranges(struct pci_=
dev *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0struct pci_bus *bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0struct pci_pbm_info *pbm)
> =A0{
> - =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 struct pci_bus_region region;
> + =A0 =A0 =A0 struct resource *res, res2;
> =A0 =A0 =A0 =A0u8 io_base_lo, io_limit_lo;
> =A0 =A0 =A0 =A0u16 mem_base_lo, mem_limit_lo;
> =A0 =A0 =A0 =A0unsigned long base, limit;
> @@ -412,11 +408,14 @@ static void __devinit pci_cfg_fake_ranges(struct pc=
i_dev *dev,
> =A0 =A0 =A0 =A0res =3D bus->resource[0];
> =A0 =A0 =A0 =A0if (base <=3D limit) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D (io_base_lo & PCI_IO_RANGE_=
TYPE_MASK) | IORESOURCE_IO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res2.flags =3D res->flags;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.start =3D base;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.end =3D limit + 0xfff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_bus_to_resource(dev, &res2, &region=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!res->start)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D base;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D res2.start;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!res->end)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D limit + 0xfff;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_resource_adjust(res, &pbm->io_space);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D res2.end;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
> @@ -428,9 +427,9 @@ static void __devinit pci_cfg_fake_ranges(struct pci_=
dev *dev,
> =A0 =A0 =A0 =A0if (base <=3D limit) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D ((mem_base_lo & PCI_MEMORY_=
RANGE_TYPE_MASK) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IORESOURCE_MEM=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D base;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D limit + 0xfffff;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_resource_adjust(res, &pbm->mem_space);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.start =3D base;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.end =3D limit + 0xfffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_=
lo);
> @@ -459,9 +458,9 @@ static void __devinit pci_cfg_fake_ranges(struct pci_=
dev *dev,
> =A0 =A0 =A0 =A0if (base <=3D limit) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D ((mem_base_lo & PCI_MEMORY_=
RANGE_TYPE_MASK) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IORESOURCE_MEM=
 | IORESOURCE_PREFETCH);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D base;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D limit + 0xfffff;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_resource_adjust(res, &pbm->mem_space);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.start =3D base;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.end =3D limit + 0xfffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -472,6 +471,7 @@ static void __devinit apb_fake_ranges(struct pci_dev =
*dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0struct pci_bus *bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0struct pci_pbm_info *pbm)
> =A0{
> + =A0 =A0 =A0 struct pci_bus_region region;
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0u32 first, last;
> =A0 =A0 =A0 =A0u8 map;
> @@ -479,18 +479,18 @@ static void __devinit apb_fake_ranges(struct pci_de=
v *dev,
> =A0 =A0 =A0 =A0pci_read_config_byte(dev, APB_IO_ADDRESS_MAP, &map);
> =A0 =A0 =A0 =A0apb_calc_first_last(map, &first, &last);
> =A0 =A0 =A0 =A0res =3D bus->resource[0];
> - =A0 =A0 =A0 res->start =3D (first << 21);
> - =A0 =A0 =A0 res->end =3D (last << 21) + ((1 << 21) - 1);
> =A0 =A0 =A0 =A0res->flags =3D IORESOURCE_IO;
> - =A0 =A0 =A0 pci_resource_adjust(res, &pbm->io_space);
> + =A0 =A0 =A0 region.start =3D (first << 21);
> + =A0 =A0 =A0 region.end =3D (last << 21) + ((1 << 21) - 1);
> + =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);
>
> =A0 =A0 =A0 =A0pci_read_config_byte(dev, APB_MEM_ADDRESS_MAP, &map);
> =A0 =A0 =A0 =A0apb_calc_first_last(map, &first, &last);
> =A0 =A0 =A0 =A0res =3D bus->resource[1];
> - =A0 =A0 =A0 res->start =3D (first << 21);
> - =A0 =A0 =A0 res->end =3D (last << 21) + ((1 << 21) - 1);
> =A0 =A0 =A0 =A0res->flags =3D IORESOURCE_MEM;
> - =A0 =A0 =A0 pci_resource_adjust(res, &pbm->mem_space);
> + =A0 =A0 =A0 region.start =3D (first << 21);
> + =A0 =A0 =A0 region.end =3D (last << 21) + ((1 << 21) - 1);
> + =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);
> =A0}
>
> =A0static void __devinit pci_of_scan_bus(struct pci_pbm_info *pbm,
> @@ -506,6 +506,7 @@ static void __devinit of_scan_pci_bridge(struct pci_p=
bm_info *pbm,
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> =A0 =A0 =A0 =A0const u32 *busrange, *ranges;
> =A0 =A0 =A0 =A0int len, i, simba;
> + =A0 =A0 =A0 struct pci_bus_region region;
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0unsigned int flags;
> =A0 =A0 =A0 =A0u64 size;
> @@ -556,8 +557,6 @@ static void __devinit of_scan_pci_bridge(struct pci_p=
bm_info *pbm,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0i =3D 1;
> =A0 =A0 =A0 =A0for (; len >=3D 32; len -=3D 32, ranges +=3D 8) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *root;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags =3D pci_parse_of_flags(ranges[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D GET_64BIT(ranges, 6);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (flags =3D 0 || size =3D 0)
> @@ -569,7 +568,6 @@ static void __devinit of_scan_pci_bridge(struct pci_p=
bm_info *pbm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 " for bridge %s\n", node->full_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root =3D &pbm->io_space;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i >=3D PCI_NUM_RESOURC=
ES - PCI_BRIDGE_RESOURCES) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KER=
N_ERR "PCI: too many memory ranges"
> @@ -578,18 +576,12 @@ static void __devinit of_scan_pci_bridge(struct pci=
_pbm_info *pbm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res =3D bus->resource[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0++i;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root =3D &pbm->mem_space;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D GET_64BIT(ranges, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end =3D res->start + size - 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res->flags =3D flags;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Another way to implement this would be t=
o add an of_device
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* layer routine that can calculate a res=
ource for a given
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* range property value in a PCI device.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_resource_adjust(res, root);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.start =3D GET_64BIT(ranges, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region.end =3D region.start + size - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_bus_to_resource(dev, res, &region);
> =A0 =A0 =A0 =A0}
> =A0after_ranges:
> =A0 =A0 =A0 =A0sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
>
