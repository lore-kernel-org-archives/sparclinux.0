From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 22:35:40 +0000
Subject: Re: klibc sparc sockets foo
Message-Id: <20100314.153540.31587988.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100314161159.GA23007@stro.at>
In-Reply-To: <20100314161159.GA23007@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 15:06:38 -0700 (PDT)

> 
> Well, on sparc32 we implement sys_socketcall() and on sparc64 we don't
> and instead provide the direct system calls for things like that.

Wait a second, both sparc64 and sparc32 provide sys_socketcall.

Look in the compat syscall table for sys32_socketcall and in
the native 64-bit one we have sys_socketcall.
