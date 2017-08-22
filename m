From: David Miller <davem@davemloft.net>
Date: Tue, 22 Aug 2017 16:31:39 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <20170822.093139.473720171751670244.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708212209280.31611@math.ut.ee>
	<20170821.133549.1817020810110297960.davem@davemloft.net>
	<20170822063505.GA6721@lst.de>
In-Reply-To: <20170822063505.GA6721@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: mroos@linux.ee, helgaas@kernel.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 Aug 2017 08:35:05 +0200

> On Mon, Aug 21, 2017 at 01:35:49PM -0700, David Miller wrote:
>> I ask because the commit log message indicates that this failure is
>> not expected to ever happen on SMP.
> 
> I fear my commit message (but not the code) might be wrong.
> irq_create_affinity_masks can return NULL any time we don't have any
> affinity masks.  I've already had a discussion about this elsewhere
> with Bjorn, and I suspect we need to kill the warning or move it
> to irq_create_affinity_masks only for genuine failure cases.

This is a rather large machine with 64 or more cpus and several NUMA
nodes.  Why wouldn't there be any affinity masks available?

That's why I want to root cause this.
