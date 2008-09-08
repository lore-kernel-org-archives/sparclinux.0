From: David Miller <davem@davemloft.net>
Date: Mon, 08 Sep 2008 01:26:21 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20080907.182621.249495743.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Thu, 4 Sep 2008 18:57:04 +0200

> Fix setting of a year in m48t08 and m48t02 clocks.
> They do not have century bits and setting them
> causes the year to overflow (bit 0x80 set).
> 
> Problem found by Robert Reif on Sun Sparcstation 20.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Applied to sparc-next-2.6, thanks a lot!
