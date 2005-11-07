From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 18:45:18 +0000
Subject: Re: [PATCH] remove vuid_event.h
Message-Id: <20051107.104518.32435167.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107040747.GD16485@lst.de>
In-Reply-To: <20051107040747.GD16485@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 05:07:47 +0100

> I don't know if we ever implemented this, but the only user in any 2.6
> tree are the compat ioctls.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I think we did in the 2.0.x days, but yes it's dead kruft
now and we can kill it.

Applied, thanks.
