From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 28 Feb 2013 14:30:21 +0000
Subject: [PATCH 2/2] sparc32,leon: add support for PCI busn resource in GRPCI2 driver
Message-Id: <1362061821-31584-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_pci_grpci2.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index fc43208..40fdcbc 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -788,6 +788,11 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 	if (request_resource(&ioport_resource, &priv->info.io_space) < 0)
 		goto err4;
 
+	/* setup maximum supported PCI buses */
+	priv->info.busn.name = "GRPCI2 busn";
+	priv->info.busn.start = 0;
+	priv->info.busn.end = 255;
+
 	grpci2_hw_init(priv);
 
 	/*
-- 
1.7.0.4

