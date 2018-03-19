From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 19 Mar 2018 19:38:54 +0000
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <20180319193854.GI77194@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180220233935.GE32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180318.120734.1936832399192758981.davem@davemloft.net>
 <20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
 <20180319.142831.793002554436316260.davem@davemloft.net>
In-Reply-To: <20180319.142831.793002554436316260.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: david.ahern@oracle.com, Alex Williamson <alex.williamson@redhat.com>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, linux@iam.tj, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, khalid.aziz@oracle.com, sparclinux@vger.kernel.org, yinghai@kernel.org

[+cc Dave, Alex, dri-devel]

On Mon, Mar 19, 2018 at 02:28:31PM -0400, David Miller wrote:
> From: Bjorn Helgaas <helgaas@kernel.org>
> Date: Mon, 19 Mar 2018 12:11:40 -0500
> 
> > I could have worded the changelog better.  This is about reserving PCI
> > bus addresses 0xc0000-0xc7fff, not the VGA framebuffer at
> > 0xa0000-0xbffff.
> > 
> > If I understand correctly, a VGA device will respond to the
> > framebuffer at 0xa0000-0xbffff, but the device itself will not respond
> > to the 0xc0000-0xc7fff range.  I think the typical x86 PC arrangement
> > is that the BIOS reads the VGA option ROM using the normal relocatable
> > expansion ROM BAR and copies it into system memory at 0xc0000, so it
> > is in real physical memory.
> > 
> > I don't know what sparc firmware does, but I'm assuming the VGA PCI
> > device behaves the same in that it wouldn't respond to 0xc0000 itself.
> 
> The Sparc firmware doesn't copy the VGA option ROM.
> 
> That physical address location 0xc0000 in system memory is just
> normal memory and most likely the kernel image itself is residing
> there.
> 
> >> I could understand removing the System ROM resource altogether, that
> >> makes a lot of sense to me.
> > 
> > Do you want me to remove the System ROM resource?  If so, I'll
> > make a separate patch to remove it, followed by one that does
> > whatever we figure out is the right thing for the video ROM.
> 
> Porbably it makes the most sense to remove both, given the above.

I'd be happy to remove both.  But I wonder how X init works on sparc.

I thought X had code to run the option ROM under emulation and I
wondered if that might rely on the ROM image being at 0xc0000.  Maybe
it reads it from the sysfs "rom" file?  That would be available
regardless of what firmware does, but I have a dim recollection of 
something being more complicated than just reading the image directly
from the ROM.

Maybe Dave or Alex know the details?

Bjorn
