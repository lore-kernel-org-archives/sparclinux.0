From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 17 Jun 2016 19:25:49 +0000
Subject: Re: [PATCH v12.update2 02/15] PCI: Let pci_mmap_page_range() take resource address
Message-Id: <CAE9FiQVMxuo16MArLXjT8oaSGMce1G=evaWqeOaW-WeT_ju6Mw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160609222552.6938-1-yinghai@kernel.org> <20160617021555.GA21125@localhost>
In-Reply-To: <20160617021555.GA21125@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org

On Thu, Jun 16, 2016 at 7:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Jun 09, 2016 at 03:25:52PM -0700, Yinghai Lu wrote:
>> In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
>> to check exposed value with resource start/end in proc mmap path.
>>
>> |        start = vma->vm_pgoff;
>> |        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
>> |        pci_start = (mmap_api = PCI_MMAP_PROCFS) ?
>> |                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
>> |        if (start >= pci_start && start < pci_start + size &&
>> |                        start + nr <= pci_start + size)
>>
>> That breaks sparc that exposed value is BAR value, and need to be offseted
>> to resource address.
>
> I'm not quite sure what you're saying here.  Are you saying that sparc
> is currently broken, and this patch fixes it?  If so, what exactly is
> broken?  Can you give a small example of an mmap that is currently
> broken?
>
>> Original pci_mmap_page_range() is taking PCI BAR value aka usr_address.
>>
>> Bjorn found out that it would be much simple to pass resource address
>> directly and avoid extra those __pci_mmap_make_offset.
>>
>> In this patch:
>> 1. in proc path: proc_bus_pci_mmap, try convert back to resource
>>    before calling pci_mmap_page_range
>> 2. in sysfs path: pci_mmap_resource will just offset with resource start.
>> 3. all pci_mmap_page_range will have vma->vm_pgoff with in resource
>>    range instead of BAR value.
>> 4. remove __pci_mmap_make_offset, as the checking is done
>>    in pci_mmap_fits().
>
> This is a pretty big patch.  It would help a lot to split it up.

Looks like they are tight together after change api. vm_pgoff meaning changes.

I could split item 4 to another patch, but compiler could complain or
even refuse to
go on if static functions are defined but not used.

...
>
> I think the comment about "re-enabling the 2 lines below" is pointless
> because doing that would break applications, which I don't think we'll
> do.
>
> I propose the microblaze, powerpc, and sparc patches below, which
> remove simplify pci_resource_to_user() and clean up this comment.

Agreed. Actually I have the change for sparc/PCI in patch 3
   sparc/PCI: Use correct offset for bus address to resource
according to previous review.

>> @@ -999,7 +1010,6 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
>>       struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>>       struct resource *res = attr->private;
>>       enum pci_mmap_state mmap_type;
>> -     resource_size_t start, end;
>>       int i;
>>
>>       for (i = 0; i < PCI_ROM_RESOURCE; i++)
>> @@ -1008,10 +1018,21 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
>>       if (i >= PCI_ROM_RESOURCE)
>>               return -ENODEV;
>>
>> +     /*
>> +      * resource start have to be PAGE_SIZE aligned, as we pass
>> +      * back virt address include round down of resource_start,
>> +      * that caller can not figure out directly.
>> +      * when it is not aligned, that mean it is io port, should go
>> +      * pci_read_resource_io()/pci_write_resource_io() path.
>> +      */
>> +     if (res->start & ~PAGE_MASK)
>> +             return -EINVAL;
>
> It seems reasonable to require that the mmap start and end be
> page-aligned.  It seems like we ought to do the same for the sysfs and
> the procfs paths.
>
> Since we haven't enforced this in the past, there is the potential for
> breaking user programs, isn't there?
>
> The alignment enforcement should be in a patch by itself, so bisection
> would tell us something useful.

ok. will do that.

>
> commit 3dbd970b6d9a96ab471b4b86650a0200a47d375d
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu May 5 11:39:04 2016 -0500
>
>     microblaze/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()
>
>     "User" addresses are shown in /sys/devices/pci.../.../resource and
>     /proc/bus/pci/devices and used as mmap offsets for /proc/bus/pci/BB/DD.F
>     files.  For I/O port resources on microblaze, these are PCI bus addresses,
>     i.e., raw BAR values.
>
>     Previously pci_resource_to_user() computed the user address by subtracting
>     "hose->io_base_virt - _IO_BASE" from the resource start:
>
>       pci_resource_to_user()
>         if (IO)
>           offset = (unsigned long)hose->io_base_virt - _IO_BASE;
>         *start = rsrc->start - offset;
>
>     We've already told the PCI core about that "hose->io_base_virt - _IO_BASE"
>     offset:
>
>       pcibios_setup_phb_resources()
>         res = &hose->io_resource;
>         pci_add_resource_offset(resources, res, hose->io_base_virt - _IO_BASE);
>
>     so pcibios_resource_to_bus() knows how to do that translation.
>
>     No functional change intended.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Yinghai Lu <yinghai@kernel.org>

>
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index 1974567..e0dd64e 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -444,39 +444,24 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
>                           const struct resource *rsrc,
>                           resource_size_t *start, resource_size_t *end)
>  {
> -       struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -       resource_size_t offset = 0;
> +       struct pci_bus_region region;
>
> -       if (hose = NULL)
> +       if (rsrc->flags & IORESOURCE_IO) {
> +               pcibios_resource_to_bus(dev, &region, rsrc);
> +               *start = region.start;
> +               *end = region.end;
>                 return;
> +       }
>
> -       if (rsrc->flags & IORESOURCE_IO)
> -               offset = (unsigned long)hose->io_base_virt - _IO_BASE;
> -
> -       /* We pass a fully fixed up address to userland for MMIO instead of
> -        * a BAR value because X is lame and expects to be able to use that
> -        * to pass to /dev/mem !
> +       /* We pass a CPU physical address to userland for MMIO instead of a
> +        * BAR value because X is lame and expects to be able to use that
> +        * to pass to /dev/mem!
>          *
> -        * That means that we'll have potentially 64 bits values where some
> -        * userland apps only expect 32 (like X itself since it thinks only
> -        * Sparc has 64 bits MMIO) but if we don't do that, we break it on
> -        * 32 bits CHRPs :-(
> -        *
> -        * Hopefully, the sysfs insterface is immune to that gunk. Once X
> -        * has been fixed (and the fix spread enough), we can re-enable the
> -        * 2 lines below and pass down a BAR value to userland. In that case
> -        * we'll also have to re-enable the matching code in
> -        * __pci_mmap_make_offset().
> -        *
> -        * BenH.
> +        * That means we may have 64-bit values where some apps only expect
> +        * 32 (like X itself since it thinks only Sparc has 64-bit MMIO).
>          */
> -#if 0
> -       else if (rsrc->flags & IORESOURCE_MEM)
> -               offset = hose->pci_mem_offset;
> -#endif
> -
> -       *start = rsrc->start - offset;
> -       *end = rsrc->end - offset;
> +       *start = rsrc->start;
> +       *end = rsrc->end;
>  }
>
>  /**
>
> commit 8549d796d788da46236d22be8da283819d5b5a12
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jun 16 17:47:22 2016 -0500
>
>     powerpc/pci: Implement pci_resource_to_user() with pcibios_resource_to_bus()
>
>     "User" addresses are shown in /sys/devices/pci.../.../resource and
>     /proc/bus/pci/devices and used as mmap offsets for /proc/bus/pci/BB/DD.F
>     files.  For I/O port resources on powerpc, these are PCI bus addresses,
>     i.e., raw BAR values.
>
>     Previously pci_resource_to_user() computed the user address by subtracting
>     "hose->io_base_virt - _IO_BASE" from the resource start:
>
>       pci_resource_to_user()
>         if (IO)
>           offset = (unsigned long)hose->io_base_virt - _IO_BASE;
>         *start = rsrc->start - offset;
>
>     We've already told the PCI core about that "hose->io_base_virt - _IO_BASE"
>     offset:
>
>       pcibios_setup_phb_resources()
>         res = &hose->io_resource;
>         offset = pcibios_io_space_offset();
>         /* i.e., "offset = hose->io_base_virt - _IO_BASE" */
>         pci_add_resource_offset(resources, res, offset);
>
>     so pcibios_resource_to_bus() knows how to do that translation.
>
>     No functional change intended.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Yinghai Lu <yinghai@kernel.org>

>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 8c6beb0..16d9e14 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -581,39 +581,24 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
>                           const struct resource *rsrc,
>                           resource_size_t *start, resource_size_t *end)
>  {
> -       struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -       resource_size_t offset = 0;
> +       struct pci_bus_region region;
>
> -       if (hose = NULL)
> +       if (rsrc->flags & IORESOURCE_IO) {
> +               pcibios_resource_to_bus(dev, &region, rsrc);
> +               *start = region.start;
> +               *end = region.end;
>                 return;
> +       }
>
> -       if (rsrc->flags & IORESOURCE_IO)
> -               offset = (unsigned long)hose->io_base_virt - _IO_BASE;
> -
> -       /* We pass a fully fixed up address to userland for MMIO instead of
> -        * a BAR value because X is lame and expects to be able to use that
> -        * to pass to /dev/mem !
> -        *
> -        * That means that we'll have potentially 64 bits values where some
> -        * userland apps only expect 32 (like X itself since it thinks only
> -        * Sparc has 64 bits MMIO) but if we don't do that, we break it on
> -        * 32 bits CHRPs :-(
> -        *
> -        * Hopefully, the sysfs insterface is immune to that gunk. Once X
> -        * has been fixed (and the fix spread enough), we can re-enable the
> -        * 2 lines below and pass down a BAR value to userland. In that case
> -        * we'll also have to re-enable the matching code in
> -        * __pci_mmap_make_offset().
> +       /* We pass a CPU physical address to userland for MMIO instead of a
> +        * BAR value because X is lame and expects to be able to use that
> +        * to pass to /dev/mem!
>          *
> -        * BenH.
> +        * That means we may have 64-bit values where some apps only expect
> +        * 32 (like X itself since it thinks only Sparc has 64-bit MMIO).
>          */
> -#if 0
> -       else if (rsrc->flags & IORESOURCE_MEM)
> -               offset = hose->pci_mem_offset;
> -#endif
> -
> -       *start = rsrc->start - offset;
> -       *end = rsrc->end - offset;
> +       *start = rsrc->start;
> +       *end = rsrc->end;
>  }
>
>  /**
>
> commit 2ad70d5e96f3945656cfca8c005384f2a858a8c5
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu May 5 10:56:58 2016 -0500
>
>     sparc/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()
>
>     "User" addresses are shown in /sys/devices/pci.../.../resource and
>     /proc/bus/pci/devices and used as mmap offsets for /proc/bus/pci/BB/DD.F
>     files.  On sparc, these are PCI bus addresses, i.e., raw BAR values.
>
>     Previously pci_resource_to_user() computed the user address by
>     subtracting either pbm->io_space.start or pbm->mem_space.start from the
>     resource start.
>
>     We've already told the PCI core about those offsets here:
>
>       pci_scan_one_pbm()
>         pci_add_resource_offset(&resources, &pbm->io_space, pbm->io_space.start);
>         pci_add_resource_offset(&resources, &pbm->mem_space, pbm->mem_space.start);
>         pci_add_resource_offset(&resources, &pbm->mem64_space, pbm->mem_space.start);
>
>     so pcibios_resource_to_bus() knows how to do that translation.
>
>     No functional change intended.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index c2b202d..a4f158b 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -986,16 +986,18 @@ void pci_resource_to_user(const struct pci_dev *pdev, int bar,
>                           const struct resource *rp, resource_size_t *start,
>                           resource_size_t *end)
>  {
> -       struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
> -       unsigned long offset;
> -
> -       if (rp->flags & IORESOURCE_IO)
> -               offset = pbm->io_space.start;
> -       else
> -               offset = pbm->mem_space.start;
> +       struct pci_bus_region region;
>
> -       *start = rp->start - offset;
> -       *end = rp->end - offset;
> +       /*
> +        * "User" addresses are shown in /sys/devices/pci.../.../resource
> +        * and /proc/bus/pci/devices and used as mmap offsets for
> +        * /proc/bus/pci/BB/DD.F files (see proc_bus_pci_mmap()).
> +        *
> +        * On sparc, these are PCI bus addresses, i.e., raw BAR values.
> +        */
> +       pcibios_resource_to_bus(pdev->bus, &region, rp);
> +       *start = region.start;
> +       *end = region.end;
>  }
>
>  void pcibios_set_master(struct pci_dev *dev)

Acked-by: Yinghai Lu <yinghai@kernel.org>

Will drop related change in sparc/PCI: Use correct offset for bus
address to resource

and respin the whole patchset today.

Thanks

Yinghai
