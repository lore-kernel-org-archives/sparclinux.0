From: Robert Reif <reif@earthlink.net>
Date: Wed, 10 Sep 2008 10:53:48 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <48C7A73C.1020109@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Krzysztof Helt wrote:
> Have you needed this?
>
This is what I was getting without my patch.  The century
bit may have been set by the driver before the first patch
was applied.

Aug  3 14:21:35 ss20-1 kernel: rtc-m48t59 rtc-m48t59.0: Century bit is 
enabled
Aug  3 14:21:35 ss20-1 kernel: rtc-m48t59 rtc-m48t59.0: RTC read time 
2108-08-10 00/49/26

