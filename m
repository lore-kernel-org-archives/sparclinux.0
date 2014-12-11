From: David Miller <davem@davemloft.net>
Date: Thu, 11 Dec 2014 20:24:17 +0000
Subject: Re: ixgbe/linux/sparc perf issues
Message-Id: <20141211.152417.1570056993235495227.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141211194542.GA5536@oracle.com>
In-Reply-To: <20141211194542.GA5536@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 11 Dec 2014 15:21:00 -0500

> All this may be true, but it would also be true for Solaris, which
> manages to do line-speed (for the exact same setup), so there must be
> some other bottleneck going on? 

They have DMA mapping interfaces which pre-allocate large batches
of mapping at a time.

> And fwiw, removing the iommu lock contention out of lockstat
> did not make any difference to the throughput, which seems to indicate
> that the bottleneck is elsewhere.

Like I said, it's in the hypervisor IOMMU interfaces implementing
the hardware accesses to flush the hardware and adjust the DMA
mappings.

The lock just shows because the overhead "bubbles" up to the closest
non-hypervisor code.
