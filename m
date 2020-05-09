From: Chen Zhou <chenzhou10@huawei.com>
Date: Sat, 09 May 2020 09:18:49 +0000
Subject: [PATCH -next 2/2] sparc: use snprintf() in show_pciobppath_attr() in vio.c
Message-Id: <20200509091849.116954-3-chenzhou10@huawei.com>
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
 arch/sparc/kernel/vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index c7cad9b7bba7..4f57056ed463 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -193,7 +193,7 @@ show_pciobppath_attr(struct device *dev, struct device_attribute *attr,
 	vdev = to_vio_dev(dev);
 	dp = vdev->dp;
 
-	return snprintf (buf, PAGE_SIZE, "%pOF\n", dp);
+	return scnprintf(buf, PAGE_SIZE, "%pOF\n", dp);
 }
 
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
-- 
2.20.1
