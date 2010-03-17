From: Frans Pop <elendil@planet.nl>
Date: Wed, 17 Mar 2010 10:50:07 +0000
Subject: Re: Serial console issue with 2.6.32
Message-Id: <201003171150.08245.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <201003151809.27436.elendil@planet.nl>
In-Reply-To: <201003151809.27436.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 17 March 2010, David Miller wrote:
> I changed the behavior of SUNSAB serial consoles in 2.6.32
> and later, see:

Thanks! That at least saves me a probably very painful bisection.

I'm not even going to attempt the technical merits of the change, but...

> Looking more at what you're trying to do, I think you really need to
> set the output-device and input-device firmware variables properly.
>
> The kernel tries very hard to use whatever the firmware specified
> as the output-device as the console.

That seems fair. However, all Linux documentation I've come across so far, 
including Documentation/{kernel-parameters,serial-console}.txt, says to 
use 'console=' to override the default console.

What's extra confusing is that the serial port is shown as "online" during 
the early part of the boot and only goes offline at the point the switch 
should happen.

And it seems you still have a bug because the connected monitor does *not* 
display the kernel output either. So apparently the kernel still thinks 
ttyS0 is the console and directs output there, even though the port has 
been disabled.

Also, Documentation/serial-console}.txt suggests that it should be possible 
to direct console output to multiple devices. I can understand not wanting 
to *disable* the console specified by firmware, but couldn't consoles 
specified on the command line be enabled in addition?
Not sure what that would mean for accepting input though (which I guess 
would normally be from the last console specified).

> I couldn't find an easy way 
> get the behaviour you were after, yet at the same time get the
> multiple-serial-devices-only-one-is-console case right all the
> time.

IMO it's a real pity that a general mechanism that AFAIK works on most 
(all?) other arches doesn't not work for Sparc.

Now that I know it's not a huge issue for me personally. It just means I 
can no longer use my Sparc box for testing use of console= for Debian 
installations, which is a pity as it's the most suitable box I have for 
that.

I'm not sure how much this is going to throw off other users, but I suspect 
the majority (except maybe for long time sparc sysadmins) would expect 
console= to be honored.

Thanks,
FJP
