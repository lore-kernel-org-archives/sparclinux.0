From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 29 May 2019 21:00:10 +0000
Subject: Re: [bisected] DEBUG_PAGEALLOC hangs on sparc64
Message-Id: <896BE8F9-F2AF-4138-B44D-512C615B9910@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
In-Reply-To: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 29 May 2019, at 21:23, David Miller <davem@davemloft.net> wrote:
> 
> From: Meelis Roos <mroos@linux.ee>
> Date: Wed, 29 May 2019 22:08:26 +0300
> 
>> Bisecting led me to 4.9 merge window and this patch that broke it:
>> 
>> a74ad5e660a9ee1d071665e7e8ad822784a2dc7f is the first bad commit
>> commit a74ad5e660a9ee1d071665e7e8ad822784a2dc7f
>> Author: David S. Miller <davem@davemloft.net>
>> Date:   Thu Oct 27 09:04:54 2016 -0700
>> 
>>    sparc64: Handle extremely large kernel TLB range flushes more
>>    gracefully.
> 
> Thank you, I will take a close look at this ASAP.

Perhaps I'm being stupid, but the first hunk in xcall_flush_tlb_kernel_range
looks wrong to me. %g2 previously contained PAGE_SIZE-1, but is now clobbered
by the new srlx, setting %g2 to (aligned_end-aligned_start)>>18. If the
brnz %g2 is taken, %g2 gets overwritten, so it's not a problem, but if the
branch *isn't* taken, then %g2 is zero, so the add %g2, 1, %g2 in the delay
slot of the branch sets %g2 to 1. However, prior to this commit, %g2 would then
have had the value PAGE_SIZE, and the following code to do a page-by-page flush
assumes this, using it as the amount to step through. Rather than stepping
through page-by-page (with offset 0x20 to indicate nucleus), we will step
through the loop byte-by-byte, so some iterations will have low bit
combinations for things other than a nucleus page demap operation. This same
bug is replicated in the new __cheetah_xcall_flush_tlb_kernel_range.

Regards,
James
