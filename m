From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 08 Oct 2020 11:03:07 +0000
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock and with length
Message-Id: <20201008110307.GH7661@gaia>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
 <20201007123544.GA11433@infradead.org>
 <CAG48ez3kjTeVtQcjQerYYRs7sX5qq3O7SU-FEaYLNXisFmAeOg@mail.gmail.com>
 <87o8ld0zwt.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8ld0zwt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>, Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kernel list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 08, 2020 at 09:34:26PM +1100, Michael Ellerman wrote:
> Jann Horn <jannh@google.com> writes:
> > So while the mprotect() case
> > checks the flags and refuses unknown values, the mmap() code just lets
> > the architecture figure out which bits are actually valid to set (via
> > arch_calc_vm_prot_bits()) and silently ignores the rest?
> >
> > And powerpc apparently decided that they do want to error out on bogus
> > prot values passed to their version of mmap(), and in exchange, assume
> > in arch_calc_vm_prot_bits() that the protection bits are valid?
> 
> I don't think we really decided that, it just happened by accident and
> no one noticed/complained.
> 
> Seems userspace is pretty well behaved when it comes to passing prot
> values to mmap().

It's not necessarily about well behaved but whether it can have security
implications. On arm64, if the underlying memory does not support MTE
(say some DAX mmap) but we still allow PROT_MTE driven by user, it will
lead to an SError which brings the whole machine down.

Not sure whether ADI has similar requirements but at least for arm64 we
addressed the mmap() case as well (see my other email on the details; I
think the approach would work on SPARC as well).

-- 
Catalin
