From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 20 Mar 2018 17:02:26 +0000
Subject: Re: sparc_pipe(2)
Message-Id: <20180320170226.GA30522@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180319.211125.314781796727440151.davem@davemloft.net>
In-Reply-To: <20180319.211125.314781796727440151.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 20, 2018 at 10:13:02AM -0400, David Miller wrote:

> > Is there any reason we want to check high right there?  After all,
> > sys_ftruncate() will produce exactly that on MSB of its second
> > argument set...  The same goes for sys32_truncate() - sys_truncate()
> > will yield -EINVAL on negative loff_t.
> 
> Indeed, both checks look like they are extraneous.

While looking through the syscall wrappers there:
sys_sigreturn:  
        call    do_sigreturn
         add    %sp, STACKFRAME_SZ, %o0

        ld      [%curptr + TI_FLAGS], %l5
        andcc   %l5, _TIF_SYSCALL_TRACE, %g0
        be      1f
         nop

        call    syscall_trace
         mov    1, %o1
which seems to rely upon do_sigreturn() leaving its %i0 alone, while
sys_rt_sigreturn:
        call    do_rt_sigreturn
         add    %sp, STACKFRAME_SZ, %o0

        ld      [%curptr + TI_FLAGS], %l5
        andcc   %l5, _TIF_SYSCALL_TRACE, %g0
        be      1f
         nop

        add     %sp, STACKFRAME_SZ, %o0
        call    syscall_trace
         mov    1, %o1
doesn't count upon the same for do_rt_sigreturn().  I'm not saying that
any of that is in any way critical (sparc32 kernel, for fsck sake...),
just curious about the difference here.  IIRC, there's nothing to
prevent void foo(void *p) stomping on its %i0; it's unlikely to happen
in either case, but why the difference in callers?

Anyway, I've put together some cleanups ({COMPAT_,}SYSCALL_DEFINE
conversions, getting rid of SIGN... wrappers) in
git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git misc.sparc
Do you see any obviour problems with the stuff in there?  It's not
urgent - the real fun with compat wrappers will be on mips and s390,
anyway; sparc is fairly benign in that respect...
