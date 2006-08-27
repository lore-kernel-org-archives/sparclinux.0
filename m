From: Kristoffer Carlsson <kristoffer@gaisler.com>
Date: Sun, 27 Aug 2006 14:28:14 +0000
Subject: pci layer
Message-Id: <44F1ABFE.1080102@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I'm adding PCI support to the LEON sparc linux port and I have
some questions for you.

The pci controller is set up to have one 256 MB big window to
which accesses generates PCI memory cycles and a 64 KB big
window for IO cycles.

First I configured the PCIBIOS_MIN_MEM/IO macros to match
these windows and called pci_scan_bus() followed by
pci_assign_unassigned_resources(). I got this working quite
nicely but I realised that the PCI IO resources should be
remapped by the kernel and not by the drivers.

I'm not sure in which way to achieve this. I tried to replace the
resource for pci devices with io from pcibios_fixup_bus somewhat
like in the sparc32 port but that seemed to be ignored by the
generic pci code.

I based my pci layer port on the sparc32 version but have taken
bits and pieces from other archs. Many archs seem to set the
PCIBIOS_MIN_MEM/IO to 0 and use request_resource to setup iomem_resource
and ioport_resource but I don't get that to work properly.

Can someone provide any helpful pointers to how this should
be done?

Regards,
Kristoffer Carlsson
