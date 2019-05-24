From: Rick Edgecombe <redgecombe.lkml@gmail.com>
Date: Fri, 24 May 2019 14:26:06 +0000
Subject: Re: More logging (was: vmalloc: Fix issues with flush flag)
Message-Id: <CAF44hAHFy6EVbb_1Pd6whb0eLUL6YhqOJ1_nRUVShuaAkTa56A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <23e053dc-47ff-d113-22f0-5497c7fa8227@linux.ee>
In-Reply-To: <23e053dc-47ff-d113-22f0-5497c7fa8227@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 24, 2019 at 1:20 AM Meelis Roos <mroos@linux.ee> wrote:
> I do not remember trying DEBUG_PAGEALLOC before on any sparcs (though I have had a
> problem with thet on some strange old machine that might or might not have been a sparc).
>
> To actually bisect it requires a known good kernel DEBUG_PAGEALLOC it worked.
> Will try to find one - hopefully it is not in too distant past.
>
> So the conclusion is that your patch just triggers a bug that is there even before
> and DEBUG_PAGEALLOC hits the same bug? Myabe just DEBUG_PAGEALLOC is broken before, so
> thet would make two independent bugs - how do we know it's the same bug?
>
That's a good point, I suppose it doesn't conclusively rule out it's
not two different bugs. I think think they very likely have the same
root cause because so much lines up though. A previous log you sent
showed that where this hangs was at the point of the first vfree,
which with DEBUG_PAGEALLOC on, would call flush_tlb_kernel_range() on
the address range of the vmalloc allocation. Doing the a flush for
only certain vfrees() is essentially what my patch does and in
addition we tested a version that mirrored the DEBUG_PAGEALLOC flush
address range and it still hung. So same actions, same results.
Although if you want to send me the logs from the logging patch I had
sent Monday I can see if anything weird is in there.
