From: David Miller <davem@davemloft.net>
Date: Thu, 10 Aug 2017 05:16:12 +0000
Subject: Re: [PATCH v2 0/2] sparc64: Use low latency path to resume idle cpu
Message-Id: <20170809.221612.1193783575554639272.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 21 Jul 2017 10:23:55 -0600

> CPU_POKE is a low latency path to resume the target cpu if suspended
> using CPU_YIELD. Use CPU_POKE to resume cpu if supported by hypervisor.
> 
> 	     Hackbench results (lower is better):
> Number of		
> Process:		w/o fix		with fix
> 1  			0.012		 0.010
> 10			0.021		 0.019
> 100			0.151		 0.148
> 
> Changelog:
> v2:
>   - Fixed comments and spacing (2/2)

Series applied to sparc-next, thanks.
