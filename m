From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 22:21:37 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119.142137.184823805.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119153326.GC11022@Krystal>
	<20110119.134047.232915743.davem@davemloft.net>
	<20110119221327.GA23544@Krystal>
In-Reply-To: <20110119221327.GA23544@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 19 Jan 2011 17:13:27 -0500

> Hrm, I'd like to see what kind of ill-conceived 32-bit architecture would
> generate a unaligned access for a 32-bit aligned u64. Do you have examples in
> mind ? By definition, the memory accesses should be at most 32-bit, no ? AFAIK,
> gcc treats u64 as two distinct reads on all 32-bit architectures.

Sparc 32-bit has 64-bit loads and stores, GCC uses them because the ABI
specifies that every structure is at least 8 byte aligned.

> gcc on my sparc64 box (32-bit userland) disagrees with you here ;) Using
> gcc (Debian 4.3.3-14) 4.3.3, here is a demonstration that, indeed, "packed"
> generates aweful code, but that "packed, aligned(4 or 8)" generates pretty
> decent code:

Amazing, if this works then do it.

But please document this fully with comments and such :-)
