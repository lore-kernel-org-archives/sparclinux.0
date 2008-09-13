From: David Miller <davem@davemloft.net>
Date: Sat, 13 Sep 2008 01:18:39 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <20080912.181839.170684529.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 18:02:17 -0700 (PDT)

> Niagara T1 is a single "package", with 8 "cores".
> 
> Look at a dump from a multi-socket Niagara T2 system.

BTW, I think I see where your confusion comes from.

We're using core_id and proc_id to represent the physical
internal layout of the cpu in order to guide the scheduling
domain construction.

It doesn't really parallel the conceptual things you think
these values should represent.

On Niagara-T1, the cpu internally has equal resources available
for all virtual cpus within a core.  That's why core_id and
proc_id follow eachother in sequence.

But on Niagara-T2 there are two integer units available amongst
the 8 per-core virtual cpus.

And _that_ is what these values are meant to represent.

For example, on Niagara-T2:

	core_id		proc_id
cpu0:	1		0
cpu1:	1		0
cpu2:	1		0
cpu3:	1		0
cpu4:	1		1
cpu5:	1		1
cpu6:	1		1
cpu7:	1		1

This tells the scheduler to evenly distribute processes inside of this
core between the first 4 virtual cpus and the last 4 virtual cpus.

I hope this clarifies things.
