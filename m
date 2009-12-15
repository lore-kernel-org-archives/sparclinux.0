From: David Miller <davem@davemloft.net>
Date: Tue, 15 Dec 2009 07:38:40 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <20091214.233840.236673621.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 14 Dec 2009 15:22:16 +0100 (CET)

> I added some dump_stack() to all the cp_* functions, leading
> to this result:
> 
> Call Trace:
>  [0000000000522990] cp_new_stat+0xdc/0x134
>  [0000000000522d9c] SyS_newfstat+0x24/0x38
>  [0000000000406294] linux_sparc_syscall+0x34/0x44
> 
> Is glibc doing the right thing here? Calling sys_newfstat (instead of 
> sys_newfstat64) for fstat64()?

That's completely bogus.

And I can't reproduce your problem on debian unstable.  What
are you using, Fedora?  Maybe something is fubared in their
glibc build or the checkout they are using.

davem@sunset:~/src/GIT/linux-2.6$ /lib/libc.so.6 --version
GNU C Library (EGLIBC) stable release version 2.10.2, by Roland McGrath et al.
 ...
davem@sunset:~/src/GIT/linux-2.6$ gcc -m64 -o x x.c
davem@sunset:~/src/GIT/linux-2.6$ ./x
1260862562.0
1260862562.0
1260862562.0
davem@sunset:~/src/GIT/linux-2.6$

I even checked current glibc GIT and everything looks kosher there
too.
