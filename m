From: Elad Lahav <elahav@uwaterloo.ca>
Date: Sat, 13 Sep 2008 01:27:20 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <48CB16F8.6020600@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> But on Niagara-T2 there are two integer units available amongst
> the 8 per-core virtual cpus.
> 
> And _that_ is what these values are meant to represent.
> 
> For example, on Niagara-T2:
> 
> 	core_id		proc_id
> cpu0:	1		0
> cpu1:	1		0
> cpu2:	1		0
> cpu3:	1		0
> cpu4:	1		1
> cpu5:	1		1
> cpu6:	1		1
> cpu7:	1		1

But what happens on the T2+? How is a physical package represented? 
Clearly the scheduler needs to be aware of the fact that two hardware 
threads are on different physical processors. As far as I know, the 
scheduler supports 4 levels: threads, cores, physical processors and 
NUMA nodes. I don't see how the current scheme falls into these categories.

Elad

