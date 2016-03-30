From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 30 Mar 2016 19:37:06 +0000
Subject: Re: [PATCH v4] sparc/PCI: Fix for panic while enabling SR-IOV
Message-Id: <20160330193705.GA15506@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <1458849742-162399-1-git-send-email-babu.moger@oracle.com>
 <20160329.205717.1170899993877119259.davem@davemloft.net>
 <56FBF146.3020701@oracle.com>
In-Reply-To: <56FBF146.3020701@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: David Miller <davem@davemloft.net>, bhelgaas@google.com, wangyijing@huawei.com, sowmini.varadhan@oracle.com, jiang.liu@linux.intel.com, eric.snowberg@oracle.com, yinghai@kernel.org, dan.j.williams@intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, ethan.zhao@oracle.com

On Wed, Mar 30, 2016 at 10:31:18AM -0500, Babu Moger wrote:
> Hi David,
> 
> On 3/29/2016 7:57 PM, David Miller wrote:
> > From: Babu Moger <babu.moger@oracle.com>
> > Date: Thu, 24 Mar 2016 13:02:22 -0700
> > 
> >> We noticed this panic while enabling SR-IOV in sparc.
> >  ...
> >> SR-IOV code looks for arch specific data while enabling
> >> VFs. When VF device is added, driver probe function makes set
> >> of calls to initialize the pci device. Because the VF device is
> >> added different way than the normal PF device(which happens via
> >> of_create_pci_dev for sparc), some of the arch specific initialization
> >> does not happen for VF device.  That causes panic when archdata is
> >> accessed.
> >>
> >> To fix this, I have used already defined weak function
> >> pcibios_setup_device to copy archdata from PF to VF.
> >> Also verified the fix.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> >> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> >> Reviewed-by: Ethan Zhao <ethan.zhao@oracle.com>
> > 
> > Looks good, applied and queued up for -stable, thanks.
> 
> Thanks.
> 
> > 
> > Just a note, I am assuming that the VFs are not instantiated in the
> > device tree.  Because when you just memcpy the arch data over from the
> > PF, one thing we end up doing is using the device node of the PF.
> 
> No. VFs are not instantiated in device tree(/proc/device-tree)
> 
> > 
> > I slightly cringed at the memcpy, because at least one of these
> > pointers are to objects which are reference counted, the OF device.
> > 
> > Generally speaking we don't really support hot-plug for OF probed
> > devices, but if we did all of the device tree pointers have to be
> > refcounted properly.
> > 
> > So in the long term that whole sequence where we go:
> > 
> > 	struct dev_archdata *sd;
> >  ...
> > 	sd = &dev->dev.archdata;
> > 	sd->iommu = pbm->iommu;
> > 	sd->stc = &pbm->stc;
> > 	sd->host_controller = pbm;
> > 	sd->op = op = of_find_device_by_node(node);
> > 	sd->numa_node = pbm->numa_node;
> > 
> > should be encapsulated into a helper function, and both
> > of_create_pci_dev() and this new pcibios_setup_device() can
> > invoke it.
> > 
> 
> Yes. Agree. We need to refactor the whole of_create_pci_dev path to support
> hot-plug for the long term. I will start looking at it. For now we should be
> fine with the current patch. thanks

of_create_pci_dev() duplicates a lot of the code in
pci_setup_device().  I wish we didn't have to do that
because it's easy to let them get out of sync, but I
don't know if there are any reasonable alternatives.

I've wondered in the past whether it would be possible
to use the pci_setup_device() path on sparc & powerpc by
writing PCI config accessors that look up OF properties
as needed to fabricate responses to config reads.  Several
of the drivers in drivers/pci/host/* do a little bit of
this fabrication, although I don't think any go to the
extent of using OF.

Bjorn
