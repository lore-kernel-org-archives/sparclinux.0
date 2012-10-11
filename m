From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2012 00:34:51 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20121010.203451.2057992842427697875.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121008.161806.2146082252793236167.davem@davemloft.net>
	<20121010051110.GC2616@ZenIV.linux.org.uk>
In-Reply-To: <20121010051110.GC2616@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 10 Oct 2012 06:11:10 +0100

> sparc64: fix ptrace interaction with force_successful_syscall_return()
>     
> we want syscall_trace_leave() called on exit from any syscall;
> skipping its call in case we'd done force_successful_syscall_return()
> is broken...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

My eyes say this one is good, I'm testing it now and will push to
Linus if I don't hit any problems.

Thanks!
