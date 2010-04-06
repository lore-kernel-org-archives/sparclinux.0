From: David Miller <davem@davemloft.net>
Date: Tue, 06 Apr 2010 11:13:42 +0000
Subject: Re: [RFC][PATCH] lockdep: WARN about local_irq_{en,dis}able in NMI
Message-Id: <20100406.041342.183031470.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405194055.GA5265@nowhere>
	<20100406.025049.267615796.davem@davemloft.net>
	<1270552321.1595.42.camel@laptop>
In-Reply-To: <1270552321.1595.42.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, paulus@samba.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 06 Apr 2010 13:12:01 +0200

> One thing we can do is make the code WARN about this, how about
> something like the below

It's going to warn every bootup in cpu_clock() on x86.
