From: Jann Horn <jannh@google.com>
Date: Wed, 07 Oct 2020 14:42:55 +0000
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock and with length
Message-Id: <CAG48ez3kjTeVtQcjQerYYRs7sX5qq3O7SU-FEaYLNXisFmAeOg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
 <20201007123544.GA11433@infradead.org>
In-Reply-To: <20201007123544.GA11433@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, kernel list <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>, sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 7, 2020 at 2:35 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Oct 07, 2020 at 09:39:31AM +0200, Jann Horn wrote:
> > diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> > index 078608ec2e92..b1fabb97d138 100644
> > --- a/arch/powerpc/kernel/syscalls.c
> > +++ b/arch/powerpc/kernel/syscalls.c
> > @@ -43,7 +43,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
> >  {
> >       long ret = -EINVAL;
> >
> > -     if (!arch_validate_prot(prot, addr))
> > +     if (!arch_validate_prot(prot, addr, len))
>
> This call isn't under mmap lock.  I also find it rather weird as the
> generic code only calls arch_validate_prot from mprotect, only powerpc
> also calls it from mmap.
>
> This seems to go back to commit ef3d3246a0d0
> ("powerpc/mm: Add Strong Access Ordering support")

I'm _guessing_ the idea in the generic case might be that mmap()
doesn't check unknown bits in the protection flags, and therefore
maybe people wanted to avoid adding new error cases that could be
caused by random high bits being set? So while the mprotect() case
checks the flags and refuses unknown values, the mmap() code just lets
the architecture figure out which bits are actually valid to set (via
arch_calc_vm_prot_bits()) and silently ignores the rest?

And powerpc apparently decided that they do want to error out on bogus
prot values passed to their version of mmap(), and in exchange, assume
in arch_calc_vm_prot_bits() that the protection bits are valid?

powerpc's arch_validate_prot() doesn't actually need the mmap lock, so
I think this is fine-ish for now (as in, while the code is a bit
unclean, I don't think I'm making it worse, and I don't think it's
actually buggy). In theory, we could move the arch_validate_prot()
call over into the mmap guts, where we're holding the lock, and gate
it on the architecture or on some feature CONFIG that powerpc can
activate in its Kconfig. But I'm not sure whether that'd be helping or
making things worse, so when I sent this patch, I deliberately left
the powerpc stuff as-is.
