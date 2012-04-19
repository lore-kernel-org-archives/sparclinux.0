From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 19 Apr 2012 09:33:24 +0000
Subject: Re: failing kthread_create_on_node()
Message-Id: <4F8FDBE4.10107@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4F8BED36.7000304@gaisler.com>
In-Reply-To: <4F8BED36.7000304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Konrad Eisele<konrad@gaisler.com>
> Date: Tue, 17 Apr 2012 08:37:50 +0200
>
>> 2. What happens next
>>
>>     CPU1 will boot up and execute schedule().
>>     ...
>>     ->  kernel/core.c:__schedule()
>
> The stop thread doesn't actually run immediately when it is created,
> so will need to be woken up to be scheduled and run.
>
> At wakeup time, set_task_cpu() should fix things up and make the
> task have a correct ->cpu in it's thread_info.
>
> I wonder if one of the sparc32 global cpu masks isn't being
> initialized properly.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

I have posted
"[PATCH 1/1] sparc: task_cpu() for stopper thread on sparc32 returns 0"

I traced it further and you where right, the stop thread of CPU1 was
sleeping.
The reason that the stopper thread for cpu-1 gets inserted into runqueue-0
(which causes fatal failure later on) is traced below:

When CPU1 comes online it is woken up. Then I end up in
the following call path:

-> kernel/sched/core.c():try_to_wake_up():
         ...
1628:	cpu = select_task_rq(p, SD_BALANCE_WAKE, wake_flags);
1629:	if (task_cpu(p) != cpu) {
         ...
      -> kernel/sched/core.c:select_task_rq():
           ...
1332:	  int cpu = p->sched_class->select_task_rq(p, sd_flags, wake_flags);
           ...
         -> kernel/sched/stop_task.c:select_task_rq_stop():
             ...
16:         return task_cpu(p); /* stop tasks as never migrate */
             ...


however task_cpu(p) is 0.

The patch posted checks weather a different cpu should be returned in
kernel/sched/stop_task.c:select_task_rq_stop().

Hope that makes sense.

-- Konrad





