From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2008 09:06:14 +0000
Subject: Re: [BUG] Kernel panic on heavy disk activity with esp_scsi
Message-Id: <20080813.020614.160990178.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1210367903.21472.14.camel@lya.porno-bullen.de>
In-Reply-To: <1210367903.21472.14.camel@lya.porno-bullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@porno-bullen.de>
Date: Thu, 19 Jun 2008 09:58:45 +0200

> > Can I have a copy?  I'd like to trigger this here and debug
> > it locally if possible.
> 
> One of these should help you to trigger the bug:
> 
> Option 1 (works sometimes)
> $ wget ftp://distro.ibiblio.org/pub/linux/distributions/gentoo/snapshots/portage-latest.tar.lzma
> $ unlzma portage-latest.tar.lzma
> $ while [ true ]
> $ do
> $	tar -xf portage-latest.tar
> $	rm -r portage
> $ done

I haven't forgotten about this bug.

Over the past weekend I ran this loop for days on my dual-cpu Ultra2
box.  I then even ran a full XORG GIT build at the same time, and
I could not trigger this bug.

I'll have to come up with some kind of debugging patch so when it
triggers for you the kernel log will print some useful tracing
information we can use to try and disect this further.

I have no timeframe for when I'll be able to code that up as I have
a lot of other things to sort out first.
