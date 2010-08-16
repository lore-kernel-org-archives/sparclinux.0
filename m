From: Frans Pop <elendil@planet.nl>
Date: Mon, 16 Aug 2010 08:59:28 +0000
Subject: Re: Serial console issue with 2.6.32
Message-Id: <201008161059.29303.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <201003151809.27436.elendil@planet.nl>
In-Reply-To: <201003151809.27436.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sunday 15 August 2010, David Miller wrote:
> Ok, I think I really got it this time :-)  Please add this patch on
> top of the existing stuff.
>
> --------------
> sparc: Really fix "console=" for serial consoles.
>
> If a video head and keyboard are hooked up, specifying "console=ttyS0"
> or similar to use a serial console will not work properly.
>
> The key issue is that we must register all serial console capable
> devices with register_console(), otherwise the command line specified
> device won't be found.  The sun serial drivers would only register
> themselves as console devices if the OpenFirmware specified console
> device node matched.  To fix this part we now unconditionally get
> the serial console register by setting serial_drv->cons always.
>
> Secondarily we must not add_preferred_console() using the firmware
> provided console setting if the user gaven an override on the kernel
> command line using "console="  The "primary framebuffer" matching
> logic was always triggering o n openfirmware device node match, make
> it not when a command line override was given.

Works great.

Tested on top of previous patch (against 2.6.34; I've not done any kernel 
testing recently and am thus a bit behind).

> Reported-by: Frans Pop <elendil@planet.nl>

s/-by:/-and-tested-by:/

As always: many thanks David!

Cheers,
FJP
