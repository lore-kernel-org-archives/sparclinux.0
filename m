From: David Miller <davem@davemloft.net>
Date: Mon, 15 Nov 2010 15:49:41 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <20101115.074941.193725858.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 15 Nov 2010 04:28:26 +0100 (CET)

> Speaking of net kernel, it was a bit of an annoyance to build a
> crosscompiler.

./configure --disable-bootstrap

> 7c1f6afcf98fe95fb3f2b70ce01cf66f6db53b5e is the first bad commit
> commit 7c1f6afcf98fe95fb3f2b70ce01cf66f6db53b5e
> Author: David S. Miller <davem@davemloft.net>
> Date:   Tue May 25 23:51:17 2010 -0700
> 
>     sunserial: Don't call add_preferred_console() when console= is specified.
>     
>     Reported-by: Frans Pop <elendil@planet.nl>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> :040000 040000 827bf16df16b16a0dc938f2dc7483bc3cf5d44d3
> 69e6b8fb55a416204e599554f5af821cc612325e M      drivers
> 
> 
> $ cat /proc/cmdline 
> console=ttyS0
> 
> (ttyS0 is in fact the sun4v ttyHV0.) This "turning off earlyprom0"
> at the end of the kernel boot log is worrysome, and seems to be
> the cause for the stop. (I have seen similar when booting a kernel
> to a filesystem that has no /dev/console.)

You'll see the "turning off earlyprom0" message on normal boots too.

Your console device is not ttyS0, it is in fact ttyHV0.  The kernel
was overriding your incorrect kernel boot command line specification
before the commit in question, now it's respecting it and that's why
you no longer get your console.
