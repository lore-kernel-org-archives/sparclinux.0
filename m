From: David Miller <davem@davemloft.net>
Date: Wed, 21 Dec 2011 23:05:49 +0000
Subject: Re: [RFC][PATCH] sparc64: remove __ARCH_WANT_UNLOCKED_CTXSW usage
Message-Id: <20111221.180549.2295489434558987482.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1323702852.13285.25.camel@twins>
	<20111221.164426.1859065550459950375.davem@davemloft.net>
In-Reply-To: <20111221.164426.1859065550459950375.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu

From: David Miller <davem@davemloft.net>
Date: Wed, 21 Dec 2011 16:44:26 -0500 (EST)

> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 12 Dec 2011 16:14:12 +0100
> 
>> The only thing resting me is asking you to simply test the below patch
>> and report what happens. Hopefully things will simply work.. if not I've
>> messed up and need to go look harder :/
> 
> I'll give it a spin, and get back to you, thanks!

Ok, so far so good, I stressed out my Niagara-T3 box for a while doing gcc
bootstraps, running the testsuite, etc. and all seems well so far.

I'll keep beating on it and let you know if anything funny happens, but for
now as far as I'm concerned:

Acked-by: David S. Miller <davem@davemloft.net>
