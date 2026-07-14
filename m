Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B043CEE9;
	Tue, 14 Jul 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020462; cv=none; b=VhlBDjiiEFSOq7gn9iNBDzzSVW4D+j4bS2b06JbXL3der++sEhJwnhKCXu3jdOUUIkkPxPB1mljXGJbiEn6h4cYk/6mRFT/sjOX9EyQifvo3DMO0iCNUlNPuMSJVAcUvwmZvX2XP9V2MpXqicN3esyL7EwnyBKh8rKNhD1qkZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020462; c=relaxed/simple;
	bh=TGjwDLWm8OgJ1SgQvLvIUr20LmXPnjHtwYakKzdGUuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxyjG3W0R6n07niJpKv1oImoSlTHV/qChS4g7JnGVk8TmgBvihMrrXOQ2PGDBKI6accxR1Ww6IgeLfZrdnJZzSdL4XLvkp5VlRywaboptWcM/dAAz+/iQLld/so8wILNU7E8Ufugjrcqbvfv33Xm3fLYLakMihJzuoFfjJw13Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ff038007f6411f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:83b3b263-8d9e-4e6b-b62d-319302d392a5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:20fca517386fb6f0bb7c881d153baa0f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ff038007f6411f1aa26b74ffac11d73-20260714
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1164100889; Tue, 14 Jul 2026 17:14:10 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: davem@davemloft.net,
	andreas@gaisler.com,
	kees@kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] ioport: Use kzalloc() instead of kmalloc()/memset() in _sparc_alloc_io()
Date: Tue, 14 Jul 2026 17:13:49 +0800
Message-ID: <20260714091350.511-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc+memset by kzalloc for better readability and simplicity.
This addresses the warning below:
WARNING: kzalloc should be used for data, instead of kmalloc/memset

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 arch/sparc/kernel/ioport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index cbc0680a4642..df73439b290c 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -184,9 +184,8 @@ static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
 			printed_full = 1;
 		}
 		tlen = strlen(name);
-		tack = kmalloc(sizeof (struct resource) + tlen + 1, GFP_KERNEL);
+		tack = kzalloc(sizeof (struct resource) + tlen + 1, GFP_KERNEL);
 		if (tack == NULL) return NULL;
-		memset(tack, 0, sizeof(struct resource));
 		res = (struct resource *) tack;
 		tack += sizeof (struct resource);
 	}
-- 
2.43.0

