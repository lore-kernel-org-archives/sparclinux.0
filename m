From: Roland Dreier <roland@purestorage.com>
Date: Fri, 18 Nov 2011 02:17:08 +0000
Subject: Re: [BUG] Bad page map in process ibv_devinfo
Message-Id: <CAL1RGDVRnBQ1aaJn-RhiWpcdW89VBa+QgH8Z8YPJOt-7Wfmbmg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1321471354.5493.YahooMailNeo@web24714.mail.ird.yahoo.com>
 <20111117.164941.2104520709167256016.davem@davemloft.net> <CAL1RGDV_AwOOnLvWJKGqBTaptetfVN_gXNG=PcaFUXYSXrQ5AA@mail.gmail.com>
 <20111117.210316.83327515715765011.davem@davemloft.net>
In-Reply-To: <20111117.210316.83327515715765011.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: linux@razik.name, sparclinux@vger.kernel.org, linux-rdma@vger.kernel.org

On Thu, Nov 17, 2011 at 6:03 PM, David Miller <davem@davemloft.net> wrote:
> I suspect this is an issue about who is responsible for setting the
> various VM_* flags in the VMA.
>
> It at least used to be the case that the caller was responsible, but
> it seems that this has changed in some regard. =A0And if you look at
> remap_pfn_range(), which is what x86 uses, it sets things like VM_IO
> explicitly.
>
> In fact, sparc is one of the few platforms not using remap_pfn_range()
> as it's io_remap_pfn_range() implementation.

Somewhat makes sense but OTOH I don't see the difference between
arch/sparc/mm/generic_64.c:

int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
                unsigned long pfn, unsigned long size, pgprot_t prot)
{
...
        vma->vm_flags |=3D VM_IO | VM_RESERVED | VM_PFNMAP;

and mm/memory.c:

int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
                    unsigned long pfn, unsigned long size, pgprot_t prot)
{
...
        if (addr =3D vma->vm_start && end =3D vma->vm_end) {
                vma->vm_pgoff =3D pfn;
                vma->vm_flags |=3D VM_PFN_AT_MMAP;
        } else if (is_cow_mapping(vma->vm_flags))
                return -EINVAL;

        vma->vm_flags |=3D VM_IO | VM_RESERVED | VM_PFNMAP;

The only thing sparc seems to be missing is the VM_PFN_AT_MMAP
but that only gets tested in the x86 PAT code and in the transparent
hugepage code (which I suspect doesn't get used on sparc either).

Anyway definitely makes sense as something to check.

 - R.
