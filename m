From: David Miller <davem@davemloft.net>
Date: Fri, 26 Dec 2008 22:57:00 +0000
Subject: Re: replace incorrect memcpy_user_stub code
Message-Id: <20081226.145700.39112382.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812190208.mBJ28vn13713@elf.torek.net>
In-Reply-To: <200812190208.mBJ28vn13713@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 18 Dec 2008 19:15:16 -0800 (PST)

> From: Chris Torek <chris.torek@windriver.com>
> Date: Thu, 18 Dec 2008 20:11:26 -0700
> 
> > >This is going to perform really bad ...
> > 
> > Yes, I went for space on the theory that it was not common...
> > 
> > >and it's common for
> > >syscalls invoked by the kernel to trigger this case.
> > 
> > ... but so much for that theory. :-)
> 
> At least it used to be the case, it may not matter today and
> I'll do some investigation.  If it doesn't matter, your patch
> is fine and I'll apply it directly.

Ok, I finally had a chance to look things over and it turns out
the performance of this case does in fact matter.

A few examples that might copy lots of big chunks are:

1) ELF core dumping

2) NFSD file read and write

3) kernel_sendmsg() and kernel_recvmsg() which are used by things
   like NFS client sunrpc, and other network filesystem implementations

(basically, grep the tree for "set_fs(KERNEL_DS)")

So I started thinking about alternative ways to fix this.

There might be some way we can annotate the regular memcpy()
implementations with exception handling markers, like we do
for the user copy cases, such that they only trigger the
alternative return value handling when a special thread local
flag has been set.

Or something like that.

Actually, we could do something really simple since we have
control over the encoding of the exception table entries _and_
we have a simple way to determine if we are doing a potentially
exception causing kernel memcpy().

First, if the %o7 or %i7 are inside of the function memcpy_user_stub,
then we are doing one of these in-kernel copies that are allowed to
fault.  This elides the need for a special thread flag or anything
like that.

Second, we add the annotations to the regular memcpy() routines,
but we set the "fixup" field of the exception table entries to
have the low bit set.  This works because all instructions are
4 byte aligned on sparc.

Then the code in do_kernel_fault() can, if it sees a "fixup" value
with the low bit set, check %o7/%i7 for being inside range of
memcpy_user_stub.  If so, we jump to the fixup.  Otherwise we
behave as if we did not find a matching exception table entry.

I'll see if I can whip up an implementation of this.  Thanks for
your patience Chris.


