From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Apr 2008 15:39:37 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <alpine.LFD.1.10.0804240837120.2779@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080424.040239.193699673.davem@davemloft.net>
In-Reply-To: <20080424.040239.193699673.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On Thu, 24 Apr 2008, David Miller wrote:
> 
> 2) Make use of an unused field in pt_regs to store both
>    a magic number, and the trap number, this allows:
> 
>    a) Removing the funny passing of the "restart_syscall"
>       boolean in the trap return paths to the signal dispatch.
> 
>    b) Allow more accurate stack backtraces, since we have the
>       magic cookie, we can detect trap frames accurately.
> 
>    c) The UTRACE guys want to be able to detect if a thread
>       off the cpu is in a system call, they can do that trivially
>       now just like they can on x86.
> 
>    In fact much of this idea is from Roland McGrath.

Heh. This is what x86 has done since day#1. I wonder why other 
architectures wouldn't have copied that part..

That's "orig_eax". It's a strange name, it really has nothing to do with 
"eax" except for the fact that the system call number comes from that 
register - for traps etc it's a negative value.

			Linus
