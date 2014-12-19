From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 15:11:08 +0000
Subject: Re: ixgbe/linux/sparc perf issues
Message-Id: <20141219151108.GA25248@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141211194542.GA5536@oracle.com>
In-Reply-To: <20141211194542.GA5536@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (12/12/14 11:16), Sowmini Varadhan wrote:
> 
> But getting back to linux, 3 Gbps is a far cry from 10 Gbps.
> I need to spend some time collecting data to convince myself that
> this is purely because of HV/IOMMU inefficiency.
> 

[e1000-devel has been Bcc'ed]

I collected the stats, and  I have evidence that the HV is not the
bottleneck at this point:

I am running linux as the Tx side (TCP client) with 10 threads 
(iperf -c <addr> -P 10) against an iperf server that can handle
9-9.5 Gbps. 

  Baseline:
   with default settings (TSO enabled) :    9-9.5 Gbps
   Disable TSO using ethtool- drops badly:  2-3 Gbps.  (!)

  With iommu patch to break monolithic lock: 8.5 Gbps. (Note: with no TSO!)
  
I'll share the iommu patch as an RFC in a separate email to sparclinux.

But the Rx side may have other bottle-necks: even with the iommu
patch, it is stuck at 3 Gbps, though I can get something a bit
better merely by disabling GRO (as recommended by intel.com documentation), 
so 3 Gbps is probably not the ceiling here.

I am willing to believe that you can't do much better than
approx 8.5 Gbps without additional churn to the DMA design.
But 3 Gbps Rx out of a max of 10 Gbps suggests that something 
other than the HV is holding linux/sparc/Rx back. 

And it might not even be the DMA overhead, since Tx can pull 8.5 Gbps
even with a map/unmap for each packet. I'm still investigating the Rx
side, but there are a lot of factors here, with RPS, qdisc, etc all
coming into play. Suggestions for things to investigate are welcome.

--Sowmini


