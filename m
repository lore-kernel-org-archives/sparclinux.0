From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 22 Jun 2016 15:22:43 +0000
Subject: Re: [PATCH v13 01/16] PCI: Let pci_mmap_page_range() take resource address
Message-Id: <20160622152243.GC25485@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20160618022501.15648-1-yinghai@kernel.org>
 <20160618022501.15648-2-yinghai@kernel.org>
 <20160618121752.GA22721@localhost>
 <CAE9FiQXKVLWZaiD0CgSGEMN6c4g6GeCNGS=NE=gC-CEAymo1eQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXKVLWZaiD0CgSGEMN6c4g6GeCNGS=NE=gC-CEAymo1eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org

On Tue, Jun 21, 2016 at 09:32:49PM -0700, Yinghai Lu wrote:
> On Sat, Jun 18, 2016 at 5:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jun 17, 2016 at 07:24:46PM -0700, Yinghai Lu wrote:
> >> In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
> >> to check exposed value with resource start/end in proc mmap path.
> >>
> >> |        start = vma->vm_pgoff;
> >> |        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> >> |        pci_start = (mmap_api = PCI_MMAP_PROCFS) ?
> >> |                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
> >> |        if (start >= pci_start && start < pci_start + size &&
> >> |                        start + nr <= pci_start + size)
> >>
> >> That breaks sparc that exposed value is BAR value, and need to be offseted
> >> to resource address.
> >
> > I asked this same question of the v12 patch, but I don't think you
> > answered it:
> >
> > I'm not quite sure what you're saying here.  Are you saying that sparc
> > is currently broken, and this patch fixes it?  If so, what exactly is
> > broken?  Can you give a small example of an mmap that is currently
> > broken?
> 
> Yes, for sparc that path (proc mmap) is broken, but only according to
> code checking.
> 
> The reason for the problem is not discovered is that seem all users
> (other than x86) are not
> use proc_mmap ?
> 
> vma->vm_pgoff is that code segment is User/BAR value >> PAGE_SHIFT.
> pci_start is resource->start >> PAGE_SHIFT.
> 
> For sparc, resource start is different from BAR start aka pci bus address.
> pci bus address add offset to be the resource start.

If sparc is broken, let's make this a tiny sparc-only patch that fixes
only the breakage -- no cleanup or restructuring.  Then we can do the
more extensive work in a separate patch.

The example mmap() I keep asking for would be very helpful to me in
understanding the problem.  It would probably also help folks who
maintain user programs that use mmap.  They need to figure out whether
they have code that worked most places but has always been broken on
sparc, or code that depended on the previous sparc behavior and will
be broken by this change, or what.

Bjorn
