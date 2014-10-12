From: David Miller <davem@davemloft.net>
Date: Sun, 12 Oct 2014 16:32:45 +0000
Subject: Re: Kernel unaligned access in kmem_cache_free, free_block, kmem_cache_alloc, cache_alloc_refill
Message-Id: <20141012.123245.1488524303433014684.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410121447210.22151@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410121447210.22151@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Oct 2014 19:26:02 +0300 (EEST)

>> I updated my T2000 to todays upstream git to test all the new code. It 
>> seems to work fine so far but logs a lot of kernel unaligned accesses. 
> 
> Similar results for for V100, Ultra 5 - seems to mostly work, many 
> unaligned access dmesg lines, occassional Bus Error from userspace code.

Reported already:

	https://lkml.org/lkml/2014/10/11/223

No responses yet, so I'll take a closer look myself today.
