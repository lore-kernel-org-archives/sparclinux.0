From: David Miller <davem@davemloft.net>
Date: Mon, 15 Aug 2011 19:44:38 +0000
Subject: Re: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <20110815.124438.437817600517741155.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110815152102.GK11398@pengutronix.de>
In-Reply-To: <20110815152102.GK11398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 15 Aug 2011 11:40:23 -0400

> Actually, I think option d) is the best.
> 
> d) have sparc support recordmcount.c

Maybe you misunderstand what these guys are doing.

The recordmcount.pl script wants to look at the output of the
architecture of the built kernel.  It's intimitately tied to
the architecture the kernel was built as, it must therefore
be invoked with exactly what the kernel was bult with.

These guys are building a 64-bit sparc kernel then trying to use
recordmcount.pl with the 32-bit sparc ARCH set.

That can't work.

Next, recordmcount.pl doesn't have 32-bit sparc support because we
don't support building the kernel with profiling options enabled for
that architecture.

