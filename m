From: David Miller <davem@davemloft.net>
Date: Mon, 09 Jun 2008 23:14:51 +0000
Subject: Re: [panic] "Cheetah error trap taken" with Debian 2.6.24 kernel
Message-Id: <20080609.161451.153250029.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806100003.54269.elendil@planet.nl>
In-Reply-To: <200806100003.54269.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Tue, 10 Jun 2008 01:03:48 +0200

> Given that the screenshot shows that the line just before the crash 
> is "radeonfb (0001:02:00.0): ATI Radeon [d" which looks truncated the 
> most likely candidate looks to be drivers/video/aty/radeon_base.c (in 
> __devinit radeon_map_ROM).
> That function even has some suspicious looking comments immediately above 
> the call.
> 
> Finding out for sure would probably require building a custom installer 
> using a kernel with some added debugging statements. Is that needed?

Since the pci_map_rom() call done by the Radeon driver will be done
long before it registers itself as a console framebuffer device, we
would not see the penguin on the screen and the framebuffer console
output if it's invocation of pci_map_rom() were the cause.

