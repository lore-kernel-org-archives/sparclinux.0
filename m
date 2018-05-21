From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 21 May 2018 20:10:38 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <20180521201038.GF41790@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
 <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804102144240.32411@math.ut.ee>
 <20180410185610.GD24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804111045330.18432@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1804111045330.18432@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, Apr 11, 2018 at 10:59:19AM +0300, Meelis Roos wrote:
> Fire V210: Video RAM BAR error is gone, these are still here:
> [    5.061083] pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> [    5.061334] pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with 0001:00:07.0 [mem 0x7ff00000000-0x7ff000fffff]

From lspci (https://bugzilla.kernel.org/attachment.cgi?id'5239):

  0001:00:06.0 ULi Electronics Inc. M7101 Power Management Controller
    Region 0: [virtual] I/O ports at <unassigned> [size]
  0001:00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge
    Region 0: [virtual] I/O ports at 7fe01000000 [sizedK]
    Region 1: [virtual] Memory at 7ff00000000 (32-bit, non-prefetchable) [size=1M]
    Region 2: [virtual] Memory at 7ff00000000 (32-bit, non-prefetchable) [size=1M]

From dmesg log (https://bugzilla.kernel.org/attachment.cgi?id'5237):

  pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
  pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB

The 0001:00:07.0 BAR 0 conflict is with the ali7101 quirk.  I don't
know how to fix that.  The quirk doesn't match up with the M1543/M7101
docs I can find, but the quirk has been there forever and I don't
think we can safely change it.

The BAR 2 conflict is with 0001:00:07.0's own BAR 1.  I think those
come from OF, not directly from the hardware, and it looks like an OF
error that BAR 1 and BAR 2 are the same.

We could filter out duplicates like this if they cause a problem.  But
I'm not sure whether anything actually breaks because of this
conflict.

After the VGA framebuffer change, do you see anything that's still
broken (besides the "can't claim" messages, I mean)?

> Fire V240: Video RAM BAR errors is gone, these are still here:
> [    5.530237] pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> [    5.530389] pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with 0001:00:07.0 [mem 0x7ff00000000-0x7ff000fffff]

Looks the same as V210.

> Fire V440: Video RAM BAR error is gone, these are still here:
> [    5.082920] pci 0002:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0002:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> [    5.082945] pci 0002:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with 0002:00:07.0 [mem 0x7ff00000000-0x7ff000fffff]

Looks the same as V210.

> Blade 100: Video RAM related BAR error is gnone, this is still here:
> [    6.131499] pci 0000:00:07.0: can't claim BAR 0 [io  0x1fe02000000-0x1fe0200ffff]: address conflict with 0000:00:03.0 [io  0x1fe02000600-0x1fe0200061f]

Looks the same as V210, except that the firmware apparently doesn't
have the duplicate BAR 1/2 that the other boxes have.
