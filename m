From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2009 08:18:33 +0000
Subject: Re: [PATCH] jsflash: stop defining MAJOR_NR
Message-Id: <20090304.001833.104882880.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 28 Feb 2009 22:22:35 +0100

> Ever since early 2.5 kernels block drivers don't need to define MAJOR_NR
> anymore, so use the JSFD_MAJOR defined directly and kill it.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks Christoph.
