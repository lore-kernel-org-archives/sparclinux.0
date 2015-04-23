From: David Miller <davem@davemloft.net>
Date: Thu, 23 Apr 2015 01:40:13 +0000
Subject: Re: sparc: deadlock using perf with sched tracepoints and user callstacks
Message-Id: <20150422.214013.429656645697670850.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <551AFA5A.1000908@oracle.com>
In-Reply-To: <551AFA5A.1000908@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Wed, 22 Apr 2015 18:39:53 -0600

> gcc related tasks will start erroring out. Odd that it is mainly gcc
> and friends getting hit.
> 
> I threw a printk into all of the sigbus places under arch/sparc. One
> that kept triggering is sun4v_do_mna. I was not able to get any info
> about why.

Unaligned memory accesses are not a good sign, it usually means
userspace is getting corrupted.
