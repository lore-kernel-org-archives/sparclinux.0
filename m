From: David Miller <davem@davemloft.net>
Date: Fri, 01 Jun 2012 17:55:22 +0000
Subject: Re: [PATCH 20/27] sparc64, smpboot: Use generic SMP booting infrastructure
Message-Id: <20120601.135522.2065505829159749961.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
	<20120601091449.31979.67743.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601091449.31979.67743.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, paul.gortmaker@windriver.com, vapier@gentoo.org, jkosina@suse.cz, sparclinux@vger.kernel.org

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2012 14:44:54 +0530

> -	call		cpu_idle
>  	 mov		0, %o0
 ...
> -	call		cpu_idle
>  	 mov		0, %o0


The 'mov' has to be removed too, it's in the delay slot of the
call instruction and is passing in the first argument.
