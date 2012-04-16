From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2012 18:33:00 +0000
Subject: Re: failing kthread_create_on_node()
Message-Id: <20120416.143300.1732293511143666568.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4F8BED36.7000304@gaisler.com>
In-Reply-To: <4F8BED36.7000304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Mon, 16 Apr 2012 11:58:14 +0200

> will return rq->stop through stop-task scheduling class and
> then CPU 1 will execute <p>. However <p> is actually bound to
> rq[0] and i.e. task_thread_info(p)->cpu is 0 so for instance
> smp_processor_id() will return 0 and the crash happens as a
> side-effect of cpu0 and cpu1 at the end executing <init>-task
> at the same time.
> 
> I'd like to try to fix this but before messing with
> arch/sparc/kernel_thread()
> and arch/sparc/sparc_do_fork() I'd first want for how to fix this
> the best way...

I don't see why special handling should be necessary.

Sparc64 doesn't do anything special wrt. thread_info()->cpu in
it's fork handling, so I don't see why sparc32 would need to.

If the scheduler is executing a task from the runqueue of one
cpu, on another cpu, that doesn't sound like a sparc problem
unless some other piece of sparc specific state is not setup
properly.

Please describe the sequence of events in more detail so we
can analyze this better.

Thanks.
