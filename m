From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 26 Jan 2011 00:25:18 +0000
Subject: Re: [patch 1/3] introduce __u64_aligned and U64_ALIGN() for
Message-Id: <1296001518.10144.63.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110121203630.725922272@efficios.com>
	 <20110121203642.725191236@efficios.com>
	 <20110121.160503.233879710.davem@davemloft.net>
	 <20110122171134.GA31308@Krystal>
	 <1295718225.12215.4822.camel@gandalf.stny.rr.com>
	 <20110125233451.GA29539@Krystal>
In-Reply-To: <20110125233451.GA29539@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@elte.hu, richm@oldelvet.org.uk, ben@decadent.org.uk, sparclinux@vger.kernel.org, stable <stable@kernel.org>

On Tue, 2011-01-25 at 18:34 -0500, Mathieu Desnoyers wrote:

> Any progress on the merge process for this bugfix patch series ? The issue
> seemed rather pressing last week, given that it breaks sparc64.

I was hoping to resolve the bug, but its not that reproducible and
screws up the bisect.

I'll disable the feature that is broken (for now) and continue with your
patches. Hopefully everything will go smoothly, and I can push these out
tonight or tomorrow morning.

-- Steve


