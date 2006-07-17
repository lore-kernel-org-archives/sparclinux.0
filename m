From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2006 03:15:30 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <20060716.201530.28791088.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marc Zyngier <maz@misterjones.org>
Date: Sun, 16 Jul 2006 17:44:37 +0200

> For reference (and debugging), I'm including both interrupt-map and
> interrupt-map-mask, just in case it might be usefull.
> 
> root@positive:/proc/openprom/pci@1f,4000# cat interrupt-map
> 00000800.00000000.00000000.00000002.f006d1b0.00000021.00001000.00000000.00000000.00000001.f006d1b0.00000010.00001000.00000000.00000000.00000002.f006d1b0.00000011.00001000.00000000.00000000.00000003.f006d1b0.00000012.00001000.00000000.00000000.00000004.f006d1b0.00000013.00001800.00000000.00000000.00000001.f006d1b0.00000020.00001900.00000000.00000000.00000001.f006d1b0.00000026.00002000.00000000.00000000.00000001.f006d1b0.00000018.00002000.00000000.00000000.00000002.f006d1b0.00000019.00002000.00000000.00000000.00000003.f006d1b0.0000001a.00002000.00000000.00000000.00000004.f006d1b0.0000001b.00002800.00000000.00000000.00000001.f006d1b0.0000001c.00002800.00000000.00000000.00000002.f006d1b0.0000001d.00002800.00000000.00000000.00000003.f006d1b0.0000001e.00002800.00000000.00000000.00000004.f006d1b0.0000001f
> root@positive:/proc/openprom/pci@1f,4000# cat interrupt-map-mask 
> 00fff800.00000000.00000000.00000007
> 
> As usual, I'll be happy to test any idea you may have to solve this
> problem.

The problem is that aparently only the IRQ routing information for
the PCI expansion slots is listed in the interrupt-map property.
Therefore you need to calculate the INO by hand.

I'll try to cook something up, thanks for the debugging info.
