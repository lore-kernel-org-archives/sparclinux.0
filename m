From: Mitch Bradley <wmb@firmworks.com>
Date: Fri, 26 Nov 2010 07:36:19 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <4CEF6373.60105@firmworks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>	
	<1290692075.689.20.camel@concordia>	
	<AANLkTiknyKi1pzvUP2WnasudZwH27-a0FxCX0BSHBdQp@mail.gmail.com>	
	<1290741341.9453.377.camel@concordia>
	<4CEF3AB1.9060200@firmworks.com>
	<1290750606.9453.394.camel@concordia>
In-Reply-To: <1290750606.9453.394.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mips <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrea Scian <andrea.scian-0U1K5dsi4As@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>


>> One Laptop Per Child ships real Open Firmware on its x86 Linux systems,
>> of which approximately 2 million have been shipped or ordered.  An ARM
>> version, also with OFW, is in the works.
>
> OK. I don't see any code under arch/x86 or arch/arm that uses of_()
> routines though? Or is it under drivers or something?
>

Andres Salomon has been working for some time to get some Open Firmware 
support for x86 upstream.  As you can probably imagine, it has been slow 
going, but seems to be getting close.

The OLPC ARM work is just beginning, so nothing has been submitted yet. 
  The first hardware prototypes are still being debugged. Lennert 
Buytenhek is the key OS person who will be involved.
