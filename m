From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 15 Nov 2010 19:18:42 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <alpine.LNX.2.01.1011152007290.9735@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Monday 2010-11-15 16:49, David Miller wrote:
>
>> 7c1f6afcf98fe95fb3f2b70ce01cf66f6db53b5e is the first bad commit
>> Author: David S. Miller <davem@davemloft.net>
>> Date:   Tue May 25 23:51:17 2010 -0700
>> 
>>     sunserial: Don't call add_preferred_console() when console= is specified.
>> 
>> $ cat /proc/cmdline 
>> console=ttyS0
>> 
>> (ttyS0 is in fact the sun4v ttyHV0.) This "turning off earlyprom0"
>> at the end of the kernel boot log is worrysome, and seems to be
>> the cause for the stop. (I have seen similar when booting a kernel
>> to a filesystem that has no /dev/console.)
>
>Your console device is not ttyS0, it is in fact ttyHV0.  The kernel
>was overriding your incorrect kernel boot command line specification
>before the commit in question, now it's respecting it and that's why
>you no longer get your console.

However, I do not see any /dev/ttyHV0. But there is /dev/ttyS0 which,
when I echo something to it, does print stuff on the HV console. So
console=ttyS0 actually made sense.
