From: David Miller <davem@davemloft.net>
Date: Fri, 20 May 2011 18:24:19 +0000
Subject: Re: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <20110520.142419.1994883356079448773.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB68838.1020304@gaisler.com>
In-Reply-To: <4DB68838.1020304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 20 May 2011 16:22:33 +0200

> I agree that it is a better solution in that case and in other cases
> too. The problem will be for me to write a PCI Library in the limited
> context of the PROM, it is much more complex that writing a PCI host
> driver. The non-free PCI specification alone is heavy, compatibility
> between PCI revisions and then there is the bridge
> specification... ugg, I will probably have to leave that to the next
> generation :)

I guess if it's really that bad we can merge your PCI changes for
now, please resubmit them.
