From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 12 Dec 2014 16:16:33 +0000
Subject: Re: ixgbe/linux/sparc perf issues
Message-Id: <20141212161633.GA16340@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141211194542.GA5536@oracle.com>
In-Reply-To: <20141211194542.GA5536@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (12/11/14 15:27), David Miller wrote:
> 
> BTW, Solaris also does things which are remotely exploitable, so
> these optimizations that get them "line rate" have a serious cost.
> 
> In their NIU driver, the recycle all buffers in an RX queue rather
> than allocating new buffers.
> 
> This means that a maliciously running TCP application can read a lot
> of data from a bulk sender, then simply stop reading completely.

Just to set the record straight, without digressing too much into
Solaris internals..

Solaris follows the common practice used in such algorithms
of having thresholds on the number of loaned ("recycled") buffers for
this sort of thing, to avoid DoS attacks from malicious applications. 
When that threshold is crossed, the driver falls back to the slower
"allocate new buffers" path, so there is no stalling.

But getting back to linux, 3 Gbps is a far cry from 10 Gbps.
I need to spend some time collecting data to convince myself that
this is purely because of HV/IOMMU inefficiency.

Thanks,
--Sowmini



