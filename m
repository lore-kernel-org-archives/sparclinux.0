Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A32156861;
	Wed, 18 Dec 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508402; cv=none; b=mudg8LZhKeh7cHDWF2Y0fPWkY9iPwcZLUMGHXWMPzYCDWnQ/mPHRHY5IZosOTqFa2qMLMDHZLX3YX12BNoScYlPzLl1J3FT9rUdcwC/F0KzVaEF3W+lVsBjfmBMc37CBHyhoS4J1PkpRLXF1QzBfu6ehRGA9dVIJH9EvNg0L2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508402; c=relaxed/simple;
	bh=IXqf6FsGwTidhRHKmnRBoVE5TYiqlc76PRtEg9eaKG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lGu2o+H4nT25snaMawheD1ejjxFOjpy/E5HeAkkJMLmokq9FyMoUeoRadwFiM5D7O+WVSeWbm1MJjXOOHDlQ0r4aL/7+ZuZEEMcJGJUs2++GIwsCnG/HA01j33Lj5JwlB2bHKo8eC28qXoUZ28keazwUxC0DZlDVPsA8IG1Hqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YCm8R48hWz21nZB;
	Wed, 18 Dec 2024 15:51:19 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id D6045180041;
	Wed, 18 Dec 2024 15:53:11 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Dec
 2024 15:53:11 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <davem@davemloft.net>, <andreas@gaisler.com>, <rdunlap@infradead.org>,
	<zhangkunbo@huawei.com>, <bhelgaas@google.com>
CC: <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chris.zjh@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH -next] sparc: replace zero-length array with flexible-array member
Date: Wed, 18 Dec 2024 07:44:39 +0000
Message-ID: <20241218074439.3271397-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100007.china.huawei.com (7.202.181.92)

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1],
introduced in C99:

struct foo {
	int stuff;
	struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last, which is beneficial
to cultivate a high-quality code.[2]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 arch/sparc/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 50a0927a84a6..ddac216a2aff 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -932,7 +932,7 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 {
 	const struct pci_slot_names {
 		u32	slot_mask;
-		char	names[0];
+		char	names[];
 	} *prop;
 	const char *sp;
 	int len, i;
-- 
2.34.1

