From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 22:45:00 +0000
Subject: Re: klibc sparc sockets foo
Message-Id: <20100314.154500.129760931.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100314161159.GA23007@stro.at>
In-Reply-To: <20100314161159.GA23007@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 15:35:40 -0700 (PDT)

> From: David Miller <davem@davemloft.net>
> Date: Sun, 14 Mar 2010 15:06:38 -0700 (PDT)
> 
>> 
>> Well, on sparc32 we implement sys_socketcall() and on sparc64 we don't
>> and instead provide the direct system calls for things like that.
> 
> Wait a second, both sparc64 and sparc32 provide sys_socketcall.
> 
> Look in the compat syscall table for sys32_socketcall and in
> the native 64-bit one we have sys_socketcall.

The fact of the matter is that on sparc64 some, but unfortunately
not all, of the socket system calls are provided natively.

However, in my tree for sparc64, unlike the klibc commit message
claims, I do in fact see sys_socket provided in slot 97.

/*90*/	.word sys_dup2, sys_nis_syscall, sys_fcntl, sys_select, sys_nis_syscall
	.word sys_fsync, sys_setpriority, sys_socket, sys_connect, sys_accept

But things like sys_bind do not appear in the sparc64 syscall
table.

So probably the best thing to do is, like the commit presented
at the top of this thread, use sys_socketcall unconditionally.
From some simple tests this is what glibc does too.

But the factual errors in the commit message need to be fixed
:-)

