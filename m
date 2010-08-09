From: David Miller <davem@davemloft.net>
Date: Mon, 09 Aug 2010 05:34:44 +0000
Subject: Re: [PATCH 2/3] sparc: make driver/of/pdt no longer sparc-specific
Message-Id: <20100808.223444.62324566.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100808231116.21c7d6f3@dev.queued.net>
	<AANLkTimG7u5eXWSn5VznKfuFcFD+evTzo1_QpAFmCdpL@mail.gmail.com>
	<20100809013245.1cefb9bf@dev.queued.net>
In-Reply-To: <20100809013245.1cefb9bf@dev.queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dilinger@queued.net
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andres Salomon <dilinger@queued.net>
Date: Mon, 9 Aug 2010 01:32:45 -0400

> On Sun, 8 Aug 2010 23:12:21 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> 
>> If you have to explicitly cast these function pointers, then you're
>> doing it wrong.  :-)  Listen to and fix the compiler complaint here.
>> 
> 
> Hm, can you please expand on that?  The reason it's necessary to cast is
> because sparc's prom_* functions are using ints instead of phandles.  I
> don't understand why casting is the wrong thing here.
> 
> I could write some 1-line wrapper functions that simply call prom_*
> rather than casting, I suppose.

There's no reason the Sparc interfaces can't take phandles since they
are just ints, and that would make the call signatures of these
functions compatible with the types used by the other architectures.
