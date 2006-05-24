From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 24 May 2006 21:23:58 +0000
Subject: Re: sigreturn on sparc64
Message-Id: <4474CEEE.3040902@zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e5270r$q83$1@terminus.zytor.com>
In-Reply-To: <e5270r$q83$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> 
> GLIBC is the source of all knowledge :-)
> 
> libc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c
> 
> In there you'll see that you have to set the sa_restorer
> to NULL and pass in the "stub" address minus 8, as the
> 4th argument to rt_sigation system call.
> 

Minus 8 :)  Talk about weirdness... :-/

	-hpa
