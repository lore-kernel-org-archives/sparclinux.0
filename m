From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 16 May 2015 15:28:23 +0000
Subject: Re: [PATCH 0/3] PCI/sparc: Fix booting with T5-8
Message-Id: <20150516152823.GK31666@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <20150516152537.GJ31666@google.com>
In-Reply-To: <20150516152537.GJ31666@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 16, 2015 at 10:25:37AM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 31, 2015 at 07:57:46PM -0700, Yinghai Lu wrote:
> > Fix regression by commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to
> > fit in upstream windows").
> > 
> > That cause bridge bar get clipped wrongly.
> > 
> > The sparc64 dma_addr_t is 32-bit, we can not use it to check if we can
> > use 64bit bar, introduce pci_bus_addr_t.
> > 
> > sparc ofpci does not parse 64bit mem for root bus, add code to
> > make sure that we get correct resource for root.
> > 
> > Also there are device 64-bit res does not have pref bit flag, but bridges
> > do have pref bit set, that cause extra "no compatible window".
> > Set pref bit for them according to the errata.
> 
> Ping, any updates on this?  AFAICT, we should add a new pci_bus_addr_t
> distinct from dma_addr_t, but Ben raised an issue that needs to be
> resolved first.

BTW, if it makes sense to add pci_bus_addr_t first, without the other
sparc64/prefetchability changes, that's fine with me.  But I think there
were some doc and maybe Kconfig updates related to that, so please fold
those in and repost it.

Bjorn
