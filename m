From: David Miller <davem@davemloft.net>
Date: Thu, 11 Dec 2014 20:09:27 +0000
Subject: Re: ixgbe/linux/sparc perf issues
Message-Id: <20141211.150927.1736102096754532105.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141211194542.GA5536@oracle.com>
In-Reply-To: <20141211194542.GA5536@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 11 Dec 2014 14:45:42 -0500

> 1. lockstat and perf report that iommu->lock is the hot-lock (in a typical 
>    instance, I get about 21M contentions out of 27M acquisitions, 25 us
>    avg wait time). Even if I fix this issue (see below), I see:

The real overhead is unavoidable due to the way the hypervisor access
to the IOMMU is implemented in sun4v.

If we had direct access to the hardware, we could avoid all of the
real overhead in %99 of all IOMMU mappings, as we do for pre-sun4v
systems.

On sun4u systems, we never flush the IOMMU until we wrap around
the end of the IOMMU arena to the beginning in order to service
an allocation.

Such an optimization is impossible with the hypervisor call interface
in sun4v.

I've known about this issue for a decade and I do not think there is
anything we can really do about this.
