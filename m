From: David Miller <davem@davemloft.net>
Date: Fri, 01 Jun 2012 22:53:41 +0000
Subject: Re: [UPDATED PATCH 21/27] sparc32, smpboot: Use generic SMP booting infrastructure
Message-Id: <20120601.185341.1462375672682064314.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120601.135612.699120609738854050.davem@davemloft.net>
	<20120601185448.GA19148@merkur.ravnborg.org>
	<4FC94693.5050707@linux.vnet.ibm.com>
In-Reply-To: <4FC94693.5050707@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: sam@ravnborg.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, vapier@gentoo.org, konrad@gaisler.com, tkhai@yandex.ru, sparclinux@vger.kernel.org

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Sat, 02 Jun 2012 04:17:47 +0530

> 
> Convert sparc32 to use the generic framework to boot secondary CPUs.
> 
> Notes:
> While removing the call to cpu_idle(), we can also remove the call to
> cpu_panic() because we are calling BUG() in the generic code anyway.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Almost there, but not quite yet.

You can't get rid of the cpu_panic invocations, those have to be there
after the *_callin calls to catch if they accidently return.
