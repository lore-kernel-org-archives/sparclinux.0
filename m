From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 23 Jun 2020 08:42:28 +0000
Subject: Re: [PATCH 02/17] sparc64: enable HAVE_COPY_THREAD_TLS
Message-Id: <20200623084228.jpufvn5mn3lhjc36@wittgenstein>
List-Id: <sparclinux.vger.kernel.org>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-3-christian.brauner@ubuntu.com>
 <20200622.203516.1857672250009821997.davem@davemloft.net>
In-Reply-To: <20200622.203516.1857672250009821997.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Jun 22, 2020 at 08:35:16PM -0700, David Miller wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Tue, 23 Jun 2020 01:43:11 +0200
> 
> > diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
> > index db42b4fb3708..192f3a28a2b7 100644
> > --- a/arch/sparc/kernel/syscalls.S
> > +++ b/arch/sparc/kernel/syscalls.S
> > @@ -86,19 +86,22 @@ sys32_rt_sigreturn:
> >  	 * during system calls...
> >  	 */
> >  	.align	32
> > -sys_vfork: /* Under Linux, vfork and fork are just special cases of clone. */
> > -	sethi	%hi(0x4000 | 0x0100 | SIGCHLD), %o0
> > -	or	%o0, %lo(0x4000 | 0x0100 | SIGCHLD), %o0
> > -	ba,pt	%xcc, sys_clone
> > +sys_vfork:
> > +	flushw
> > +	ba,pt	%xcc, sparc_vfork
> > +	add	%sp, PTREGS_OFF, %o0
> 
> Please indent branch delay slot instructions with one extra space, as
> was done in the code you are changing.
> 
> > +	ba,pt	%xcc, sparc_fork
> > +	add	%sp, PTREGS_OFF, %o0
> 
> Likewise.
> 
> > +	ba,pt	%xcc, sparc_clone
> > +	add	%sp, PTREGS_OFF, %o0
> 
> Likewise.

Fixed, thanks for taking a look again! This somehow slipped past me when
applying. 

Christian
