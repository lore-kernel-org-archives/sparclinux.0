From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 07 Apr 2010 01:23:26 +0000
Subject: Re: [patch 1/3] kernel: local_irq_{save,restore}_nmi()
Message-Id: <1270603406.19685.15609.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406132807.698467930@chello.nl>
	 <20100406133140.903644813@chello.nl>
	 <1270602790.19685.15603.camel@gandalf.stny.rr.com>
	 <20100406.181906.89249649.davem@davemloft.net>
In-Reply-To: <20100406.181906.89249649.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2010-04-06 at 18:19 -0700, David Miller wrote:

> That's the whole point, so that the problem is more easily noticed and
> it gets fixed long before I end up accidently testing the code on my
> machines :-)
> 
> To be honest, the fix is so trivial, you just need to add '_nmi' to
> the local_irq_{save,restore}() calls that warn like this.
> 
> I'm even willing to have you forward all of those reports to me and
> I'll be responsible for fixing them.
> 
> How's that? :-)

Sure.

/me sets up his procmailrc to search for the WARN_ON line in
trace_irqsoff.c and have it forward to davem.

-- Steve


