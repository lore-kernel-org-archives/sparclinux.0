From: David Miller <davem@davemloft.net>
Date: Sun, 05 Oct 2008 20:47:11 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <20081005.134711.127992837.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Elad Lahav <elahav@uwaterloo.ca>
Date: Wed, 17 Sep 2008 14:45:58 -0400

> >>> Niagara T1 is a single "package", with 8 "cores".
> >> Exactly my point. So why isn't there a single physical package ID for all CPUs under /sys/devices/system/cpu/cpuX/topology/physical_package_id ?
> > I misspoke here, this is not how I use the topology.
> 
> Just in case you decide to fix the physical_package_id numbers, here's a possible patch. It uses the serial number of the processor to distinguish between physical CPUs, and assigns an ID based on the number of distinct serial numbers found.
> The only caveat (I know of) is that it increases the size of cpu_data beyond 2 cache lines (not sure if that means much in practice, though).

You didn't even test boot this, you can't change the size of cpuinfo_sparc
without fixing all the hardcoded assembler indexing of that structure.

First, you're need to pad it out to the next power of two, then you'd
need to update the shift constant macro that all the assembler uses.

But I'm really not interested in changing this anyways.
