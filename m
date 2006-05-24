From: David Miller <davem@davemloft.net>
Date: Wed, 24 May 2006 21:34:32 +0000
Subject: Re: sigreturn on sparc64
Message-Id: <20060524.143432.30183027.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e5270r$q83$1@terminus.zytor.com>
In-Reply-To: <e5270r$q83$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: sigreturn on sparc64
Date: Wed, 24 May 2006 14:23:58 -0700

> David Miller wrote:
> > 
> > GLIBC is the source of all knowledge :-)
> > 
> > libc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c
> > 
> > In there you'll see that you have to set the sa_restorer
> > to NULL and pass in the "stub" address minus 8, as the
> > 4th argument to rt_sigation system call.
> > 
> 
> Minus 8 :)  Talk about weirdness... :-/

The stub is "returned to" directly from the signal handler itself
using the "retl" instruction, which jumps to the value of "register
%i7 plus 8".  We stick the passed in stub address directly into the
%i7 register of the signal handler frame, that's why you need to
subtract 8 for the system call argument.
