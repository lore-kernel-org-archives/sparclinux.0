From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 20 Mar 2018 00:12:24 +0000
Subject: sparc_pipe(2) (was Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead() implementation)
Message-Id: <20180320001224.GY30522@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 19, 2018 at 04:23:00AM +0000, Al Viro wrote:

> 3) sparc wrappers in sys32.S.  Most of those got killed off back in 2012,
> what remained was
> SIGN1(sys32_getrusage, compat_sys_getrusage, %o0)
> SIGN1(sys32_readahead, compat_sys_readahead, %o0)
> SIGN2(sys32_fadvise64, compat_sys_fadvise64, %o0, %o4)
> SIGN2(sys32_fadvise64_64, compat_sys_fadvise64_64, %o0, %o5)
> SIGN1(sys32_clock_nanosleep, compat_sys_clock_nanosleep, %o1)
> SIGN1(sys32_timer_settime, compat_sys_timer_settime, %o1)
> SIGN1(sys32_io_submit, compat_sys_io_submit, %o1)
> SIGN1(sys32_mq_open, compat_sys_mq_open, %o1)
> SIGN1(sys32_select, compat_sys_select, %o0)
> SIGN3(sys32_futex, compat_sys_futex, %o1, %o2, %o5)
> SIGN2(sys32_sendfile, compat_sys_sendfile, %o0, %o1)
> SIGN1(sys32_recvfrom, compat_sys_recvfrom, %o0)
> SIGN1(sys32_recvmsg, compat_sys_recvmsg, %o0)
> SIGN1(sys32_sendmsg, compat_sys_sendmsg, %o0)
> SIGN2(sys32_sync_file_range, compat_sync_file_range, %o0, %o5)
> SIGN1(sys32_vmsplice, compat_sys_vmsplice, %o0)
> with some of those killed off later and (completely pointless)
> SIGN2(sys32_renameat2, sys_renameat2, %o0, %o2)
> added.
> 
> Since then clock_nanosleep(), timer_settime(), io_submit(), mq_open(),
> select(), recvfrom(), recvmsg(), sendmsg(), getrusage(), sync_file_range(),
> futex() and vmsplice() got switched to COMPAT_SYSCALL_DEFINE, making those
> SIGN... wrappers pointless.  That leaves
> SIGN1(sys32_readahead, compat_sys_readahead, %o0)
> SIGN2(sys32_fadvise64, compat_sys_fadvise64, %o0, %o4)
> SIGN2(sys32_fadvise64_64, compat_sys_fadvise64_64, %o0, %o5)
> all of which are right there in arch/sparc/kernel/sys_sparc32.c and
> trivially converted to COMPAT_SYSCALL_DEFINE.  Which would kill all the
> SIGN... bunch off, leaving there sys_mmap() and sys_socketcall()

Speaking of sparc...  Is there any reason why we bother with
sys_sparc_pipe:
        ba,pt   %xcc, sys_sparc_pipe_real
         add    %sp, PTREGS_OFF, %o0

SYSCALL_DEFINE1(sparc_pipe_real, struct pt_regs *, regs)
{
        int fd[2];
        int error;

        error = do_pipe_flags(fd, 0);
        if (error)
                goto out;
        regs->u_regs[UREG_I1] = fd[1];
        error = fd[0];   
out:   
        return error;
}

instead of

SYSCALL_DEFINE0(sparc_pipe)
{
        int fd[2];
        int error;

        error = do_pipe_flags(fd, 0);
        if (error)
                goto out;
        current_pt_regs()->u_regs[UREG_I1] = fd[1];
        error = fd[0];   
out:   
        return error;
}

After all, current_pt_regs() on sparc is
%g6 + THREAD_SIZE - sizeof(struct pt_regs), i.e. g6 + <constant>

So we are trading use of constant circa 16K for extra branch + use of
constant circa 2K?  Doesn't look like there would be any benefit...
Am I missing something here, or is it simply that the thing predates
current_pt_regs()?
