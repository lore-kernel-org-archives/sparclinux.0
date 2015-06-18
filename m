From: Meelis Roos <mroos@linux.ee>
Date: Thu, 18 Jun 2015 08:45:13 +0000
Subject: How to compile glibc?
Message-Id: <alpine.LRH.2.11.1506181135370.27402@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I read DeaveM's post about upstream glibc probably having working 
optimizations for post-ultrasparcIII CPUs and decided that I should give 
the latest upstream glibc a try.

However, I do not understand how should I configure it for mostly-32-bit 
Debian but with optimized versions for different CPUs.

--host=sparc64-linux-gnu or --host=sparc-linux-gnu?

--enable-multiarch probably?


And the following creates 64-bit libs only.

CC="sparc-linux-gnu-gcc -m64" CXX="sparc-linux-gnu-g++ -m64" 
../glibc/configure --enable-multi-arch --enable-add-ons=libidn,nptl

-- 
Meelis Roos (mroos@linux.ee)
