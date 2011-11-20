From: David Miller <davem@davemloft.net>
Date: Sun, 20 Nov 2011 18:14:49 +0000
Subject: Re: 3.2.0-rc2-00143: kernel BUG at block/blk-core.c:1000! Kernel
Message-Id: <20111120.131449.1310657431272918602.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1111201901250.21968@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1111201901250.21968@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 20 Nov 2011 19:11:39 +0200 (EET)

> This is 3.2.0-rc2-00143-ga767835 on Sun Ultra 10, previously running 
> 3.1.0 fine. Similar Ultra 5 with ATA disk booted up fine but again, it 
> has different configuration. config on the U10 also included below.

Please don't assume that every crash you encounter on sparc is a sparc
specific bug.

Therefore, it's a good idea to report this not just to sparclinux, but
also to the block layer et al.  maintainers, as well as lkml.

Thanks.
