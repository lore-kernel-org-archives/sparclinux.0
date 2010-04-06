From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 06 Apr 2010 11:20:19 +0000
Subject: Re: [RFC][PATCH] lockdep: WARN about local_irq_{en,dis}able in NMI
Message-Id: <1270552819.1595.63.camel@laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405194055.GA5265@nowhere>
	 <20100406.025049.267615796.davem@davemloft.net>
	 <1270552321.1595.42.camel@laptop>
	 <20100406.041342.183031470.davem@davemloft.net>
In-Reply-To: <20100406.041342.183031470.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, paulus@samba.org

On Tue, 2010-04-06 at 04:13 -0700, David Miller wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 06 Apr 2010 13:12:01 +0200
> 
> > One thing we can do is make the code WARN about this, how about
> > something like the below
> 
> It's going to warn every bootup in cpu_clock() on x86.

*sigh*, yes, we could hack around that I suppose.. it would be nice to
automate this check though, I bet you don't fancy tracking down more
such splats than you have to.

You could of course insert the debug code into your arch routines but
that would limit the coverage checks to whatever you happen to run.

