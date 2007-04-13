From: David Miller <davem@davemloft.net>
Date: Fri, 13 Apr 2007 20:24:19 +0000
Subject: Re: gcc-4.2.0 20070316 (prerelease) miscompiles sparc64 kernel
Message-Id: <20070413.132419.48812832.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200704040723.l347N7ks017930@harpo.it.uu.se>
In-Reply-To: <200704040723.l347N7ks017930@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 13 Apr 2007 13:11:04 +0200

> Hmm:
> entry.S:linux_sparc_syscall32 zero-extends (srl) %o3 (and others) and
> calls sys32.S:sys32_ipc, which sign-extends (sra) %o3 (and others)
> and jumps to compat_sys_ipc(), which passes %o3 on as-is to an
> unsigned int in compat_sys_shmat().
> 
> This looks buggy. I just don't understand how it could have worked before.

I wonder the same thing.  Perhaps gcc was chopping off the high bits
somehow with other versions.

Indeed, looking at the assembler for compat_sys_ipc() with gcc-4.0.x
I get:

	sra	%o1, 0, %o0	! first, first
	sra	%o2, 0, %o1	! second, second
	srl	%o3, 0, %o2	! third, third
	sra	%o4, 0, %o3	! version, version
	srl	%g3, 0, %o4	! ptr, ptr
	or	%o7, %g0, %g1
	call	compat_sys_shmat, 0	!
	 or	%g1, %g0, %o7

Thus, it is clearing %o3 explicitly.

I bet this is an optimization, because due to the arg passing
rules of the ABI on sparc64 it should not need to zero extend
those arguments declared as u32 at all, yet it is above :)

> Yes, I'll test that in the beginning of next week when I'm back to
> where my sparc64 box is.

Thank you.

In the mean time it is clear to me this is a bug and I will
push this fix after I do some light testing of my own.

Thanks again Mikael.
