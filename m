From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Nov 2014 19:42:40 +0000
Subject: Re: Another (ESP?) scsi blk-mq problem on sparc64
Message-Id: <54665B30.4070708@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1411141302270.26966@adalberg.ut.ee> <20141114165804.GA14631@infradead.org> <alpine.LRH.2.11.1411142114200.26813@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1411142114200.26813@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>, Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On 11/14/2014 12:35 PM, Meelis Roos wrote:
>> Paul, what's the best way to figure out these CPU stalls?
>>
>> The second oops is in blk_mq_map_queue() which is a trivial
>> two level cpu lookup.  I wonder if there's something odd about
>> cpu numbers on these big old sparc systems?
> 
> CPU numbers are sparse - they are determined by hardware slot number and 
> some models only fill every other mainboard slot, and first slots can be 
> free. I have first board offline and currently have CPUs numbered 
> 10,11,14,15 online.
>  
> Here is debug with Jens's patch:

> [  133.971050] CPU 11: synchronized TICK with master CPU (last diff -1 cycles, maxerr 516 cycles)
> [  133.975491] CPU 14: synchronized TICK with master CPU (last diff -3 cycles, maxerr 531 cycles)
> [  133.979943] CPU 15: synchronized TICK with master CPU (last diff -3 cycles, maxerr 531 cycles)
> [  133.980146] Brought up 4 CPUs

So this looks like this might be the issue. On a scsi-mq disabled boot,
you have 4 CPUs, but how are they numbered?

We might need Christophs debug patch on top this to fully know...

-- 
Jens Axboe

