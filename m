From: Bob Breuer <breuerr@mc.net>
Date: Wed, 09 Mar 2011 06:37:22 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <4D772022.5030804@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Marcel van Nies wrote:
> Hi,
> 
>> One large possibility is that there is a missing cache flush somewhere,
>> and reverting the memcpy/memset change masks it.
> 
> 2.6.33.7 with reverted commit is fine too, still leaving
> 2.6.34 - 2.6.38 for introducing weird behavior.
> 
> 
> 
> I've got 3 kinds of SPARC32 here, and the big difference is CPU.
> All other hardware in the boxes is "the same".
> The software (kernel et.al.) is pretty much the same too.
> Everything is ok, except for hyperSPARC.
> 
> So what makes the difference? This one :
> [    0.000000] Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz).
>  Patching kernel for srmmu[ROSS HyperSparc]/iommu
> 
> Combine that with srmmu_fault as in
> init[1]: segfault at 0 ip 5000dac8 (rpc f000eea8) spefe738a0 error
> 30001 in ld-2.3.5.so[50000000+1a000]
> Kernel panic - not syncing: Attempted to kill init!
>  [f002ed74 : do_group_exit+0x84/0xb4 ]
>  [f0039a24 : get_signal_to_deliver+0x338/0x35c ]
>  [f0011fbc : do_signal+0x30/0x914 ]
>  [f00128b4 : do_notify_resume+0x14/0x38 ]
>  [f000fd50 : signal_p+0x14/0x24 ]
>  [f000eea8 : srmmu_fault+0x58/0x68 ]
> 
> I start thinking there is something wrong with Jakub's srmmu patch for
> hyperSPARC...

No, hyperSparc just accesses it's data cache in a peculiar way.  It is
1-way virtually indexed, so when you map the same physical page to 2
different virtual addresses, you can actually end up with 2 different
cache lines being used simultaneously for the same chunk of physical
memory.  This is known as cache-aliasing.  SuperSparc accesses it's
cache using the physical address and doesn't suffer from the same problem.

Bob

