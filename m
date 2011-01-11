From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:48:46 +0000
Subject: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <20110111.154846.233419170.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


This patch set makes sure that FB drivers for PCI devices utilizing
the svgalib interfaces work on multi-domain PCI architectures.

Basically this amounts to making sure that the vgastate->vgabase
__iomem pointer makes it way into every interfaces and gets used
by all of the I/O access calls.

All of arkfb, s3fb, and vt8623fb have been converted.

Signed-off-by: David S. Miller <davem@davemloft.net>
