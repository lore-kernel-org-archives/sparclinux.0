From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 17 Jun 2016 19:52:37 +0000
Subject: Re: [PATCH v12.update2 02/15] PCI: Let pci_mmap_page_range() take resource address
Message-Id: <20160617195237.GA10416@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20160609222552.6938-1-yinghai@kernel.org>
 <20160617021555.GA21125@localhost>
 <CAE9FiQVMxuo16MArLXjT8oaSGMce1G=evaWqeOaW-WeT_ju6Mw@mail.gmail.com>
In-Reply-To: <CAE9FiQVMxuo16MArLXjT8oaSGMce1G=evaWqeOaW-WeT_ju6Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org

On Fri, Jun 17, 2016 at 12:25:49PM -0700, Yinghai Lu wrote:
> On Thu, Jun 16, 2016 at 7:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jun 09, 2016 at 03:25:52PM -0700, Yinghai Lu wrote:
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
> > I'm not quite sure what you're saying here.  Are you saying that sparc
> > is currently broken, and this patch fixes it?  If so, what exactly is
> > broken?  Can you give a small example of an mmap that is currently
> > broken?
> >
> >> Original pci_mmap_page_range() is taking PCI BAR value aka usr_address.
> >>
> >> Bjorn found out that it would be much simple to pass resource address
> >> directly and avoid extra those __pci_mmap_make_offset.
> >>
> >> In this patch:
> >> 1. in proc path: proc_bus_pci_mmap, try convert back to resource
> >>    before calling pci_mmap_page_range
> >> 2. in sysfs path: pci_mmap_resource will just offset with resource start.
> >> 3. all pci_mmap_page_range will have vma->vm_pgoff with in resource
> >>    range instead of BAR value.
> >> 4. remove __pci_mmap_make_offset, as the checking is done
> >>    in pci_mmap_fits().
> >
> > This is a pretty big patch.  It would help a lot to split it up.
> 
> Looks like they are tight together after change api. vm_pgoff meaning changes.
> 
> I could split item 4 to another patch, but compiler could complain or
> even refuse to
> go on if static functions are defined but not used.

Yeah, I was afraid they might be too tightly coupled to split up.
Still, every little bit helps.

> > I think the comment about "re-enabling the 2 lines below" is pointless
> > because doing that would break applications, which I don't think we'll
> > do.
> >
> > I propose the microblaze, powerpc, and sparc patches below, which
> > remove simplify pci_resource_to_user() and clean up this comment.
> 
> Agreed. Actually I have the change for sparc/PCI in patch 3
>    sparc/PCI: Use correct offset for bus address to resource
> according to previous review.

Sure enough, I see it there now.  I think it's easier to review when
split out, so I'll keep it separate, since it's not actually dependent
on the rest of the changes in "sparc/PCI: Use correct offset for bus
address to resource".

> Will drop related change in sparc/PCI: Use correct offset for bus
> address to resource
> 
> and respin the whole patchset today.

I added your acks and pushed the result to pci/resource.  I'll also
post these formally on the list so they're easier to find.

Bjorn
