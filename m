From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 11 Dec 2014 20:21:00 +0000
Subject: Re: ixgbe/linux/sparc perf issues
Message-Id: <20141211202100.GD5536@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141211194542.GA5536@oracle.com>
In-Reply-To: <20141211194542.GA5536@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (12/11/14 15:09), David Miller wrote:
> 
> The real overhead is unavoidable due to the way the hypervisor access
> to the IOMMU is implemented in sun4v.
> 
> If we had direct access to the hardware, we could avoid all of the
> real overhead in %99 of all IOMMU mappings, as we do for pre-sun4v
> systems.
> 
> On sun4u systems, we never flush the IOMMU until we wrap around
> the end of the IOMMU arena to the beginning in order to service
> an allocation.
> 
> Such an optimization is impossible with the hypervisor call interface
> in sun4v.
> 
> I've known about this issue for a decade and I do not think there is
> anything we can really do about this.

All this may be true, but it would also be true for Solaris, which
manages to do line-speed (for the exact same setup), so there must be
some other bottleneck going on? 

And fwiw, removing the iommu lock contention out of lockstat
did not make any difference to the throughput, which seems to indicate
that the bottleneck is elsewhere. Hence the question about the
ixgbe stats, and tuning that I may be missing.

--Sowmini

