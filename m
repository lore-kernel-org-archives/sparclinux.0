From: David Miller <davem@davemloft.net>
Date: Wed, 05 Jan 2011 23:36:53 +0000
Subject: Re: [PATCH 0/4] sparc: drop SBUS ifdefs
Message-Id: <20110105.153653.15246087.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105210217.GA22415@merkur.ravnborg.org>
In-Reply-To: <20110105210217.GA22415@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 6 Jan 2011 10:23:43 +1100

> And beyond that, keeping these (unnecessary) #ifdefs is good
> documentation - it makes it obvious that these drivers require sbus to
> function.

It should be buildable on any platform that has CONFIG_OF support,
as all of the SBUS drivers only use generic OF and dma_*() interfaces.

And this has value because it increases build testing.

