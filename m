From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 18:40:51 +0000
Subject: Re: [PATCH] remove alloc_user_space()
Message-Id: <20051107.104051.01454646.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107040520.GA16485@lst.de>
In-Reply-To: <20051107040520.GA16485@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 05:05:20 +0100

> this inline routine in arch/sparc64/kernel/ioctl32.c is completely
> unused and superceeded by compat_alloc_user_space()
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.
