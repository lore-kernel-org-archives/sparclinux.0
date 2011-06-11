From: David Miller <davem@davemloft.net>
Date: Sat, 11 Jun 2011 23:01:19 +0000
Subject: Re: [PATCH] PCI: Make the struct pci_dev * argument of
Message-Id: <20110611.160119.176399204911265689.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110610143021.GA26043@linux-mips.org>
In-Reply-To: <20110610143021.GA26043@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 10 Jun 2011 15:30:21 +0100

> Aside of the usual motivation for constification,  this function has a
> history of being abused a hook for interrupt and other fixups so I turned
> this function const ages ago in the MIPS code but it should be done
> treewide.
> 
> Due to function pointer passing in varous places a few other functions
> had to be constified as well.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: David S. Miller <davem@davemloft.net>
