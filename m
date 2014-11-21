From: David Miller <davem@davemloft.net>
Date: Fri, 21 Nov 2014 19:56:00 +0000
Subject: Re: Another (ESP?) scsi blk-mq problem on sparc64
Message-Id: <20141121.145600.2001813891553289235.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1411150829190.26813@adalberg.ut.ee>
	<546771B4.1010507@kernel.dk>
	<20141120060135.GA2862@infradead.org>
In-Reply-To: <20141120060135.GA2862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@infradead.org
Cc: axboe@kernel.dk, mroos@linux.ee, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, paulmck@linux.vnet.ibm.com

From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 19 Nov 2014 22:01:35 -0800

> On Sat, Nov 15, 2014 at 08:31:00AM -0700, Jens Axboe wrote:
>> My next move would be to add more debug to the CPU map setup and teardown,
>> so that we can verify that the map that is being used above has indeed been
>> setup. Unless Christoph has any ideas on what is going on here?
> 
> No good idea, but I'd sugges to debug cpu_to_queue_index how it could
> return such an out of bounds value.

I would suggest looking into the possibility that we allocate the memory
using the count of valid cpus, rather than the largest cpu number.

That's a common error that runs into problems with discontiguous
cpu numbering like Sparc sometimes has.
