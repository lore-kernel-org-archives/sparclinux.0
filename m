From: David Miller <davem@davemloft.net>
Date: Tue, 22 Aug 2017 16:52:09 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <20170822.095209.1371730017153863860.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170822063505.GA6721@lst.de>
	<20170822.093139.473720171751670244.davem@davemloft.net>
	<20170822163916.GA31671@lst.de>
In-Reply-To: <20170822163916.GA31671@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: mroos@linux.ee, helgaas@kernel.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 Aug 2017 18:39:16 +0200

> On Tue, Aug 22, 2017 at 09:31:39AM -0700, David Miller wrote:
>> > I fear my commit message (but not the code) might be wrong.
>> > irq_create_affinity_masks can return NULL any time we don't have any
>> > affinity masks.  I've already had a discussion about this elsewhere
>> > with Bjorn, and I suspect we need to kill the warning or move it
>> > to irq_create_affinity_masks only for genuine failure cases.
>> 
>> This is a rather large machine with 64 or more cpus and several NUMA
>> nodes.  Why wouldn't there be any affinity masks available?
> 
> The drivers only asked for two MSI-X vectors, and marked bost of them
> as pre-vectors that should not be spread.  So there is no actual
> vector left that we want to actually spread.

Ok, now it makes more sense, and yes the warning should be removed.


