From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2017 19:57:10 +0000
Subject: Re: [PATCH 0/2] sparc64: Use low latency path to resume idle cpu
Message-Id: <20170720.125710.1645099626446989744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: sparclinux@vger.kernel.org, rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Sat,  8 Jul 2017 14:23:42 -0600

> cpu_poke is a low latency path to resume the target cpu if suspended
> using cpu_yield. Use cpu poke to resume cpu if supported by hypervisor.
> 
> 	     hackbench results (lower is better):
> Number of		
> Process:		w/o fix		with fix
> 1  			0.012		 0.010
> 10			0.021		 0.019
> 100			0.151		 0.148

So this only works for a cpu which has yielded.

The kernel sends reschedule events to both idle and non-idle cpus.
That's why you have to have that fallback code to still send the
mondo IPI right?

For the case where POKE works, it seems like completely unnecessary
overhead to set the PIL interrupt.  Just disable local cpu interrupts
and call schedule_ipi() directly.

I bet that improves your benchmark even more.
