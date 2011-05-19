From: David Miller <davem@davemloft.net>
Date: Thu, 19 May 2011 19:01:04 +0000
Subject: Re: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <20110519.150104.2238099001903931599.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB68838.1020304@gaisler.com>
In-Reply-To: <4DB68838.1020304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 19 May 2011 15:13:14 +0200

> The PowerPC for example assign resources
> (arch/powerpc/kernel/pci-common.c), and PowerPC may also have a
> OpenBoot loader:

On some powerpc systems, like sparc64 Niagara, you can't blindly go
poking around the PCI config space at all and must rely completely
and entirely upon the OpenBoot device tree.

The support you see there is for older and embedded systems.

