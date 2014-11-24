From: mroos@linux.ee
Date: Mon, 24 Nov 2014 22:23:20 +0000
Subject: Re: Another (ESP?) scsi blk-mq problem on sparc64
Message-Id: <alpine.LRH.2.11.1411250022470.31497@siim2.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1411150829190.26813@adalberg.ut.ee> <546771B4.1010507@kernel.dk> <20141120060135.GA2862@infradead.org> <20141121.145600.2001813891553289235.davem@davemloft.net> <20141124082132.GA22971@infradead.org> <54735052.7020807@kernel.dk>
 <20141124162249.GG5050@linux.vnet.ibm.com> <547367DF.5060706@kernel.dk>
In-Reply-To: <547367DF.5060706@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: paulmck@linux.vnet.ibm.com, Christoph Hellwig <hch@infradead.org>, David Miller <davem@davemloft.net>, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

> > > > Yes, that does look like the case.  Do you have a good trick on how
> > > > to allocate a map for the highest possible cpu number without first
> > > > iterating the cpu map?  I couldn't find something that looks like a
> > > > highest_possible_cpu() helper.
> > >
> > > Honestly I think that num_posible_cpus() should return the max of
> > > number of CPUs (weigt), and the highest numbered CPU. It's a pain in
> > > the butt to handle this otherwise.
> >
> > Hear, hear!!!  That would make my life easier, and would make this sort
> > of problem much less likely to occur!
> 
> How about this one?

It make the machine work.

-- 
Meelis Roos (mroos@linux.ee)
