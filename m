Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B328642A;
	Mon, 21 Jul 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084549; cv=none; b=F5HeZo5+2ldhMBMyAz3R8UDkiQ5j/IL6RQBrPq731aKSs7ParcR7EVUNCujxewITTMozHH8DZETKrre4w/jX0END/8ETkEDn704yHcScIq+xw5MWgUq1jZSAkc4jKyV5c2kQWrUPiwuGNTnyP1Hg22EgjJe6W9gPjcFSiDZk39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084549; c=relaxed/simple;
	bh=GfYSWy2/bPllWsKP6h2y/yqp/ar2fqpe1YUItF9giJs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HuZxmEaw1Xw4XDdBTGbrRrAIHV5GOCBif0b0pTuQIrxRHiTPW+raVATXLm9I3t/dY3mvP3MW8MyiiFRUpnDDGal4U45oh17ZKpRP/f9vlqV7bUietnXuKcUUpLzSmxEj2BAbiyTiirg+/r6Y4okE7F81jN40FrvVeGJghcHCxvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U62o6CsE; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U62o6CsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753084536; bh=vzHtSk9e8oJPlBSGhwoRmuy++jiGtDh+nLFG83OGlBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U62o6CsEHEwUdELkQ8y7bLxijI0FlDRV+dppaEoE+t/eFSgjThvgkSmp/W+F8fGwN
	 dooSCObC+3WkfunOxL6GdOxflUW469timqv6fpeALJLsU9F3x4rkK3MXA/XkTTcdui
	 AgthldQPiCZlAPEeHkarpxrnIeXg267K8vr/M2t8=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.34])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id DE28B8DB; Mon, 21 Jul 2025 15:55:34 +0800
X-QQ-mid: xmsmtpt1753084534txvm8rmwv
Message-ID: <tencent_46DA24BE77C8E62514B3346C5CDBDB327F07@qq.com>
X-QQ-XMAILINFO: M2dBUVw0X9hnDfHShOjIB6LMbnLXMKJ9YsTXPcMTX4jTUnjPDMoM9NLLl9CLXK
	 vLkDAPPKm8dOTHswZm5klAvYCA2kpnG4by0JYtSQiInokLIVGYxMVEXJCqGyWgl5xabdeS8KeRFV
	 fZJtCCd58/alFjKXMUIJsscQq6omu/yeMSu+sO4Lnz6vKXaTT+GMZzUdhxOwBCZklngRQOVL6x++
	 VcQbBQdjU0RGYF9+568uU3IhNI8TUmLzm68sUCcgAFklmFR5fIH3CcIU16lZbuTXYI3xgUPGhnGL
	 CwB1s5eIJ7h7DFasWikk+iy0BRzewqdvcbJQg1VEpvrE3CJ9+zNhjc/rau219v24SZXOVQ3dB4VV
	 tt2vPnzEzVkedjeRP1zJqeeJkVeMKbhUz02BEImpf2r4pNPfCPELY39aqZlNsPFfJnDsdpPoV9ql
	 n0PO0QLguwAqYceVXaKtEpD269pVvP6F5J7J+5FBmM8SsyxE+BqDFENOJAI+4bzUM7I00ECrt2+p
	 X934fCWZ4JuKWGawyvGeyKV5cwNls3/xiK5fADneT1nmNG2nc1JS8QStVc/klRTRK70dxTVfHtd+
	 vVQqboPQlYOfCNnXsL/CVJspm82dKRdeqawIXonAzVSeOjEEWGa3CPB7fr8nz5pNgYVEynPAddJg
	 Al38t7vBKpC6ffpqNCZ9VyLXaVHGhSpIzNiKeU99O1ph/1BZbfKD9RqqTtt18L1N7Od38z63BTuK
	 Zt/p2cl/Cto3gVt3wcKKt0uJTO0aLgxhLoTX9anJLArUoqYlMwfT+vj5RSnwZMWyREj4+6s16lm5
	 /AeluJno57mJ45nxnx0h1cCz2KLNWAaNfsEjkF1Vt2DpJkCOtdKaUg72d8GtsvGFA99YnPzg9/UH
	 hB/c9DEW97Bgw2oWkOe06A95RPSTyEZL9fSOOM2mNQQVPs06VCB6497uI0gJxDwX2VAV65wbSQ79
	 kzynJsSyymBdBiq2ba/SjhwIv9zd/pNsWiMMOLAyJISi9yGMVXg4NQUtXudx9hPy7K4OB6+heAFH
	 IRqZUodn6Sc09nL2EZAlfjGzVjZ0fAD9s1UPwATarUf0mEh+DRNwi+0vtoW7MD5g7yOlxhT4CHLT
	 92DhjReaQz63P4MyA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: jackysliu <1972843537@qq.com>
To: markus.elfring@web.de
Cc: 1972843537@qq.com,
	andreas@gaisler.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v3] sparc: fix resource leak in jbusmc_probe()
Date: Mon, 21 Jul 2025 15:55:27 +0800
X-OQ-MSGID: <20250721075527.365761-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <45b8941a-b6bf-4b48-ad1b-cc6ba46b8642@web.de>
References: <45b8941a-b6bf-4b48-ad1b-cc6ba46b8642@web.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siyang Liu <1972843537@qq.com>

In the jbusmc_probe function, the device node mem_node fetched
via of_find_node_by_path("/memory") is not properly freed
on all code paths.
This can lead to leakage of device node reference counts,
which may result in kernel resources not being released.

This issue was detected by rule based static tools
developed by Tencent.

Fixes: e70140ba0d2b ("Get rid of 'remove_new' relic from platform driver struct")

Signed-off-by: Siyang Liu <1972843537@qq.com>
---
 arch/sparc/kernel/chmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index d4c74d6b2e1b..fd20e4ee0971 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -412,7 +412,7 @@ static int jbusmc_probe(struct platform_device *op)
 	mem_regs = of_get_property(mem_node, "reg", &len);
 	if (!mem_regs) {
 		printk(KERN_ERR PFX "Cannot get reg property of /memory node.\n");
-		goto out;
+		goto out_put;
 	}
 	num_mem_regs = len / sizeof(*mem_regs);
 
@@ -420,7 +420,7 @@ static int jbusmc_probe(struct platform_device *op)
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p) {
 		printk(KERN_ERR PFX "Cannot allocate struct jbusmc.\n");
-		goto out;
+		goto out_put;
 	}
 
 	INIT_LIST_HEAD(&p->list);
@@ -473,6 +473,10 @@ static int jbusmc_probe(struct platform_device *op)
 
 	err = 0;
 
+out_put:
+	of_node_put(mem_node);
+	goto out;
+
 out:
 	return err;
 
@@ -481,7 +485,7 @@ static int jbusmc_probe(struct platform_device *op)
 
 out_free:
 	kfree(p);
-	goto out;
+	goto out_put;
 }
 
 /* Does BANK decode PHYS_ADDR? */
-- 
2.43.5

