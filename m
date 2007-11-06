From: David Miller <davem@davemloft.net>
Date: Tue, 06 Nov 2007 11:13:30 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071106.031330.116247263.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 06 Nov 2007 04:51:07 +0100

> Here's also some output from apt-get which got stuck in my unstable
> chroot while I wanted to retrieve the klibc source to try to debug it...

So the good news is that I started getting the hang seen
on the Debain buildd on my workstation.

The bad news is that it's very sporadic, for a while I
could trigger it during bootup, on every boot, and now
I can't get it to wedge at all.

Anyways, we're getting closer.
