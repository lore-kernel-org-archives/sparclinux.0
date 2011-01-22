From: Steven Rostedt <rostedt@goodmis.org>
Date: Sat, 22 Jan 2011 17:43:45 +0000
Subject: Re: [patch 1/3] introduce __u64_aligned and U64_ALIGN() for
Message-Id: <1295718225.12215.4822.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110121203630.725922272@efficios.com>
	 <20110121203642.725191236@efficios.com>
	 <20110121.160503.233879710.davem@davemloft.net>
	 <20110122171134.GA31308@Krystal>
In-Reply-To: <20110122171134.GA31308@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@elte.hu, richm@oldelvet.org.uk, ben@decadent.org.uk, sparclinux@vger.kernel.org, stable <stable@kernel.org>

On Sat, 2011-01-22 at 12:11 -0500, Mathieu Desnoyers wrote:

> After these patches get merged -- I would recommend going through the tracing
> tree -- they'll have to go to -stable too. I'm therefore forwarding this to
> stable@kernel.org (the same should be done for the two other patches in this
> series).

Hi Mathieu,

I was in the process of putting them through my ktest.pl patch-check
tests, but unfortunately, another bug was triggered (unrelated to these)
and prevented me from getting them ready last night.

I'll continue on them on Monday.

-- Steve



