From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:04:44 +0000
Subject: Re: [RFC, SPARC64] use rtc mostek drivers instead of minirtc
Message-Id: <20080828.230444.178393641.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080823.234039.29618768.davem@davemloft.net>
In-Reply-To: <20080823.234039.29618768.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: krzysztof.h1@poczta.fm
Date: 29 Aug 2008 07:52:14 +0200

> Thank you for your review and tips.

Krzysztof, I just got done converting all of the drivers and
deleting the mini RTC code.

It is tested on SunBlade1000 and SunBlade2500 workstations.

I'm about to post the patches, and I'll test other system types
shortly afterwards.
