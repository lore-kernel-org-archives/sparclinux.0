From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 25 Sep 2004 05:25:44 +0000
Subject: Re: Simple driver question
Message-Id: <20040924222544.33b10414.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200409250205.42223.crn@netunix.com>
In-Reply-To: <200409250205.42223.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 24 Sep 2004 21:15:48 -0600
Jason Wever <weeve@gentoo.org> wrote:

> On Sat, 25 Sep 2004 02:05:42 +0100
> "C.Newport" <crn@netunix.com> wrote:
> 
> > Newer Sun machines have a 10/100/1000 NIC built in.
> > Which Linux driver does this use ?
> 
> At least for the Blade 1x0 workstations, they use the Sun Gem driver.

It totally depends upon the machine.

SB100 --> sungem
SB1000 --> sungem
SB1500 --> tg3
V2xx/V4xx --> tg3

I think the SB2000 uses sungem too, but I may be mistaken.

