Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A221A452;
	Mon, 17 Mar 2025 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198720; cv=none; b=H5PttBYgEfCvcR0sYNFxAByFpjK6q1n05LFeUYmWMfJdHuHbW8XfWVq3HGyDsP296c2Y8F8ezGxu8bsF43SKdtYKaRqTA51VbxNjTfhWZKrMBa1yNp/fWi8ynhWngiqyGZlqDMY/Mac2IpESCTW6z0SN57x9r3lwTnhuqJq74dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198720; c=relaxed/simple;
	bh=RwMkeIBIxFJW+tSUCzTJgCIyIdex8yDGlAh6hb/AgeU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=lgNeAnRHgptpBamLDgWGXGyKJZomo8zoOX3Swl1g618wyKuBXrH7LXRIf5c4dgjosJnBUfR21ZxHsNrsr6y3stEJ3lECnOGvk54x+uEOibdjfKAVbs6hdD6hg2l5iX3JPX6IJ0iJvGm/A8eUCj/U7kAEfio71o+IWr21rcjtzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGSFN5vXRz501g9;
	Mon, 17 Mar 2025 16:05:12 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 52H84sUP096505;
	Mon, 17 Mar 2025 16:04:54 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 16:04:56 +0800 (CST)
Date: Mon, 17 Mar 2025 16:04:56 +0800 (CST)
X-Zmail-TransId: 2af967d7d7a8ffffffffe6b-af222
X-Mailer: Zmail v1.0
Message-ID: <20250317160456854fAJoK7WQI_J5R7rPeyfxh@zte.com.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <andreas@gaisler.com>
Cc: <davem@davemloft.net>, <gregkh@linuxfoundation.org>, <ukleinek@kernel.org>,
        <jonathan.cameron@huawei.com>, <xie.ludan@zte.com.cn>,
        <mathieu.poirier@linaro.org>, <quic_zijuhu@quicinc.com>,
        <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNwYXJjL3ZpbzogdXNlIHN5c2ZzX2VtaXQoKSBpbnN0ZWFkIG9mIHNjbnByaW50ZigpLg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52H84sUP096505
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D7B8.003/4ZGSFN5vXRz501g9

From: XieLudan <xie.ludan@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
---
 arch/sparc/kernel/vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 1a1a9d6b8f2e..cbf38eca8d83 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -191,7 +191,7 @@ show_pciobppath_attr(struct device *dev, struct device_attribute *attr,
 	vdev = to_vio_dev(dev);
 	dp = vdev->dp;

-	return scnprintf(buf, PAGE_SIZE, "%pOF\n", dp);
+	return sysfs_emit(buf, "%pOF\n", dp);
 }

 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
-- 
2.25.1
