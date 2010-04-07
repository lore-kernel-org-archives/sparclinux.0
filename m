From: David Miller <davem@davemloft.net>
Date: Wed, 07 Apr 2010 01:17:17 +0000
Subject: Re: [PATCH 2/2] ftrace: Use local_irq_{save,restore}_nmi() in
Message-Id: <20100406.181717.01368166.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406.164002.40105966.davem@davemloft.net>
	<1270602850.19685.15604.camel@gandalf.stny.rr.com>
In-Reply-To: <1270602850.19685.15604.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 06 Apr 2010 21:14:10 -0400

> On Tue, 2010-04-06 at 16:40 -0700, David Miller wrote:
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> ---
>>  kernel/trace/ftrace.c             |    4 ++--
>>  kernel/trace/trace_functions.c    |    8 ++++----
>>  kernel/trace/trace_sched_wakeup.c |    4 ++--
>>  kernel/trace/trace_stack.c        |    4 ++--
>>  4 files changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index d9062f5..41d4282 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -612,7 +612,7 @@ function_profile_call(unsigned long ip, unsigned long parent_ip)
>>  	if (!ftrace_profile_enabled)
>>  		return;
>>  
>> -	local_irq_save(flags);
>> +	local_irq_save_nmi(flags);
> 
> These are equivalent for non sparc archs, correct?

Yes.

> If so,
> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
