From: andreas@gaisler.com
Date: Thu, 25 Oct 2012 11:57:32 +0000
Subject: Re: [PATCH v2] sparc: Add sparc support for =?UTF-8?Q?platform=5Fget=5Firq=28=29?=
Message-Id: <0b77f2a2dd52bc39c770491689efc752@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 From: David Miller:
> From: Sam Ravnborg <sam@ravnborg.org>
>> First off - seeing a SPARC ifdef in base/drivers make me think that
>> something is wrong. And there is not even a comment why SPARC is so
>> special.
>
> The problem is that, on sparc, we store the IRQs in the device
> archdata area. Whereas other platforms do this in a different
> way, mostly via IORESOURCE_IRQ in the platform device

I agree that there should be a comment in the code about the reason
for an #ifdef CONFIG_SPARC to be there.

 From the point of view of getting cross platform drivers working on
sparc, I think it would be very nice if irqs were available as
platform resources just as for so many other platforms. This however
is a larger change than getting platform_get_irq to work.

I have lookined into the alternative of providing IORESOURCE_IRQ for
sparc in parallel with the archdata representation, as a first
step. Then drivers that relies upon platform resources could work at
the same time as the code that relies on irqs being in archdata
continues to work. In arch/sparc some changes needs to be done to code
that assumes that all resources are "register" resources.

The problem with this approach however, is that there are a number of
existing drivers (and some other code) that rely on specific number of
resources for a device. All such code for devices that has irqs that
run in a sparc context needs to be changed to take the new irq
resources into account and care needs to be taken that code that is
not in a sparc context is not changed. It is not always totally
self-evident without further investigation which of the affected
drivers might run in a sparc context.

The other problem of providing irq resources for sparc is the flags
variable that comes with the resource. There seems to be no
corresponding information for sparc devices so that the flag variable
can be filled in properly.

Because of all this my proposition is to get platform_get_irq to
work on sparc. Then cross platform drivers can be made to work under
sparc in a smooth manner. As it is now, platform_get_irq is avalable
to call in sparc, but the call will always fail.

Cheers,
Andreas

