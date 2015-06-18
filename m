From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 18 Jun 2015 09:11:08 +0000
Subject: Re: How to compile glibc?
Message-Id: <20150618091108.GA3798@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1506181135370.27402@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1506181135370.27402@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jun 18, 2015 at 11:45:13AM +0300, Meelis Roos wrote:
> I read DeaveM's post about upstream glibc probably having working 
> optimizations for post-ultrasparcIII CPUs and decided that I should give 
> the latest upstream glibc a try.
> 
> However, I do not understand how should I configure it for mostly-32-bit 
> Debian but with optimized versions for different CPUs.

Maybe examine Debian glibc package source debian/rules file?

-- 
     2. That which causes joy or happiness.
