From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 17 Jan 2011 14:11:26 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295273486.16479.15.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D3074FE.3030707@oldelvet.org.uk>
	 <20110115.211722.39173519.davem@davemloft.net>
	 <1295187469.22527.13.camel@duncow>
	 <20110116.113944.48514452.davem@davemloft.net>
In-Reply-To: <20110116.113944.48514452.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[ Added Mathieu on Cc, since he likes alignments ;-) ]

On Sun, 2011-01-16 at 11:39 -0800, David Miller wrote:
> From: Richard Mortimer <richm@oldelvet.org.uk>
> Date: Sun, 16 Jan 2011 14:17:49 +0000
> 
> > I'm wondering if gcc is just getting better at honouring the source
> > code. The DEFINE_EVENT macros in include/trace/ftrace.h have a
> > __aligned__(4) attribute in them. Maybe that should be 8 on sparc64
> > systems.
> > The aligned 4 seems to be unchanged since include/trace/ftrace.h was
> > created in f42c85e74faa422cf0bc747ed808681145448f88 in April 2009.
> 
> That needs to be at least "8" on 64-bit systems.  Why is this aligned
> directive there at all?

IIRC, the problem showed up in 64-bit systems. OK, x86-64 (but of
course ;-).

The problem comes when the linker puts these sections together. We read
all the sections as one big array. If the linker puts in holes, then
this breaks the array, and the kernel crashes while reading the section.

I guess one solution is to remove the alignment at the allocation and
place it at the structure. This will mean all accesses to this structure
will need to be on an alignment.

-- Steve


