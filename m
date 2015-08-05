From: Meelis Roos <mroos@linux.ee>
Date: Wed, 05 Aug 2015 20:35:48 +0000
Subject: Re: Occasional userland crashes on sparc in 4.1.0+
Message-Id: <alpine.LRH.2.20.1508052334480.9527@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507271430410.23956@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1507271430410.23956@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> While compiling 4.2-rc3 on my test machines, I got segfaults during 
> compilation on V240 and V440. Running repeated compilations encountered 
> some more of these, on both 4.1.0 and 4.2-rc3.
> 
> At the first glance, no UltraSparc II machines had this but I have not 
> done any more stresstesting on them.

Reconnected and tested my Ultra 1, with problems:

[63949.058730] resolvconf[11593]: segfault at 3860 ip 00000000f7c4e790 (rpc 00000000f7c4e714) sp 00000000fffeaf60 error 30001 in libc-2.19.so[f7b98000+16a000]
[63949.389191] BUG: Bad rss-counter state mm:fffff800335b4440 idx:1 val:1
[63949.465567] BUG: non-zero nr_ptes on freeing mm: 1

This was with 4.1.0 while compiling newer git release.

-- 
Meelis Roos (mroos@linux.ee)
