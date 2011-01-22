From: David Miller <davem@davemloft.net>
Date: Sat, 22 Jan 2011 04:11:50 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <20110121.201150.09765126.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 17 Jan 2011 13:06:48 +0000

> The module loads OK but generates the following when I run fbset -i
> -fb /dev/fb1
> 
> Jan 17 13:00:54 sodium kernel: [  369.984028] /pci@8,700000: PCI Error,
> primary error type[Master Abort]
> Jan 17 13:00:54 sodium kernel: [  369.984042] /pci@8,700000:
> bytemask[0001] was_block(0) space(Memory)
> Jan 17 13:00:54 sodium kernel: [  369.984049] /pci@8,700000: PCI AFAR
> [00000000000a0000]

Yeah, it's dying the same way as before.

I'm stumped at the moment.
