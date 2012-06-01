From: David Miller <davem@davemloft.net>
Date: Fri, 01 Jun 2012 17:56:12 +0000
Subject: Re: [PATCH 21/27] sparc32, smpboot: Use generic SMP booting infrastructure
Message-Id: <20120601.135612.699120609738854050.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
	<20120601091503.31979.52537.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601091503.31979.52537.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, sam@ravnborg.org, vapier@gentoo.org, konrad@gaisler.com, tkhai@yandex.ru, sparclinux@vger.kernel.org

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2012 14:45:09 +0530

>  smp_do_cpu_idle:
> -	call	cpu_idle
>  	 mov	0, %o0

Just like the sparc64 patch, you need to remove the 'mov'
