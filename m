Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422E1C861D
	for <sparclinux@vger.kernel.org>; Mon,  4 May 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918413; cv=none; b=PpY9PxXgloTZ8Zk7trtq+cvBGZibYmP1Ub11C5hm0+OUKUChHKAh4strmvWaGdEENr5BoJo+erFunWc1uodXi5Pci34rs90WWwi+/ZWXgCpupIYNlgfTJ8EJCYvbKa1KFQ0KGDhnUtKYtbJ8DvvPwl6/gv3dSGKCYuICmI+lmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918413; c=relaxed/simple;
	bh=tlFL8ChItjemz0vXXsv/W+8TvOqaR2U36ov7vwpCF1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMtRfNt0kRgb+K+2+SuTF71nfj0yoZVqQma291slYiUwwDbhqA+3who6MrqBFHDl76jGItQ1lKu1LV80kLElWegnQuqJARtFG5fiBPhx2Dnf9aC8sXjIH2JCi3KK70tpTa0zcSpTBc/r3VLvE3l9bA2oD4TKHucgemn4ev6eQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hjd6mmwy; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hjd6mmwy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777918410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yo/vp8ckmH5+wr7xeteGlSDNMbPclc1e9B0ZY6/l4EE=;
	b=hjd6mmwyd18MWCLf+CRUDRu7gWtVcQzLUP1UZT897rlro7qvYbK/G6BBorp/0QrNcYMuTK
	cJWQLJH1hm3Qlgvsrl83AIzMZUBYJaC1RFhILLbn+VTbZbDuRv1Mrm/hCkX8g+xRU2MGVD
	SgEnpTxP0HIui3PQVNo03/dzqkzXd4Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sparc: vio: use sysfs_emit in sysfs show functions
Date: Mon,  4 May 2026 20:13:20 +0200
Message-ID: <20260504181320.143003-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=thorsten.blum@linux.dev; h=from:subject; bh=tlFL8ChItjemz0vXXsv/W+8TvOqaR2U36ov7vwpCF1E=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk/Hh5Y4Zn1LePGeVM2zuXHpwVO4C15f3dSmqLwqZO33 ts9VXCY0VHKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATORvGyDDzzmG77cXHs327 GNdPWfJ/zonTX53Ct0y+3bReeV+wW912Robt8XnL10uval+5m/+whsf7X8vvbuhimj/XlWXp+o3 JfwI4AA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() and scnprintf() with sysfs_emit() in sysfs show
functions. sysfs_emit() is preferred to format sysfs output as it
provides better bounds checking.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/vio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 8b4f55047716..b7b06752a038 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -121,7 +122,7 @@ static ssize_t devspec_show(struct device *dev,
 	else if (!strcmp(vdev->type, "vdc-port"))
 		str = "vdisk";
 
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 static DEVICE_ATTR_RO(devspec);
 
@@ -129,7 +130,7 @@ static ssize_t type_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *vdev = to_vio_dev(dev);
-	return sprintf(buf, "%s\n", vdev->type);
+	return sysfs_emit(buf, "%s\n", vdev->type);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -138,7 +139,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	const struct vio_dev *vdev = to_vio_dev(dev);
 
-	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
+	return sysfs_emit(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -192,7 +193,7 @@ show_pciobppath_attr(struct device *dev, struct device_attribute *attr,
 	vdev = to_vio_dev(dev);
 	dp = vdev->dp;
 
-	return scnprintf(buf, PAGE_SIZE, "%pOF\n", dp);
+	return sysfs_emit(buf, "%pOF\n", dp);
 }
 
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
