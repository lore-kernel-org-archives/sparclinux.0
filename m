From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 17 Jan 2006 23:27:03 +0000
Subject: Re: qla2200 borkage on 2.6.15.x ?
Message-Id: <20060117.152703.107339008.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1137457183.9960.130.camel@sixthstreet.jeffreyforman.net>
In-Reply-To: <1137457183.9960.130.camel@sixthstreet.jeffreyforman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jeffrey Forman <jforman@gentoo.org>
Date: Mon, 16 Jan 2006 19:19:43 -0500

> http://dev.gentoo.org/~jforman/blade1000-2.6.15.1.qla2200output
> 
> Gentoo Sources 2.6.15-gentoo-r1:
> http://dev.gentoo.org/~jforman/blade1000-gentoo-2.6.15-gentoo-r1.output

I believe this bug was fixed post-2.6.15, but I can't say for sure.

One workaround you can use for now is to simply not enable both
QLOGIC_FC and QLA2XXX at the same time.

You definitely should not be using both of those drivers.  In fact
QLOGIC_FC is deprecated, so I would recommend using QLA2XXX in favor
of QLOGIC_FC in your builds.  This is what I've had the Ubuntu folks
do as well.  I use QLA2XXX on my SunBlade1000 and it works quite
well.

What is happening is that the former loads first, takes over driving
the device, then QLA2XXX comes along and cannot register itself as a
result.  There is some bug in the QLA2XXX driver init failure path
error handling.  You have a good trace, so perhaps you should forward
it to the QLA2XXX maintainers in case it hasn't been solved yet.

Thanks.
