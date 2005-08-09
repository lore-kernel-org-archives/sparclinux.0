From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 09 Aug 2005 21:38:15 +0000
Subject: Re: [PATCH] remove ifdef CONFIG_PCI from envctrl.c
Message-Id: <20050809.143815.69242464.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050809203118.GA28805@lst.de>
In-Reply-To: <20050809203118.GA28805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 9 Aug 2005 22:31:19 +0200

> The driver already depends on CONFIG_PCI in Kconfig.  What I don't quite
> understand yet is why a PCI-only driver sits in drivers/sbus/ ..

There really isn't any place to put odd sparc drivers
other then drivers/sbus/char, especially since we still
don't use drivers/char/Kconfig

I hope to fix this kind of stuff at some point.  It is
ugly, indeed.

I'll apply your patch, thanks.

