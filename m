From: David Miller <davem@davemloft.net>
Date: Sun, 04 Nov 2007 21:51:55 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071104.135155.255548133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 04 Nov 2007 20:55:20 +0100

> So I'm not sure if the result is really useful for you - if not just let
> me know. I've attached the last ~10-20 sysrq-g outputs - as it was
> running in a loop I have a ton of them. In case you're wondering: http
> is aptitude's http method.

The http module is stuck in a different place, I'll try to
see if I can make sense of it.
