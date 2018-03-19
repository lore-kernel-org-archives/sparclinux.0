From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 19 Mar 2018 17:11:40 +0000
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180220233935.GE32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180318.120734.1936832399192758981.davem@davemloft.net>
In-Reply-To: <20180318.120734.1936832399192758981.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: khalid.aziz@oracle.com, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, yinghai@kernel.org, linux-kernel@vger.kernel.org, david.ahern@oracle.com, linux@iam.tj

On Sun, Mar 18, 2018 at 12:07:34PM -0400, David Miller wrote:
> From: Bjorn Helgaas <helgaas@kernel.org>
> Date: Tue, 20 Feb 2018 17:39:35 -0600
> 
> > Both these patches are on my pci/sparc branch and appeared in the
> > Feb 19 linux-next tree.
> > 
> > Any testing and feedback (especially on the second patch, which should
> > change /proc/iomem) would be great.
> > 
> > They're headed for v4.17 unless I hear about issues.
> > 
> > It would be useful to hear about what's still broken so I can try to
> > pull in the other patches.
> 
> I don't understand why you put the SYSTEM and Video ROM at addresses
> relative to absolute zero.  The result of this is that it might
> overlap real physical memory.
> 
> If a VGA card is present, it's ROM will respond to those addresses
> relative to the PCI controller's MEM space area.

I could have worded the changelog better.  This is about reserving PCI
bus addresses 0xc0000-0xc7fff, not the VGA framebuffer at
0xa0000-0xbffff.

If I understand correctly, a VGA device will respond to the
framebuffer at 0xa0000-0xbffff, but the device itself will not respond
to the 0xc0000-0xc7fff range.  I think the typical x86 PC arrangement
is that the BIOS reads the VGA option ROM using the normal relocatable
expansion ROM BAR and copies it into system memory at 0xc0000, so it
is in real physical memory.

I don't know what sparc firmware does, but I'm assuming the VGA PCI
device behaves the same in that it wouldn't respond to 0xc0000 itself.

> Their legacy resources are "hardwired", but those hardwired addresses
> need to be relative to the PCI host controller's MEM areas in order
> for them to be accessible.
> 
> I could understand removing the System ROM resource altogether, that
> makes a lot of sense to me.

Do you want me to remove the System ROM resource?  If so, I'll
make a separate patch to remove it, followed by one that does
whatever we figure out is the right thing for the video ROM.

Thanks for the feedback.

Bjorn
