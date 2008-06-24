From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 24 Jun 2008 07:01:06 +0000
Subject: Re: [10 PATCHES] inline functions to avoid stack overflow
Message-Id: <20080624070106.GA32607@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net, Andrew Morton <akpm@linux-foundation.org>


* Mikulas Patocka <mpatocka@redhat.com> wrote:

> Hi
>
> Here I'm sending 10 patches to inline various functions.

( sidenote: the patches are seriously whitespace damaged. Please see
  Documentation/email-clients.txt about how to send patches. )

NAK on this whole current line of approach. One problem is that it 
affects a lot more than just sparc64:

> This patch has the worst size-increase impact, increasing total kernel 
> size by 0.2%.

[...]

> To give you some understanding of sparc64, every function there uses 
> big stack frame (at least 192 bytes). 128 bytes are required by 
> architecture (16 64-bit registers), 48 bytes are there due to mistake 
> of Sparc64 ABI designers (calling function has to allocate 48 bytes 
> for called function) and 16 bytes are some dubious padding.
>
> So, on sparc64, if you have a simple function that passes arguments to 
> other function it still takes 192 byte --- regardless of how simple 
> the function is. Tail-call may be used, but it is disabled in kernel 
> if debugging is enabled (Makefile: ifdef CONFIG_FRAME_POINTER 
> KBUILD_CFLAGS += -fno-omit-frame-pointer -fno-optimize-sibling-calls).
>
> The stack trace has 75 nested functions, that totals to at least 14400 
> bytes --- and it kills the 16k stack space on sparc. In the stack 
> trace, there are many function which do nothing but pass parameters to 
> other function. In this series of patches, I found 10 such functions 
> and turned them to inlines, saving 1920 bytes. Especially waking wait 
> queue is bad, it calls 8 nested functions, 7 of which do nothing. I 
> turned 5 of them to inline.

please solve this sparc64 problem without hurting other architectures.

also, the trace looks suspect:

> This was the trace:
>
> linux_sparc_syscall32
> sys_read
> vfs_read
> do_sync_read
> generic_file_aio_read
> generic_file_direct_io
> filemap_write_and_wait
> filemap_fdatawrite
> __filemap_fdatawrite_range
> do_writepages
> generic_writepages
> write_cache_pages
> __writepage
> blkdev_writepage
> block_write_full_page
> __block_write_fiull_page
> submit_bh
> submit_bio
> generic_make_request
> dm_request
> __split_bio
> __map_bio
> origin_map
> start_copy
> dm_kcopyd_copy
> dispatch_job
> wake
> queue_work
> __queue_work
> __spin_unlock_irqrestore
> sys_call_table
> timer_interrupt
> irq_exit
> do_softirq
> __do_softirq
> run_timer_softirq
> __spin_unlock_irq
> sys_call_table
> handler_irq
> handler_fasteoi_irq
> handle_irq_event
> ide_intr
> ide_dma_intr
> task_end_request
> ide_end_request
> __ide_end_request
> __blk_end_request
> __end_that_request_first
> req_bio_endio
> bio_endio
> clone_endio
> dec_pending
> bio_endio
> clone_endio
> dec_pending
> bio_endio
> clone_endio
> dec_pending
> bio_endio
> end_bio_bh_io_sync
> end_buffer_read_sync
> __end_buffer_read_notouch
> unlock_buffer
> wake_up_bit
> __wake_up_bit
> __wake_up
> __wake_up_common
> wake_bio_function
> autoremove_wake_function
> default_wake_function
> try_to_wake_up
> task_rq_lock
> __spin_lock
> lock_acquire
> __lock_acquire

if function frames are so large, why are there no separate IRQ stacks on 
Sparc64? IRQ stacks can drastically lower the worst-case stack footprint 
and only affect sparc64.

Also, the stack trace above seems to be imprecise (for example sys_read 
cannot nest inside an irq context - so it does not show 75 function 
frames) and there are no stack frame size annotations that could tell us 
exactly where the stack overhead comes from.

( Please Cc: me to future iterations of this patchset - as long as it
  still has generic impact. Thanks! )

	Ingo
