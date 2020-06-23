From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 23 Jun 2020 16:37:30 +0000
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to per-cpu variables
Message-Id: <20200623163730.GA4800@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
In-Reply-To: <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk, elver@google.com

On Tue, Jun 23, 2020 at 06:13:21PM +0200, Ahmed S. Darwish wrote:
> Well, freshly merged code is using it. For example, KCSAN:
> 
>     => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
>     => kernel/kcsan/report.c:
> 
>     void kcsan_report(...)
>     {
> 	...
>         /*
>          * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
>          * we do not turn off lockdep here; this could happen due to recursion
>          * into lockdep via KCSAN if we detect a race in utilities used by
>          * lockdep.
>          */
>         lockdep_off();
> 	...
>     }

Marco, do you remember what exactly happened there? Because I'm about to
wreck that. That is, I'm going to make TRACE_IRQFLAGS ignore
lockdep_off().
