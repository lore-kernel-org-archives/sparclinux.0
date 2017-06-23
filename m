From: David Miller <davem@davemloft.net>
Date: Fri, 23 Jun 2017 18:46:53 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170623.144653.1066722769974211175.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
In-Reply-To: <20170531193431.GA26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Botcazou <ebotcazou@libertysurf.fr>
Date: Fri, 23 Jun 2017 19:50:17 +0200

>> Thanks for the explanation. We're now just disabling cilk on Debian
>> for gcc-7 and gcc-snapshot for the time being.
> 
> I just fixed the problem on the mainline and 7 branch:
>   https://gcc.gnu.org/ml/gcc-patches/2017-06/msg01818.html
> 
> The testsuite now flawlessly passes at -j32 for me.
> 
>> Ok, I hope that will help the kernel guys to figure out what the
>> problem is.
> 
> libcilkrts does low-level fiddling with the stack pointer and threads, and 
> overlooked the stack bias in 64-bit mode.  This resulted in reproducible hangs 
> for some tests of the testsuite and I guess that a high level of parallelism 
> led to a form of congestion somewhere; I'm afraid I can't say more.

Unaligned stack accesses, which is what I can gather was going on looking
at your fix, could point to a myriad of areas where bugs could live.

If somehow the stack pointer itself got misaligned, we could be looking
at a window spill/fill bug or similar.

I'll try to see if I can figure out what might have gone wrong.  It could
simply be a bug in the unaligned memory access trap handler.
