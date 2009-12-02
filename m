From: David Miller <davem@davemloft.net>
Date: Wed, 02 Dec 2009 23:06:24 +0000
Subject: T5240 onboard ethernet detection...
Message-Id: <20091202.150624.90790575.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This machine uses NIU as the onboard ethernet, but for
whatever reason the debian installer couldn't find it
in the stable install images.

The debian kernel does have the driver built into it, so it's
something to do with detection by device IDs or whatever I suppose.

NIU can appear on sparc64 in two forms.  Either as a PCI device, or as
an OpenFirmware device.

The driver module does have the proper device recognition tags, one
for PCI:

static struct pci_device_id niu_pci_tbl[] = {
	{PCI_DEVICE(PCI_VENDOR_ID_SUN, 0xabcd)},
	{}
};

MODULE_DEVICE_TABLE(pci, niu_pci_tbl);

and one for OpenFirmware:

static const struct of_device_id niu_match[] = {
	{
		.name = "network",
		.compatible = "SUNW,niusl",
	},
	{},
};
MODULE_DEVICE_TABLE(of, niu_match);

The module did load properly when I booted into the installation.

This machine has the PCI variant of the device.

Perhaps the presence of two different kinds of device tables in the
same kernel module is confusing the logic the installer uses to detect
the ethernet device during installation?
