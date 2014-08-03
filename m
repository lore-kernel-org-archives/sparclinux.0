From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 03 Aug 2014 12:58:36 +0000
Subject: Re: [PATCH] Prevent flushing of locked PROM ITLB entry (RED State Exception or hang on reboot)
Message-Id: <201408031458.36790.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271539.40156.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271539.40156.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 29 July 2014 01:02, David Miller wrote:
> From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
> Date: Sun, 27 Jul 2014 15:39:39 +0200
> 
> As mentioned for your previous two patches, please format your Subject
> line properly, and provide a proper "Signed-off-by: " tag.
> 
[snip]
> 
> There are stylistic problems with your change, but I would also really
> like to know who calls flush_tlb_kernel_range() for an area covering
> the firmware's protected area?
> 
> That's where the bug more likely is.

Yes, I am aware that the patch in the preprocessor define is not really
good style, and the patch should perhaps be pushed higher or lower in the
call chain. I decided to send what I had, however, as I am currently unable
to test modified patches due to lack of access to a Sun machine. (I do not
even have a SPARC64 cross toolchain, so I cannot validate any changes to my
original patches...)

> There are only calls to this function from outside of the sparc code, first:
> 
> mm/highmem.c
> 
> which is not relevant because sparc64 doesn't use highmem, and then we have:
> 
> mm/percpu-vm.c
> mm/vmalloc.c
> 
> So it has to be one of the calls in these two files causing the problem.

Fortunately, I have the call trace ending in the problematic call of
flush_tlb_kernel_range() at hand:

	__purge_vmap_area_lazy()
	free_vmap_area_noflush()
	remove_vm_area()
	__vunmap()
	n_tty_close()
	tty_ldisc_close()
	tty_ldisc_kill()
	tty_ldisc_release()
	tty_release()
	__fput()
	task_work_run()
	__handle_signal()

__purge_vmap_area_lazy() is in mm/vmalloc.c, as is __vunmap(). The line
discipline part is mostly irrelevant, but may be interesting, as I remember
having read on this mailing list that others tracked the reboot problem to
memory allocation changes in the ldisc layer. These changes may have
initially triggered the problematic __vunmap() call that kills the locked
PROM mapping.

The range to be flushed was

	[0x0000'0000'1000'6000, 0x0000'0001'0272'8000]

and this crosses the PROM area.

The LITLB entry (as read from the diagnostic ASI) was

	TAG:	0x0000'0000'f000'0000 -> VA: 0x0000'0000'f000'0000, CTX: 0
	DATA:	0xc000'0000'3ff8'0064 -> PA: 0x0000'0000'3ff8'0000, SZ: 512 kB, locked, priv, R/O, not global

> For the vmalloc case that would be odd, since we clearly define the VMALLOC
> range to be outside of the firmware's special range:
> 
> #define VMALLOC_START		_AC(0x0000000100000000,UL)
> #define VMALLOC_END		_AC(0x0000010000000000,UL)

Yes, but this "lazy flushing" seems to accumulate regions to be
flushed, and while each individual region does not cross the PROM
region, the "combined region" does so, and there was no check for this
situation and to split the "lazy flushing" into two calls to exclude
the PROM area from flushing.

It seems that the region to be flushed is a combination of a kernel
module allocation (below the PROM area) and a vmalloc allocation
(above the PROM area).

> >  #define flush_tlb_kernel_range(start,end) \
> > -do {   flush_tsb_kernel_range(start,end); \
> > -       __flush_tlb_kernel_range(start,end); \
> > +do { \
> > +       if((start < 0x100000000UL) && (end > 0xf0000000)) { \
> 
> Space between "if" and "(" please.  Also, please use the existing macros
> LOW_OBP_ADDRESS and HI_OBP_ADDRESS instead of magic address values.
> 
> > +               if(start < 0xf0000000) { \
> 
> Likewise.
> 
> > +                         flush_tsb_kernel_range(start, 0xf0000000); \
> > +                       __flush_tlb_kernel_range(start, 0xf0000000); \
> 
> These are indented differently, they should be on the same column, and
> please use TAB characters.
> 
> >  #define flush_tlb_kernel_range(start, end) \
> > -do {   flush_tsb_kernel_range(start,end); \
> > -       smp_flush_tlb_kernel_range(start, end); \
> > +do { \
> 
> Likewise for all of this macro too.

I will send reformatted patches shortly. However, I think that these checks
should be moved to somewhere else, as I do not regard bloating these
preprocessor defines is really good style. (The original patch was meant as
a hint what happened and needs to be changed, it was not meant to be merged
exactly in the form as presented.)

Regards,
Alexander Schulze
