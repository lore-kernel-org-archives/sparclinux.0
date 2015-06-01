From: David Miller <davem@davemloft.net>
Date: Mon, 01 Jun 2015 05:46:00 +0000
Subject: Re: [PATCH v3] sparc64: pci slots information is not populated in sysfs
Message-Id: <20150531.224600.1075689459822292279.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Wed, 27 May 2015 11:59:19 -0400

> Add PCI slot numbers within sysfs for PCIe hardware.  Larger
> PCIe systems with nested PCI bridges and slots further
> down on these bridges were not being populated within sysfs.
> This will add ACPI style PCI slot numbers for these systems
> since the OF 'slot-names' information is not available on
> all PCIe platforms.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

Applied.
