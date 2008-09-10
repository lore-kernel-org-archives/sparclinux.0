From: David Miller <davem@davemloft.net>
Date: Wed, 10 Sep 2008 02:30:15 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20080909.193015.04608202.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Tue, 09 Sep 2008 22:07:47 -0400

> Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> >
> > Fix setting of a year in m48t08 and m48t02 clocks.
> > They do not have century bits and setting them
> > causes the year to overflow (bit 0x80 set).
> >   
> I think this fix is also needed.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Ignore previous email :-)
