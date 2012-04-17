From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 17 Apr 2012 06:37:50 +0000
Subject: Re: failing kthread_create_on_node()
Message-Id: <4F8D0FBE.8090702@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4F8BED36.7000304@gaisler.com>
In-Reply-To: <4F8BED36.7000304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>
> Please describe the sequence of events in more detail so we
> can analyze this better.

Here is the state of the kernel that causes the failure:
( <p> is the kthread created by
   kernel/stop_machine.c:cpu_stop_cpu_callback(),
   2 cpu system, cpu0 and cpu1, cpu0 has run-queue rq0,
   cpu1 has run-queue rq1, the run-queue structure has a
   field called "stop", "..." means "whatever"
)

rq0[ ... <p> ...] , rq0.stop=...
rq1[ ]            , rq1.stop=<p>

1. How to get there
...
CPU0 boots up and
->kernel/smp.c:smp_init()
  ->kernel/cpu.c:__cpu_up() calls __cpu_notify(CPU_UP_PREPARE..)
    ...->stop_machine.c:cpu_stop_cpu_callback()
         here you have the following code sequence:
         ...
310: 	case CPU_UP_PREPARE:
311:		BUG_ON(stopper->thread || stopper->enabled ||
312:		       !list_empty(&stopper->works));
313:		p = kthread_create_on_node(cpu_stopper_thread,
314:					   stopper,
315:					   cpu_to_node(cpu),
316:					   "migration/%d", cpu);
317:		if (IS_ERR(p))
318:			return notifier_from_errno(PTR_ERR(p));
319:		get_task_struct(p);
321:		kthread_bind(p, cpu);
322:		sched_set_stop_task(cpu, p);
323:		stopper->thread = p;
324:		break;
        ...
        I observe that lines 313-321 craete kthread <p> but it is
        in rq0 . I'm not shure why kthread_bind doesnt move <p> to
        rq1. Then come line 322 that calls:
        -> kernel/core/sched.c:sched_set_stop_task(1,<p>)
        and there you have the line:
        ...
980:   cpu_rq(cpu)->stop = stop;
        ...
        (where "stop" is <p> and cpu is 1).
        Now you end up with the above described state. You have <p> in
        rq0 and also in rq1.stop

2. What happens next

    CPU1 will boot up and execute schedule().
    ...
    -> kernel/core.c:__schedule()
         ...
3158:   cpu = smp_processor_id();
3159:	rq = cpu_rq(cpu);
         ...
3199: 	put_prev_task(rq, prev);
3200:	next = pick_next_task(rq);
3201:	clear_tsk_need_resched(prev);
         ...
     CPU1 is executing, so cpu = 1 and rq = rq1
     Line 3200 will call
    -> kernel/core.c:pick_next_task()

         ...
3137:	for_each_class(class) {
3138:		p = class->pick_next_task(rq);
3139:		if (p)
3140:			return p;
3141:	}
         ...
     (rq is still rq1)
     Line 3138 will end up in kernel/sched/stop_task.c:pick_next_task_stop()
         ...
28:	struct task_struct *stop = rq->stop;
29:
30:	if (stop && stop->on_rq)
31:		return stop;
32:
33:	return NULL;
         ...

With the state of the kernel being:

rq0[ ... <p> ...] , rq0.stop=...
rq1[ ]            , rq1.stop=<p>

You get as "next" in __schedule <p>, even though CPU is cpu1 and <p> in
in rq0 and has thread_info(<p>)->cpu set to 0.

3. Failure

After CPU1 has switched to <p> it will end up in __schedule()
again. However because of
#define raw_smp_processor_id()		(current_thread_info()->cpu)
now smp_processor_id() returns 0 even though you are cpu1 ( because <p> is on rq0)
=> lots of stange things happen and the kernel crashes
    eventually.


4. Question

Where should I look for the solution. Is it
  -  kthread_bind(p, cpu)
     That should move <p> to rq1.
  -  sched_set_stop_task(cpu, p)
     That should force move of <p> to rq1
  -  Should maybe smp_processor_id() be redefined to hard_smp_processor_id()
  -  rq1 is empty, maybe idle_balance(1, rq1) in schedule() should have migrated
     <p> to rq1, however it doesnt do it right now.

-- Greetings Konrad

