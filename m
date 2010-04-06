From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 06 Apr 2010 12:57:35 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <1270558655.1595.265.camel@laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405065701.GC5127@nowhere>
	 <20100405.122233.188421941.davem@davemloft.net>
	 <20100405194055.GA5265@nowhere>
	 <20100406.025049.267615796.davem@davemloft.net>
	 <20100406113830.GF5147@nowhere>  <1270554716.1595.134.camel@laptop>
	 <1270558450.6369.30.camel@marge.simson.net>
In-Reply-To: <1270558450.6369.30.camel@marge.simson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Galbraith <efault@gmx.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, paulus@samba.org

On Tue, 2010-04-06 at 14:54 +0200, Mike Galbraith wrote:
> > ARGH.. yes
> > 
> > Also, I guess that should live in perf_output_lock/unlock() not in
> > perf_event_task_output().
> > 
> > Egads, how to fix that
> 
> Damn, so deadlock fix isn't a fix.  No idea. 

well it is,. but it breaks sparc..

I'm currently compile testing a bunch to fix all that up by doing what
davem suggested: local_irq_save_nmi()/local_irq_restore_nmi().



