From: David Miller <davem@davemloft.net>
Date: Mon, 19 Mar 2018 18:28:31 +0000
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <20180319.142831.793002554436316260.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180220233935.GE32228@bhelgaas-glaptop.roam.corp.google.com>
	<20180318.120734.1936832399192758981.davem@davemloft.net>
	<20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: helgaas@kernel.org
Cc: khalid.aziz@oracle.com, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, yinghai@kernel.org, linux-kernel@vger.kernel.org, david.ahern@oracle.com, linux@iam.tj

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 19 Mar 2018 12:11:40 -0500

> I could have worded the changelog better.  This is about reserving PCI
> bus addresses 0xc0000-0xc7fff, not the VGA framebuffer at
> 0xa0000-0xbffff.
> 
> If I understand correctly, a VGA device will respond to the
> framebuffer at 0xa0000-0xbffff, but the device itself will not respond
> to the 0xc0000-0xc7fff range.  I think the typical x86 PC arrangement
> is that the BIOS reads the VGA option ROM using the normal relocatable
> expansion ROM BAR and copies it into system memory at 0xc0000, so it
> is in real physical memory.
> 
> I don't know what sparc firmware does, but I'm assuming the VGA PCI
> device behaves the same in that it wouldn't respond to 0xc0000 itself.

The Sparc firmware doesn't copy the VGA option ROM.

That physical address location 0xc0000 in system memory is just
normal memory and most likely the kernel image itself is residing
there.

>> I could understand removing the System ROM resource altogether, that
>> makes a lot of sense to me.
> 
> Do you want me to remove the System ROM resource?  If so, I'll
> make a separate patch to remove it, followed by one that does
> whatever we figure out is the right thing for the video ROM.

Porbably it makes the most sense to remove both, given the above.
