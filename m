From: Christoph Hellwig <hch@lst.de>
Date: Mon, 31 May 2004 12:44:55 +0000
Subject: RFC: defining sbus dma direction bits in terms of enum dma_data_direction?
Message-Id: <20040531124455.GA16822@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We've been able to get rid of most of the scsi_to_pci_dma_dir mess in
2.6 now that both pci and scsi data directions are defined in terms of
the generic enum dma_data_direction.  Any chance to switch sbus over
to using it aswell?  And while we're at it, if someone cares for the
sbus scsi drivers:  any chance to convert them awaya from needing scsi.h
and hosts.h in drivers/scsi/ to the <scsi/*.h> headers?  It's really
just some boring decrufting, mostly killing obsolete typedefs.
