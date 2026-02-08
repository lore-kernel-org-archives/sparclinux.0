Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A621221F1C
	for <sparclinux@vger.kernel.org>; Sun,  8 Feb 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770542866; cv=none; b=fzUpGyYZDkYM8BwuGyFcLsQy/KWlLYBmPZPzfu2gU4dzVRhhBsd4/7clRe38PMglM2mNuxEMFGydc2T3Fgy5KwyhXqIf9SpHVagp0HcLn852LAg+LPGk1ttVjijCxGuWtzKU84sm2grkCYwGpbrnNHm0iNiBDOlf15XqQfwDAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770542866; c=relaxed/simple;
	bh=ql36eZjf2Hp8ftpME0qTlJjK8vonhHM+3K6Hi9Ss3iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mixpMHbjcH6fnwrfcxDSZ4QOWvVWUBnxjpNiFlj0DHwO5UegiB/NUbuZ1WSUBWQ5zexrMimPfJbDAyNptTBzFm6b18fDdpITfXHMCkBcWhnAW8Wzx7bMMVv4X8RTZ/bG4vJR660kGIIxIAaWBNxOvL/mQxyALMT3EGfOfIB3HLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YDZk43T/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YDZk43T/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770542854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BltP21DZjH+jxJUxQg6H58ROoHC9sfcwA06UtM64JaE=;
	b=YDZk43T/6Nbez8DjZBMNnXQnFRI+IV+7Gdby5ahJnztie5S4r96nDZ3P564oFt6plNwyX5
	kCgXJouy35CvoCZubKweW7LICVe5Xbv6L2HpDA6THQwYbwRGH/cON9xBOvvN8EU9qStdKq
	stWOxSEHHB2J/g/vYjGz9pj7FAZlQNE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: vio: Use sysfs_emit in sysfs show functions
Date: Sun,  8 Feb 2026 10:26:55 +0100
Message-ID: <20260208092656.95613-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
index 8c7dd72ef334..f9375f7b0bbb 100644
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
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

