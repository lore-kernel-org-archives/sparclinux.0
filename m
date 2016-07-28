From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2016 05:53:35 +0000
Subject: Re: [patch] sparc32: off by ones in BUG_ON()
Message-Id: <20160727.225335.1873128652868360558.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160715110533.GA9258@mwanda>
In-Reply-To: <20160715110533.GA9258@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 15 Jul 2016 14:05:33 +0300

> Smatch complains that these tests are off by one, which is true but not
> life threatening.
> 
> 	arch/sparc/kernel/irq_32.c:169 irq_link()
> 	error: buffer overflow 'irq_map' 384 <= 384
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks Dan.
