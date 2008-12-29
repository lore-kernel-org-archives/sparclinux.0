From: Chris Torek <chris.torek@windriver.com>
Date: Mon, 29 Dec 2008 21:55:40 +0000
Subject: Re: replace incorrect memcpy_user_stub code
Message-Id: <200812292155.mBTLten13593@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812190208.mBJ28vn13713@elf.torek.net>
In-Reply-To: <200812190208.mBJ28vn13713@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>There might be some way we can annotate the regular memcpy()
>implementations with exception handling markers, like we do
>for the user copy cases, such that they only trigger the
>alternative return value handling when a special thread local
>flag has been set.

I thought about this, but it's ugly and creates (at least potential)
problems with recursion / interrupts.  (Not sure if these are possible
in the Linux kernel organization, just "icky on general principles".)

>First, if the %o7 or %i7 are inside of the function memcpy_user_stub,
>then we are doing one of these in-kernel copies that are allowed to
>fault.  This elides the need for a special thread flag or anything
>like that.

This, on the other hand, seems quite promising: as with the exception
table itself, we use the program counter (of the return address,
in this case) as the flag.

>Then the code in do_kernel_fault() can, if it sees a "fixup" value
>with the low bit set, check %o7/%i7 for being inside range of
>memcpy_user_stub.  If so, we jump to the fixup.  Otherwise we
>behave as if we did not find a matching exception table entry.

This should work really well.

Chris
