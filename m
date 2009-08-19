From: David Miller <davem@davemloft.net>
Date: Wed, 19 Aug 2009 03:16:13 +0000
Subject: Re: sparc: sys32.S incorrect compat-layer splice() system call
Message-Id: <20090818.201613.15171258.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090819025623.GA11677@Krystal>
In-Reply-To: <20090819025623.GA11677@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Tue, 18 Aug 2009 22:56:23 -0400

> I think arch/sparc/kernel/sys32.S has an incorrect splice definition:
> 
> SIGN2(sys32_splice, sys_splice, %o0, %o1)
> 
> The splice() prototype looks like :
> 
>        long splice(int fd_in, loff_t *off_in, int fd_out,
>                    loff_t *off_out, size_t len, unsigned int flags);
> 
> So I think we should have :
> 
> SIGN2(sys32_splice, sys_splice, %o0, %o2)
> 
> instead, am I correct ?

Indeed, that's correct, thanks for your fix.  I'll apply it.

> 
> BTW, I can't figure out why we have %o5 in :
> 
> SIGN2(sys32_sync_file_range, compat_sync_file_range, %o0, %o5)
> 
> which takes only 4 arguments:
> 
>        int sync_file_range(int fd, off64_t offset, off64_t nbytes,
>                   unsigned int flags);
> 
> maybe it has something to do with the return value ? Anyway it should
> not hurt if it is unused.

It takes 4 arguments, but they are passed in 6 registers.  Each
off64_t is passed in two 32-bit register parts.

