From: David Miller <davem@davemloft.net>
Date: Mon, 15 Nov 2010 19:24:23 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <20101115.112423.232892561.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 15 Nov 2010 20:18:42 +0100 (CET)

> However, I do not see any /dev/ttyHV0. But there is /dev/ttyS0 which,
> when I echo something to it, does print stuff on the HV console. So
> console=ttyS0 actually made sense.

Yes, this is a relic from how the console and serial subsystem
do their device naming.

I left the serial device name at ttyS* so that there wouldn't
need to be special knowledge of this in whatever distribution
bits set up and configure serial consoles.

In hindsight that might have been a mistake, and perhaps I should have
named both things ttyHV* but there's no way I can change it now
without breaking more than I would fix.
