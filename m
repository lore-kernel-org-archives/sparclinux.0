From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 18 Aug 2010 05:03:23 +0000
Subject: Re: 64-bit ppc rwsem (was: Re: [GIT] Sparc)
Message-Id: <1282107803.22370.173.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20100817.180325.104051399.davem@davemloft.net>
	<AANLkTikQ1dGw0aO10_ZwmVEc-JAVhB==3HS7SrWycE49@mail.gmail.com>
	<AANLkTimZ3rhX2AzPExEGfRCXiFNN-BGOWRKqL241-qNa@mail.gmail.com>
	<20100817.191424.183031381.davem@davemloft.net>
	<1282106338.22370.151.camel@pasglop>
In-Reply-To: <1282106338.22370.151.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Wed, 2010-08-18 at 14:38 +1000, Benjamin Herrenschmidt wrote:
> 
> Here's an untested patch for the folks on linuxppc-dev to look at,
> I'll
> review my own stuff & test tomorrow. 

Allright, gcc's being a pain, and atomics are a struct so we can't that
easily assign.

I tried various tricks but so far they didn't work. I'll have another
look tomorrow, but I may end up having to keep all the crap typecasts.

Cheers,
Ben.


