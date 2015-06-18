From: David Miller <davem@davemloft.net>
Date: Thu, 18 Jun 2015 10:21:18 +0000
Subject: Re: How to compile glibc?
Message-Id: <20150618.032118.1100068885060514353.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1506181135370.27402@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1506181135370.27402@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 18 Jun 2015 11:45:13 +0300 (EEST)

> I read DeaveM's post about upstream glibc probably having working 
> optimizations for post-ultrasparcIII CPUs and decided that I should give 
> the latest upstream glibc a try.
> 
> However, I do not understand how should I configure it for mostly-32-bit 
> Debian but with optimized versions for different CPUs.
> 
> --host=sparc64-linux-gnu or --host=sparc-linux-gnu?

You want to use --target=sparcv9-linux-gnu and have multiarch
enabled and run the build under "sparc32 bash" environment where
'uname' returns plain 'sparc'.

For 64-bit builds I use just plain:

	CC="gcc -m64" CXX="g++ -m64" ./configure

