From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 13 Apr 2007 09:23:48 +0000
Subject: Re: gcc-4.2.0 20070316 (prerelease) miscompiles sparc64 kernel
Message-Id: <17951.19492.708925.270178@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200704040723.l347N7ks017930@harpo.it.uu.se>
In-Reply-To: <200704040723.l347N7ks017930@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Wed, 4 Apr 2007 09:23:07 +0200 (MEST)
 > 
 > > The 2.6.21-rc5 kernel compiled with gcc-4.2.0 20070316 boots ok
 > > but is thrown into an infinite loop by `hdparm -Tt /dev/hda'.
 > > Sysrq-P tells me that the call chain in the loop is:
 > > 
 > > __up_read or __handle_mm_fault [varies]
 > > do_sparc64_fault
 > > sparc64_realfault_common
 > > compat_sys_shmat
 > > 
 > > The kernel works when built with gcc-3.4.6, 4.0.4, or 4.1.2.
 > > 
 > > I'll do some more debugging next week, if I have time.
 > 
 > Any updates?

Yes, but I can't yet reproduce the problem in a user-mode
test case, or pinpoint the exact object code that broke.

In ipc/compat.c:compat_sys_shmat():

long compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
                        void __user *uptr)
{
        int err;
        unsigned long raddr;
        compat_ulong_t __user *uaddr;

        if (version = 1)
                return -EINVAL;
        err = do_shmat(first, uptr, second, &raddr);
        if (err < 0)
                return err;
        uaddr = compat_ptr(third);
        return put_user(raddr, uaddr);
}

The syscall originated from a 32-bit process, and `third'
is a high user-space pointer 0xffxxxxxx. If I insert a
printk("uaddr %#lx third %#x\n", (long)uaddr, third) just
before the final put_user(), I find that with gcc-4.2.0
uaddr will be 0xffffffffffxxxxxx, i.e. sign-extended from
third, and this causes sparc64_realfault_common() to loop.
With gcc-4.1.2 uaddr is 0x00000000ffxxxxxx and put_user() works.

Both gcc-4.2.0 and gcc-4.1.2 compile compat_ptr(u32) as a nop,
so it seems that something earlier in the call chain must have
left a sign-extended value in the argument register for `third'.
And true enough, in arch/sparc64/kernel/sys32.S we find that
the entry for sys32_ipc() explicitly sign-extends %o1/%o2/%o3.
%o3 is passed on as-is to `u32 third' in compat_sys_ipc() and
`compat_uptr_t third' in compat_sys_shmat().

I don't know the sparc64 ABI rules for how the high 32 bits
of a 64-bit register containing a 32-bit value are supposed
to be (sign-extended, zero-extended, or undefined), but it
seems that u32 values should be zero-extended, which would
make the sign-extension in sys32.S broken.

At this point I'm lost. I don't even understand how this
could have worked with gcc < 4.2.0, much less where exactly
gcc-4.2.0 broke things.

/Mikael
