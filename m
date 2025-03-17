Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C121B19E;
	Mon, 17 Mar 2025 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198345; cv=none; b=GRWZt4jW1crP4Uns2VPHr/jgezIZnNi4uEF2gR/fDcxa12E0omDXS2K5/ZHJ2ItZck5HVL7PgNX22y70YSkHVF1jCSXXo0LhYX8KgLgQg5TJgCnzdaJPJE46bkaSinKKai5mDrjKl1IMygdTZQFfrH3+Oe52UwocCa25poI3RmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198345; c=relaxed/simple;
	bh=uqXlMhmLB9R3Z+lGdy71/yzhmji7GGi92P8qqFpGnGk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=e2xiboWW/7EN3OwZp3g4bLDcFIz6aNovIKDeiyYrPlBMz4ndK7PUtj3qMUWB+dtO1f85qRzDFdwiT9yhvmKb3JE9f1+gSq+XS0byPsPjB2NuQwqBdTQGtaUKIPJqFXg+qvjrVjWJZXZCBD89gKGsGRxekeflit3hE2YdCrCo9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGS6B4Zqtz501gJ;
	Mon, 17 Mar 2025 15:58:58 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52H7wbQ2044474;
	Mon, 17 Mar 2025 15:58:37 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:58:39 +0800 (CST)
Date: Mon, 17 Mar 2025 15:58:39 +0800 (CST)
X-Zmail-TransId: 2afa67d7d62fffffffffb17-33f49
X-Mailer: Zmail v1.0
Message-ID: <20250317155839844Il-ucxcy_UAEF0tTd7FX6@zte.com.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <andreas@gaisler.com>
Cc: <davem@davemloft.net>, <zhangkunbo@huawei.com>, <xie.ludan@zte.com.cn>,
        <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNwYXJjOiB1c2Ugc3lzZnNfZW1pdCgpIGluc3RlYWQgb2Ygc2NucHJpbnRmKCku?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H7wbQ2044474
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D642.000/4ZGS6B4Zqtz501gJ

From: XieLudan <xie.ludan@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
---
 arch/sparc/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index ddac216a2aff..917e1db3164e 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -593,7 +593,7 @@ show_pciobppath_attr(struct device * dev, struct device_attribute * attr, char *
 	pdev = to_pci_dev(dev);
 	dp = pdev->dev.of_node;

-	return scnprintf(buf, PAGE_SIZE, "%pOF\n", dp);
+	return sysfs_emit(buf, "%pOF\n", dp);
 }

 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH, show_pciobppath_attr, NULL);
-- 
2.25.1
