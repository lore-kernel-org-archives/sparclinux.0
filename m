From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 09 Aug 2005 20:31:26 +0000
Subject: Re: [PATCH] use kthread infrastructure in envctrl
Message-Id: <20050809.133126.03088922.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050809135128.GA22257@lst.de>
In-Reply-To: <20050809135128.GA22257@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 9 Aug 2005 22:28:59 +0200

> Sure.  While we're at it, is there a specific reason various sbus
> drivers reimplement i2c functionality instead of using the common
> code?

There wer no suitable i2c client registry, sharing, and
mutual exclusion facilities in the i2c layer at the time.
That has, of course, changed.

Another problem is that the device probing this driver
wants to do is via the string names that are in the
firmware device tree, and the i2c layer has no way for
me to really plug in that stuff.

Anyways, I'll apply this patch, thanks a lot.
