From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Oct 2014 16:26:02 +0000
Subject: Re: Kernel unaligned access in kmem_cache_free, free_block, kmem_cache_alloc, cache_alloc_refill
Message-Id: <alpine.LRH.2.11.1410121854500.22151@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410121447210.22151@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410121447210.22151@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I updated my T2000 to todays upstream git to test all the new code. It 
> seems to work fine so far but logs a lot of kernel unaligned accesses. 

Similar results for for V100, Ultra 5 - seems to mostly work, many 
unaligned access dmesg lines, occassional Bus Error from userspace code.

For my E420R, U2 something is more broken - I can SSH in but I am 
disconnected before getting any command prompt.

E220R did not boot up so no SSH there.

On E3500, I get some unaligned access warnings and then
networking[1265]: segfault at 107ef8 ip 00000000000681c8 (rpc 00000000000681a8) sp 00000000ffddbd88 error 30002 in bash[10000+da000]
Maybe this is related to my sudden logouts from other machines.

For Blade 100, I do not see the warnings and it seems to work just fine 
(RED state exception is gone for it too). Maybe the difference is in my 
kernel configurations...

-- 
Meelis Roos (mroos@linux.ee)
