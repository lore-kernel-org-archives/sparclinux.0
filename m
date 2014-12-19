From: David Miller <davem@davemloft.net>
Date: Fri, 19 Dec 2014 17:10:19 +0000
Subject: Re: ixgbe/linux/sparc perf issues
Message-Id: <20141219.121019.1796870559150903211.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141211194542.GA5536@oracle.com>
In-Reply-To: <20141211194542.GA5536@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 10:11:08 -0500

> I am running linux as the Tx side (TCP client) with 10 threads 
> (iperf -c <addr> -P 10) against an iperf server that can handle
> 9-9.5 Gbps. 
> 
>   Baseline:
>    with default settings (TSO enabled) :    9-9.5 Gbps
>    Disable TSO using ethtool- drops badly:  2-3 Gbps.  (!)
> 
>   With iommu patch to break monolithic lock: 8.5 Gbps. (Note: with no TSO!)
>   
> I'll share the iommu patch as an RFC in a separate email to sparclinux.
> 
> But the Rx side may have other bottle-necks: even with the iommu
> patch, it is stuck at 3 Gbps, though I can get something a bit
> better merely by disabling GRO (as recommended by intel.com documentation), 
> so 3 Gbps is probably not the ceiling here.

Thanks for looking into this.
