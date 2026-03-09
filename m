Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D8246766
	for <sparclinux@vger.kernel.org>; Mon,  9 Mar 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096332; cv=none; b=FoPty5LHBkFxjV1h3u/7nlRXLMvFsmljqEWkeqQk89EC8H6bAEzBQesBOiPB77gVQBN6KuIIVfcywF5Hdi3A4BSAoUm3zmWLYacDYKh8cXRz1nDGxMbPc7Z8t0fY+ZixZkp+dgdb32ET/II96btpdAIHuS23727EGTR/qd6eOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096332; c=relaxed/simple;
	bh=tlFL8ChItjemz0vXXsv/W+8TvOqaR2U36ov7vwpCF1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzekyjUmGtWA99ngZDBp07dZSCE1z39Kb2WIy5XHWC7CETyST+bCIz+3idLH/A72+w83w7GOTlNE/jU7ER2pv0Rufv0Ft7UcCRCkSQjfp8K+TkDEBPhtXY6obhjes1q0qI2DW6kY0WUdDXIay+lmazDigFPj58EuDurb+WURjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AnUlRFlI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AnUlRFlI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773096328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yo/vp8ckmH5+wr7xeteGlSDNMbPclc1e9B0ZY6/l4EE=;
	b=AnUlRFlIUHKhXIdh3PpTQU+0VjJuInLFsAanJqife4rCOQiEYUjzXIu326+wFVoktTZTkz
	1eSl2UTWwLAUIcwPTTUUHAnKmaa6tMJSVKjbL1fyspHSaxcMt44zKOlHADcHmQRdLBrfva
	oxcfwvdiGjZn9B9NRND6LjD3+XiifDs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sparc: vio: Use sysfs_emit in sysfs show functions
Date: Mon,  9 Mar 2026 23:44:45 +0100
Message-ID: <20260309224444.84851-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=thorsten.blum@linux.dev; h=from:subject; bh=tlFL8ChItjemz0vXXsv/W+8TvOqaR2U36ov7vwpCF1E=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnrfWPuiJw5uMPncETlldK9a469/bMgcErloWdLvk+wc lNw3Jp7oKOUhUGMi0FWTJHlwawfM3xLayo3mUTshJnDygQyhIGLUwAmojab4Z92WnBQ+aNzjZwZ qk3znl5vEJ1xpPneTevF/6Z3BwlOZJzPyLDcNrZjx5wdV3+/Tc954bHh0hOtD/JMtqdENBrjLmd WJfIBAA==
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
