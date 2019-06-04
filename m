From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 04 Jun 2019 12:38:00 +0000
Subject: Re: [PATCH v2] uaccess: add noop untagged_addr definition
Message-Id: <20190604123759.GA6610@arrakis.emea.arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
 <20190604122841.GB15385@ziepe.ca>
In-Reply-To: <20190604122841.GB15385@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>, sparclinux@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>, Dmitry Vyukov <dvyukov@google.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-arm-kernel@lists.infradead.org, Kostya Serebryany <kcc@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yishai Hadas <yishaih@mellanox.com>, linux-kernel@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, Lee Smith <Lee.Smith@arm.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, enh <enh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christian Koenig <Christian.Koenig@amd.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, Jun 04, 2019 at 09:28:41AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2019 at 02:04:47PM +0200, Andrey Konovalov wrote:
> > Architectures that support memory tagging have a need to perform untagging
> > (stripping the tag) in various parts of the kernel. This patch adds an
> > untagged_addr() macro, which is defined as noop for architectures that do
> > not support memory tagging. The oncoming patch series will define it at
> > least for sparc64 and arm64.
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >  include/linux/mm.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0e8834ac32b7..dd0b5f4e1e45 100644
> > +++ b/include/linux/mm.h
> > @@ -99,6 +99,17 @@ extern int mmap_rnd_compat_bits __read_mostly;
> >  #include <asm/pgtable.h>
> >  #include <asm/processor.h>
> >  
> > +/*
> > + * Architectures that support memory tagging (assigning tags to memory regions,
> > + * embedding these tags into addresses that point to these memory regions, and
> > + * checking that the memory and the pointer tags match on memory accesses)
> > + * redefine this macro to strip tags from pointers.
> > + * It's defined as noop for arcitectures that don't support memory tagging.
> > + */
> > +#ifndef untagged_addr
> > +#define untagged_addr(addr) (addr)
> 
> Can you please make this a static inline instead of this macro? Then
> we can actually know what the input/output types are supposed to be.
> 
> Is it
> 
> static inline unsigned long untagged_addr(void __user *ptr) {return ptr;}
> 
> ?
> 
> Which would sort of make sense to me.

This macro is used mostly on unsigned long since for __user ptr we can
deference them in the kernel even if tagged. So if we are to use types
here, I'd rather have:

static inline unsigned long untagged_addr(unsigned long addr);

In addition I'd like to avoid the explicit casting to (unsigned long)
and use some userptr_to_ulong() or something. We are investigating in
parallel on how to leverage static checking (sparse, smatch) for better
tracking these conversions.

-- 
Catalin
