From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 22:09:17 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119.140917.108794140.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119153326.GC11022@Krystal>
	<20110119.134047.232915743.davem@davemloft.net>
	<1295474423.12215.1612.camel@gandalf.stny.rr.com>
In-Reply-To: <1295474423.12215.1612.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 19 Jan 2011 17:00:23 -0500

> We can add a comment next to these structures specifying this
> dependency, and hopefully it would be updated if we ever do include a
> long long in them.

Yes, I think a huge comment should be placed somewhere and also the
commit message for the final version of this fix should be quite
verbose :-)
