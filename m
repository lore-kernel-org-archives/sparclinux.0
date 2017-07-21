From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 21 Jul 2017 03:36:42 +0000
Subject: Re: [PATCH 0/2] sparc64: Use low latency path to resume idle cpu
Message-Id: <3bb6d4bb-ebf1-1a1f-9766-b02a187cbe1e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
 <20170720.125710.1645099626446989744.davem@davemloft.net>
 <dbe44a81-e5fd-3baf-084e-475db05ba397@oracle.com>
 <20170721.035526.1236051430538663900.davem@davemloft.net>
In-Reply-To: <20170721.035526.1236051430538663900.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org



On 7/20/2017 9:55 PM, David Miller wrote:
> From: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Date: Thu, 20 Jul 2017 21:44:24 -0500
>
>> I had same thoughts initially but I had to go with this approach as
>> scheduler_ipi is wrapped with irq_enter() and irq_exit(). Whereas POKE
>> resumes the cpu in process context.
>>
>> Comments in scheduler_ipi():
>>
>>           * Not all reschedule IPI handlers call irq_enter/irq_exit, since
>>           * traditionally all their work was done from the interrupt return
>>           * path. Now that we actually do some work, we need to make sure
>>           * we do call them.
>>           *
>>           * Some archs already do call them, luckily irq_enter/exit nest
>>           * properly.
>>           *
>>           * Arguably we should visit all archs and update all handlers,
>>           * however a fair share of IPIs are still resched only so this would
>>           * somewhat pessimize the simple resched case.
>>           */
>>          irq_enter();
>>
> I still think we should be able to fake the state such that this
> direct schedule_ipi() call will work.
>
> I could be wrong :)
I can give a try :). But looks to me one thing that will go wrong is irq 
accounting done in __irq_enter() and rcu_irq_enter().

Thanks,
Vijay

