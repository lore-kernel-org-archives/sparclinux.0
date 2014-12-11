From: David Miller <davem@davemloft.net>
Date: Thu, 11 Dec 2014 20:27:28 +0000
Subject: Re: ixgbe/linux/sparc perf issues
Message-Id: <20141211.152728.235162264275690317.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141211194542.GA5536@oracle.com>
In-Reply-To: <20141211194542.GA5536@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 11 Dec 2014 15:24:17 -0500 (EST)

> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Thu, 11 Dec 2014 15:21:00 -0500
> 
>> All this may be true, but it would also be true for Solaris, which
>> manages to do line-speed (for the exact same setup), so there must be
>> some other bottleneck going on? 
> 
> They have DMA mapping interfaces which pre-allocate large batches
> of mapping at a time.

BTW, Solaris also does things which are remotely exploitable, so
these optimizations that get them "line rate" have a serious cost.

In their NIU driver, the recycle all buffers in an RX queue rather
than allocating new buffers.

This means that a maliciously running TCP application can read a lot
of data from a bulk sender, then simply stop reading completely.

This will put the entire RX queue of packets in limbo in the TCP
stack, which will never be recycled back to the NIU driver, thus
stalling all traffic completely which steers to that RX queue.

So that, is how Solaris gets "line rate" with this kind of hardware.
