From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 22:23:48 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119.142348.186319799.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119.134047.232915743.davem@davemloft.net>
	<1295474423.12215.1612.camel@gandalf.stny.rr.com>
	<20110119222144.GC23544@Krystal>
In-Reply-To: <20110119222144.GC23544@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 19 Jan 2011 17:21:44 -0500

> I still wonder how a 32-bit system can generate an unaligned access trap for an
> access to a 64-bit variable aligned on 32-bit, given that there is, by
> definition, no 64-bit memory accesses available on the architecture ?

Sparc 32-bit (and I believe MIPS 32-bit as well) have such 64-bit
load and store instructions.
