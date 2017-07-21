From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 21 Jul 2017 02:44:24 +0000
Subject: Re: [PATCH 0/2] sparc64: Use low latency path to resume idle cpu
Message-Id: <dbe44a81-e5fd-3baf-084e-475db05ba397@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
 <20170720.125710.1645099626446989744.davem@davemloft.net>
In-Reply-To: <20170720.125710.1645099626446989744.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org



On 7/20/2017 2:57 PM, David Miller wrote:
> From: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Date: Sat,  8 Jul 2017 14:23:42 -0600
>
>> cpu_poke is a low latency path to resume the target cpu if suspended
>> using cpu_yield. Use cpu poke to resume cpu if supported by hypervisor.
>>
>> 	     hackbench results (lower is better):
>> Number of		
>> Process:		w/o fix		with fix
>> 1  			0.012		 0.010
>> 10			0.021		 0.019
>> 100			0.151		 0.148
> So this only works for a cpu which has yielded.
>
> The kernel sends reschedule events to both idle and non-idle cpus.
> That's why you have to have that fallback code to still send the
> mondo IPI right?
That is correct.

>
> For the case where POKE works, it seems like completely unnecessary
> overhead to set the PIL interrupt.  Just disable local cpu interrupts
> and call schedule_ipi() directly.
>
> I bet that improves your benchmark even more.

I had same thoughts initially but I had to go with this approach as 
scheduler_ipi is wrapped with irq_enter() and irq_exit(). Whereas POKE 
resumes the cpu in process context.

Comments in scheduler_ipi():

          * Not all reschedule IPI handlers call irq_enter/irq_exit, since
          * traditionally all their work was done from the interrupt return
          * path. Now that we actually do some work, we need to make sure
          * we do call them.
          *
          * Some archs already do call them, luckily irq_enter/exit nest
          * properly.
          *
          * Arguably we should visit all archs and update all handlers,
          * however a fair share of IPIs are still resched only so this 
would
          * somewhat pessimize the simple resched case.
          */
         irq_enter();


-Vijay

