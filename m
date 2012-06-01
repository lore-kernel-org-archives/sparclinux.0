From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 01 Jun 2012 18:54:48 +0000
Subject: Re: [PATCH 21/27] sparc32, smpboot: Use generic SMP booting infrastructure
Message-Id: <20120601185448.GA19148@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091503.31979.52537.stgit@srivatsabhat.in.ibm.com> <20120601.135612.699120609738854050.davem@davemloft.net>
In-Reply-To: <20120601.135612.699120609738854050.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: srivatsa.bhat@linux.vnet.ibm.com, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, vapier@gentoo.org, konrad@gaisler.com, tkhai@yandex.ru, sparclinux@vger.kernel.org

On Fri, Jun 01, 2012 at 01:56:12PM -0400, David Miller wrote:
> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> Date: Fri, 01 Jun 2012 14:45:09 +0530
> 
> >  smp_do_cpu_idle:
> > -	call	cpu_idle
> >  	 mov	0, %o0
> 
> Just like the sparc64 patch, you need to remove the 'mov'

And the other callers of cpu_idle in the same file should
be updated/removed too.

There is one for sun4m, sun4d and leon.

	Sam
