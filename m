From: "David S. Miller" <davem@redhat.com>
Date: Wed, 30 Jun 2004 05:17:11 +0000
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040629221711.77f0fca5.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040630030503.GA25149@mail.shareable.org>
In-Reply-To: <20040630030503.GA25149@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jamie Lokier <jamie@shareable.org>
Cc: wesolows@foobazco.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.orgwesolows@foobazco.org

On Wed, 30 Jun 2004 04:05:03 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> In include/asm-sparc64/pgtable.h, there's:
> 
> #define __ACCESS_BITS   (_PAGE_ACCESSED | _PAGE_READ | _PAGE_R)
> #define PAGE_NONE       __pgprot (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_CACHE)
> #define PAGE_READONLY   __pgprot (_PAGE_PRESENT | _PAGE_VALID | _PAGE_CACHE | \
>                                   __ACCESS_BITS)
> 
> PAGE_NONE has the hardware _PAGE_PRESENT bit set.  However unlike
> PAGE_READONLY, it doesn't have the hardware _PAGE_R and software
> _PAGE_READ bits.
> 
> I guess that means that PAGE_NONE pages aren't readable from
> userspace.  Presumably the TLB handler takes care of it.
> Does it prevent reads from kernel space as well?

Neither user nor kernel can get at that page.  If _PAGE_R is not set
we get a real fault no matter who attempts the access.

> I.e. can you confirm that write() won't succeed in reading the data
> from a PROT_NONE page on Sparc64?  I think that's probably the case.
> You'll see why I ask, from the next one:

That's correct.

> In include/asm-sparc/pgtsrmmu.h, there's:
> 
> #define SRMMU_PAGE_NONE    __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> 				    SRMMU_PRIV | SRMMU_REF)
> #define SRMMU_PAGE_RDONLY  __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> 				    SRMMU_EXEC | SRMMU_REF)
> 
> This one bothers me.  The difference is that PROT_NONE pages are not
> accessible to userspace, and not executable.
> 
> So userspace will get a fault if it tries to read a PROT_NONE page.
> 
> But what happens when the kernel reads one?  Don't those bits mean
> that the read will succeed?  I.e. write() on a PROT_NONE page will
> succeed, instead of returning EFAULT?
> 
> If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
> document it.

Yes this one is a bug and not intentional.

Keith W., we need to fix this.  Probably the simplest fix is just to
drop the SRMMU_VALID bit.

> Alternatively, perhaps in this case simply omitting the SRMMU_REF bit
> would be enough?  Would that cause the TLB handler to be entered, and
> the TLB handler could then refuse access?  Again, I don't know enough
> about Sparc to say more.

No, if it's SRMMU_VALID the hardware lets the translation succeed and
like on x86 the hardware does the page table walk and thus the SRMMU_REF
bit setting.
