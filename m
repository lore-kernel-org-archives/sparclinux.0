From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 18 Aug 2005 18:34:12 +0000
Subject: Re: current_thread_info_reg undefined
Message-Id: <20050818.113412.73934426.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 18 Aug 2005 14:50:31 +0300 (EEST)

> Todays 2.6.13-rc6+git tree has broken many modules with warning like 
> this on sparc64:
> *** Warning: "current_thread_info_reg" [drivers/net/ppp_deflate.ko] undefined!
> 
> These warnings don't go away after make clean.

What does the compiler spit out when drivers/net/ppp_deflate.o
is being built?

It is declared in include/asm-sparc64/thread_info.h quite plainly:

register struct thread_info *current_thread_info_reg asm("g6");

I've seen this before, but I have no idea why it keeps coming up
or what causes it as I've never triggered it myself.

Perhaps it's toolchain dependent, thus some binutils or gcc
bug.
