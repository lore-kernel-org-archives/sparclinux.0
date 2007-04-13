From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 13 Apr 2007 11:11:04 +0000
Subject: Re: gcc-4.2.0 20070316 (prerelease) miscompiles sparc64 kernel
Message-Id: <17951.25928.433402.775526@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200704040723.l347N7ks017930@harpo.it.uu.se>
In-Reply-To: <200704040723.l347N7ks017930@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Fri, 13 Apr 2007 11:23:48 +0200
 > 
 > > Both gcc-4.2.0 and gcc-4.1.2 compile compat_ptr(u32) as a nop,
 > > so it seems that something earlier in the call chain must have
 > > left a sign-extended value in the argument register for `third'.
 > > And true enough, in arch/sparc64/kernel/sys32.S we find that
 > > the entry for sys32_ipc() explicitly sign-extends %o1/%o2/%o3.
 > > %o3 is passed on as-is to `u32 third' in compat_sys_ipc() and
 > > `compat_uptr_t third' in compat_sys_shmat().
 > > 
 > > I don't know the sparc64 ABI rules for how the high 32 bits
 > > of a 64-bit register containing a 32-bit value are supposed
 > > to be (sign-extended, zero-extended, or undefined), but it
 > > seems that u32 values should be zero-extended, which would
 > > make the sign-extension in sys32.S broken.
 > > 
 > > At this point I'm lost. I don't even understand how this
 > > could have worked with gcc < 4.2.0, much less where exactly
 > > gcc-4.2.0 broke things.
 > 
 > The system call dispatch code for 32-bit syscalls clears the upper
 > 32-bits of all argument registers before calling down into the system
 > call implementations.  In your case that would be the sys32.S code.
 > 
 > Look at arch/sparc64/kernel/entry.S:linux_sparc_syscall32 where we do
 > the "srl x, 0, y" instructions which clear the upper 32-bits, moving
 > input argument values to the appropriate output argument registers in
 > parallel.

Hmm:
entry.S:linux_sparc_syscall32 zero-extends (srl) %o3 (and others) and
calls sys32.S:sys32_ipc, which sign-extends (sra) %o3 (and others)
and jumps to compat_sys_ipc(), which passes %o3 on as-is to an
unsigned int in compat_sys_shmat().

This looks buggy. I just don't understand how it could have worked before.

 > The caller is supposed to sign/zero extend arguments, as needed, in
 > the sparc ABI.
 > 
 > compat_sys_ipc() is a mess of sign and zero extension, and I'm not
 > surprised there is a bug here :-)
 > 
 > I think the fix is to eliminate the sys32.S sys32_ipc entry, and
 > replace the sys32_ipc references in arch/sparc64/kernel/systbls.S with
 > compat_sys_ipc.  compat_sys_ipc does all the necessary sign
 > extensions, so if we just use the default zero-extended values the
 > right thing will happen.
 > 
 > Could you test that fix?

Yes, I'll test that in the beginning of next week when I'm back to
where my sparc64 box is.

/Mikael
