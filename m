From: David Miller <davem@davemloft.net>
Date: Wed, 23 May 2007 21:58:03 +0000
Subject: Re: [PATCH] sparc64: kill unused DIE_PAGE_FAULT enum value
Message-Id: <20070523.145803.131106247.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070515111325.GA5815@lst.de>
In-Reply-To: <20070515111325.GA5815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 15 May 2007 13:13:25 +0200

> sparc64 got rid of the pagefault notifiers, so the enum value for them
> can go away aswell.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks for catching this Christoph.
