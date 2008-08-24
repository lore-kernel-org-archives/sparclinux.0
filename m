From: David Miller <davem@davemloft.net>
Date: Sun, 24 Aug 2008 06:40:39 +0000
Subject: Re: [RFC, SPARC64] use rtc mostek drivers instead of minirtc
Message-Id: <20080823.234039.29618768.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sun, 24 Aug 2008 08:44:34 +0200

> I tried to use a rtc layer for sparc arch. 
 ...
> I would like to convert whole rtc handling to the rtc layer. However,
> I have no hardware to test (only U60) so I need some help from sparc
> people.

Thank you for doing this work, I appreciate it.

I'm happy to merge this and test other system types
once the changes from -mm make it upstream.
