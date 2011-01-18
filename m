From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jan 2011 05:34:48 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110117.213448.226787087.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1295187469.22527.13.camel@duncow>
	<20110116.113944.48514452.davem@davemloft.net>
	<1295273486.16479.15.camel@gandalf.stny.rr.com>
In-Reply-To: <1295273486.16479.15.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org
Cc: richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com, mathieu.desnoyers@efficios.com

From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 17 Jan 2011 09:11:26 -0500

> The problem comes when the linker puts these sections together. We read
> all the sections as one big array. If the linker puts in holes, then
> this breaks the array, and the kernel crashes while reading the section.

Ummm, this sounds like a serious binutils bug.

If it's doing this, than things like constructor and destructor
sections will not work properly.  Those are constructed in the
same exact way, objects with constructors register a pointer into
a special section (".ctors" or something like that) and all such
section contents are linked together into an array for the final
binary.  crt0.S and similar code on program startup walks the
array and executes every pointer in that array.

Or is the problem, rather, that you're storing different kinds of data
structures into this section?  Is the problem that they turn out to
have different sizes and this is what disturbs the array walk?

I really don't understand what the problem is, and the align(4)
fix is definitely the wrong thing to do for several reasons.

Where are these "holes" coming from?  Reading the commit message for
the change that introduced this problem
(86c38a31aa7f2dd6e74a262710bf8ebf7455acc5), it seems like the issue is
coming from the compiler, and that fact that beforehand some
structures were marked with 4-byte alignment.  The existing 4-byte
alignment cases sound like the real bug to me, where is that happening
and why?

If you want these things to be in the array, you have to define them
all identically.  But down-aligning structures with pointers in them
is definitely not the right fix.


