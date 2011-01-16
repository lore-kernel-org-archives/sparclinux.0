From: David Miller <davem@davemloft.net>
Date: Sun, 16 Jan 2011 19:39:44 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110116.113944.48514452.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D3074FE.3030707@oldelvet.org.uk>
	<20110115.211722.39173519.davem@davemloft.net>
	<1295187469.22527.13.camel@duncow>
In-Reply-To: <1295187469.22527.13.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: richm@oldelvet.org.uk
Cc: 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Sun, 16 Jan 2011 14:17:49 +0000

> I'm wondering if gcc is just getting better at honouring the source
> code. The DEFINE_EVENT macros in include/trace/ftrace.h have a
> __aligned__(4) attribute in them. Maybe that should be 8 on sparc64
> systems.
> The aligned 4 seems to be unchanged since include/trace/ftrace.h was
> created in f42c85e74faa422cf0bc747ed808681145448f88 in April 2009.

That needs to be at least "8" on 64-bit systems.  Why is this aligned
directive there at all?
