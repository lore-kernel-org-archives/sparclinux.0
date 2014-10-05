From: Meelis Roos <mroos@linux.ee>
Date: Sun, 05 Oct 2014 21:33:42 +0000
Subject: Re: flush_tlb_kernel_range()
Message-Id: <alpine.DEB.2.03.1410051433230.8299@cyber.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141004.215318.642435987638821748.davem@davemloft.net>
In-Reply-To: <20141004.215318.642435987638821748.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> We've sort of always had this issue, but it is exacerbated by the
>> recent massive enlargening of the vmalloc area.
>
> Actually the expansion of the vmalloc area had nothing to do with
> this, and the problem exists without any of my patches applied.
>
> I've pushed the following to my GIT tree:
>
> ==========
> sparc64: Fix reversed start/end in flush_tlb_kernel_range()
>
> When we have to split up a flush request into multiple pieces
> (in order to avoid the firmware range) we don't specify the
> arguments in the right order for the second piece.
>
> Fix the order, or else we get hangs as the code tries to
> flush "a lot" of entries and we get lockups like this:

It seems to have fixed my Ultra 5 RED state exception on reboot - can not 
see console but todays Linux git + this patch now successfully reboots 
again - at least first time. However, second reboot from this kernel did 
not come up so I need to get to the machine to see the reason.

U1 RED state exception on reboot was also cured and U1 with todays git is 
working fine (just did debian unstable upgrade).

V100 previous recursive fault and recent endless recursive fault on reboot 
has also been cured.

Netra X1 where I also had the same problem as on V100 was not tested 
because its disk broke down.

Does no harm to working E250, U2 or T2000.

480R still dies with FATAL reset on bootup.

It seems to be slightly late to suggest it into 3.17 that has been already 
released... but the patch is good nevertheless, making multiple sparcs 
work again for me. Thank you!

-- 
Meelis Roos (mroos@linux.ee)
