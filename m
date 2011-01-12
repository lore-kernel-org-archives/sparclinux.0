From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 12 Jan 2011 23:43:02 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <1294875782.13868.20.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2011-01-11 at 20:51 -0800, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 11 Jan 2011 20:27:19 -0800 (PST)
> 
> > From: David Miller <davem@davemloft.net>
> > Date: Tue, 11 Jan 2011 18:29:45 -0800 (PST)
> > 
> >> Oh... I see what is happening.  save_vga() sets this value using it's
> >> own heuristics, when VGA_SAVE_FONTS is set, but in a way that won't
> >> work in multi-domain PCI situations.
> >> 
> >> So we need to set this up in the drivers just like we do for the
> >> 'vgabase' member.
> >> 
> >> I'll work on some patches to fix this.
> > 
> > Alex, give this a try.
> 
> Sorry, forgot the patch, here it is :-)
> 
> diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c

[ snip ]

>  	/* Find how many physical memory there is on card */
>  	memsize1 = (vga_rseq(par->state.vgabase, 0x34) + 1) >> 1;

It's a step in the right direction. With this patch added to the
svgalib/vgastate modules, it doesn't crash as bad as it used to. The
errors in the logs looks like it's accessing the PCI registers, don't
really understand what it's complaining about though:

Jan 12 21:53:10 sodium kernel: fb1: S3 Virge/GX on 0000:00:03.0, 6 MB RAM, 14 MHz MCLK
Jan 12 21:53:18 sodium kernel: eth0: Link down, cable problem?
Jan 12 21:53:27 sodium pci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700pci@8,pci@8,700000: PCter Aborpci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0080] was_block(0) space(Memory)
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI AFAR [00000000000a00a8]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Secondary errors [(Master Abort)]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0040] was_block(0) space(Memory)
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI AFAR [00000000000a00b8]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Secondary errors [(Master Abort)]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0008] was_block(0) space(Memory)
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI AFAR [00000000000a00c8]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Secondary errors [(Master Abort)]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0004] was_block(0) space(Memory)
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI AFAR [00000000000a00d8]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Secondary errors [(Master Abort)]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0002] was_block(0) space(Memory)
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI AFAR [00000000000a00e8]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Secondary errors [(Master Abort)]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0080] was_block(0) space(Memory)
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI AFAR [00000000000a00f0]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Secondary errors [(Master Abort)]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: PCI Error, primary error type[Master Abort]
Jan 12 21:53:27 sodium kernel: /pci@8,700000: bytemask[0010] was_block(0) space(Memory)

I simply did the following:

fbset -i -fb /dev/fb1 (which correctly printed the mode information)
fbset -fb /dev/fb1 -g 1024 768 1024 768 8

at this point it crashed, nothing in the logs, not even a
CTRL-ALT-SYSRQ-S/B could get it out of the deep hole it'd dug for
itself. 
-- 
Tactical Nuclear Kittens
