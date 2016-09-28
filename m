From: chris.hyser@oracle.com
Date: Wed, 28 Sep 2016 17:03:05 +0000
Subject: [PATCH 0/2] sparc64: PCIe performance enhancements
Message-Id: <201609281703.u8SH35MH028152@userv0122.oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This set of patches initiates a series of PCIe performance enhancement patch
submittals.

Patch 1/2 enables version 2 of the SPARC sun4v IOMMU I/O address translation
services need for subsequent enhancements.

Patch 2/2 allows drivers to specify DMA_ATTR_WEAK_ORDERING via DMA attributes
to the SPARC DMA mapping routines enabling "relaxed ordering" for the buffer
being mapped.


[Still relevant write-up]
PCI-Express Relaxed Ordering and the Sun SPARC Enterprise M-class Servers
https://blogs.oracle.com/olympus/entry/relaxed_ordering
