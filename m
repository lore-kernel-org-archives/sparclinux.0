From: chris.hyser@oracle.com
Date: Wed, 28 Sep 2016 19:19:41 +0000
Subject: [PATCH v2 0/2] sparc64: PCIe performance enhancements
Message-Id: <201609281919.u8SJJfpe013095@userv0122.oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ver 2 is redone for 4.8 where commit 00085f1efa387a8ce100e3734920f7639c80caa3
changed DMA attributes from struct pointer to unsigned long.

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
