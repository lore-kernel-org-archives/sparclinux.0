From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jan 2011 00:43:24 +0000
Subject: Re: physical_package_id on sun4v
Message-Id: <20110120.164324.62352783.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1101210131480.6015@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1101210131480.6015@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 21 Jan 2011 01:40:03 +0100 (CET)

> Did I get something wrong? Is perhaps the Machine Description not 
> expressive enough to figure out how many packages (CPU sockets) there 
> are?

This is simply how we number physical packages and "cores" on Niagara.

CPU sockets are represented by NUMA nodes.

We need three layers of scheduler grouping, and those are the three
layers provided by the kernel's generic hierarchy:

	NUMA node --> physical_package --> core

Inside the CPU socket we need two layers of scheduler grouping, so
that's how I decided to implement things.

So it's intentional and on purpose.
