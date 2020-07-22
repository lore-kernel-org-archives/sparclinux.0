From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jul 2020 01:24:32 +0000
Subject: Re: [PATCH] sparc32: fix a user-triggerable oops in clear_user()
Message-Id: <20200721.182432.1321288727189331162.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200720012151.GM2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200720012151.GM2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@zeniv.linux.org.uk
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 20 Jul 2020 02:21:51 +0100

> Back in 2.1.29 the clear_user() guts (__bzero()) had been merged
> with memset().  Unfortunately, while all exception handlers had been
> copied, one of the exception table entries got lost.  As the result,
> clear_user() starting at 128*n bytes before the end of page and
> spanning between 8 and 127 bytes into the next page would oops when
> the second page is unmapped.  It's trivial to reproduce - all
> it takes is
> 
> main()
> {
> 	int fd = open("/dev/zero", O_RDONLY);
> 	char *p = mmap(NULL, 16384, PROT_READ|PROT_WRITE,
> 			MAP_PRIVATE|MAP_ANON, -1, 0);
> 	munmap(p + 8192, 8192);
> 	read(fd, p + 8192 - 128, 192);
> }
> 
> which had been oopsing since March 1997.  Says something about
> the quality of test coverage... ;-/  And while today sparc32 port
> is nearly dead, back in '97 it had been very much alive; in fact,
> sparc64 had only been in mainline for 3 months by that point...
> 
> Cc: stable@kernel.org
> Fixes: v2.1.29
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, thanks Al.
