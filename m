From: Konrad Eisele <konrad@gaisler.com>
Date: Mon, 16 Apr 2012 09:58:14 +0000
Subject: failing kthread_create_on_node()
Message-Id: <4F8BED36.7000304@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,
I'm trying to get LEON run SMP in the latest kernel again.
Currently I'm ending up in the following state for a 2-CPU
system:
When smp_init() boost up the other CPU you end up in
->kernel/stop_machine.c:cpu_stop_cpu_callback() with hcpu=1
and a kthread is created for cpu 1 using
		p = kthread_create_on_node(cpu_stopper_thread,
					   stopper,
					   cpu_to_node(cpu),
					   "migration/%d", cpu);
It seems like that cpu_to_node(cpu) is ignored.
I end up in the following situation:
  <p> (the task created by kthread_create_on_node()) gets
inserted into runqueue[0], then still in cpu_stop_cpu_callback()
sched_set_stop_task(1,<p>) is called that
sets
   ...
   cpu_rq(1)->stop = stop;
   ...
which has the effect that kernel/sched/core.c:pick_next_task()'s
         ...
	for_each_class(class) {
		p = class->pick_next_task(rq);
		if (p)
			return p;
	}
         ...
will return rq->stop through stop-task scheduling class and
then CPU 1 will execute <p>. However <p> is actually bound to
rq[0] and i.e. task_thread_info(p)->cpu is 0 so for instance
smp_processor_id() will return 0 and the crash happens as a
side-effect of cpu0 and cpu1 at the end executing <init>-task
at the same time.

I'd like to try to fix this but before messing with arch/sparc/kernel_thread()
and arch/sparc/sparc_do_fork() I'd first want for how to fix this
the best way...

--  Greetings Konrad
