From: David Miller <davem@davemloft.net>
Date: Tue, 07 Oct 2008 21:40:27 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20081007.144027.159588472.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Tue, 7 Oct 2008 23:39:09 +0200

> I found the problem. The rtc-m48t59 driver sets a century bit if the
> year is over 2000. It is not correct on sparc as the first year is
> 1968 (so the century bit is needed in year 2168).
>
> The only sane solution is to reduce mostek_read_byte() and
> mostek_write_byte() and move the sparc specific year offset (1968)
> into the rtc-m48t59 driver.
>
> I'll prepare a patch.
> 
> Thank you for reporting this,

Thanks for tracking this down.
