From: David Miller <davem@davemloft.net>
Date: Tue, 06 Apr 2010 11:22:35 +0000
Subject: Re: [RFC][PATCH] lockdep: WARN about local_irq_{en,dis}able in NMI
Message-Id: <20100406.042235.133749467.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270552321.1595.42.camel@laptop>
	<20100406.041342.183031470.davem@davemloft.net>
	<1270552819.1595.63.camel@laptop>
In-Reply-To: <1270552819.1595.63.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, paulus@samba.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 06 Apr 2010 13:20:19 +0200

> On Tue, 2010-04-06 at 04:13 -0700, David Miller wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>> Date: Tue, 06 Apr 2010 13:12:01 +0200
>> 
>> > One thing we can do is make the code WARN about this, how about
>> > something like the below
>> 
>> It's going to warn every bootup in cpu_clock() on x86.
> 
> *sigh*, yes, we could hack around that I suppose.. it would be nice to
> automate this check though, I bet you don't fancy tracking down more
> such splats than you have to.
> 
> You could of course insert the debug code into your arch routines but
> that would limit the coverage checks to whatever you happen to run.

Yes, f.e. you could add local_irq_*_nmi() or similar that don't
complain when called inside of an NMI.

I would certainly welcome this debugging facility, for sure!

It would have saved me two days of work this time, in fact.


