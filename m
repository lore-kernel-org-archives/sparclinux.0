From: Chen Zhou <chenzhou10@huawei.com>
Date: Sat, 09 May 2020 09:18:48 +0000
Subject: [PATCH -next 1/2] sparc: use snprintf() in show_pciobppath_attr() in pci.c
Message-Id: <20200509091849.116954-2-chenzhou10@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
In-Reply-To: <20200509091849.116954-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, chenzhou10@huawei.com

snprintf() returns the number of bytes that would be written,
which may be greater than the the actual length to be written.

show_pciobppath_attr() should return the number of bytes printed
into the buffer. This is the return value of scnprintf().

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/sparc/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 5ed43828e078..a41ad562ed4e 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -593,7 +593,7 @@ show_pciobppath_attr(struct device * dev, struct device_attribute * attr, char *
 	pdev = to_pci_dev(dev);
 	dp = pdev->dev.of_node;
 
-	return snprintf (buf, PAGE_SIZE, "%pOF\n", dp);
+	return scnprintf(buf, PAGE_SIZE, "%pOF\n", dp);
 }
 
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH, show_pciobppath_attr, NULL);
-- 
2.20.1
