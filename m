Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462069;
	b=a6k84N6KKRpqusjU/iLS/ySouNUOFitvRCTih8E3Cxs4L9Czjc4jr+6H+LDNkzMJnkyV
	 qg1ECChwZDLdLbkt2AziIBLOwDCZeDABEKXjT8dVUx0PH+DviMkYy6jR+Ihh1GNcCQ6wQ
	 59NL+wEnIeXMrZZHH9wfmgY/4u03smr/EjqS56/mcI9wm2J8JcPSGIgbq3EKwXYXAEIUc
	 gh2UtxpeLmHaNeSvMAZiB1dfhXvR7YmhRQrVG0B4LcxfMyeuduSLJdHCeb6zUSe1R3mhx
	 tudK/pn1ZCjj2ZnLY/9RMzpU1eJn9/rd1xbb1QpO19eNOCMwiWZ55nr0Yr2/onoccDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462069;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=qBHdoagkk+A0fsy76vSc4FnpSrSPag0oJul/CgFFiEQ=;
	b=4TljuNo+6OV76S7/dzeoqooqf8Og0dxzH605Id7RTLRk8VSMN+DWHhylFbuKbUixkIcO
	 DVV1q794hW0wrn55RXPY/P7UulvWhioTf33DsjXarlsfCKwHMMNYFbX8eNSeMbBuqjtFS
	 uzXA7bQ5mQnpdC1SC4favh/UFEhlRNbd8N6u5glxF2t5XiTjH5ChoDV1nn2HG40p13IoK
	 4utrspsSx/Ndvu/K4SgO0hPIX8Ui+C356t6um47Qit1YyqTuedU5CpNUlESRB7Ps8IHoC
	 P/9yJwWZxsKlT2nb0clre/oDylegIiJPEJFaZvroqxrs/I23Xpc1l457AFmpMl7t+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eJA84BHH;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE214606A31B;
	Tue, 20 Oct 2026 02:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE214606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eJA84BHH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qB
	Hdoagkk+A0fsy76vSc4FnpSrSPag0oJul/CgFFiEQ=; b=eJA84BHHY56Ct69Zp0
	Px7Uq1uTPQpAs/7fATq7M5w02ixhfRufPlVtu9vuD+SrN9lpka45e1G/nVr6LpBb
	Z9JSoLHNwfl4gIV0voEp/RIv16H70H8p0cZQO4NSjiTeTXK9Il8MT11eXTjVRRQ4
	1ngpjhVmEBAtLzVwKXaJnQVtg=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3Rx7jzNZqk7V_BA--.64549S2;
	Tue, 20 Oct 2026 10:07:33 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] sparc: ldc: Protect the global channel list
Date: Tue, 20 Oct 2026 10:07:23 +0800
Message-ID: <20261020020723.513529-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Rx7jzNZqk7V_BA--.64549S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr13XFW8ZFyfXw15Zw4DXFb_yoWrWw1UpF
	Z09rW5XrWUWF98u3Z7J3WUuFyruw4kW3yUG3sIga4xZ3y7trn2vr98t3WDKr15ArWxJFWY
	qrZxJF4Duw45A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirOzxUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC-AW8oGrWzOUUeQAA3d

The global LDC channel list is traversed by the duplicate-ID check in
ldc_alloc(), updated by ldc_alloc(), and modified by ldc_free() without
any common lock.  Consequently, two concurrent allocations can both
observe that an ID is absent, and allocation can race removal of another
channel.

The race is reachable from process context when LDOM virtual-device
channels are configured concurrently, for example while different channel
consumers probe or remove their devices.  A racing insert and delete can
corrupt the hlist or leave a stale node for a channel that is being
freed, leading to a use-after-free during a later ID check.  The
duplicate-ID check is also ineffective because another thread can insert
the same ID between the check and publication.

The allocation path also publishes the channel before request_irq() has
succeeded.  Its current IRQ failure cleanup frees the object without
unhashing it, so keep the node uninitialized until both IRQ handlers are
registered successfully.

Protect the check/publication and removal paths with a mutex, and publish
the node only after both IRQ registrations have succeeded.  Allocation and
free are sleeping, process-context interfaces, so a mutex is appropriate.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: e53e97ce3c71 ("[SPARC64]: Add LDOM virtual channel driver and VIO device layer.")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 arch/sparc/kernel/ldc.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 826fe8ed0289..fbb3021158bd 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -952,13 +953,8 @@ static irqreturn_t ldc_tx(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* XXX ldc_alloc() and ldc_free() needs to run under a mutex so
- * XXX that addition and removal from the ldc_channel_list has
- * XXX atomicity, otherwise the __ldc_channel_exists() check is
- * XXX totally pointless as another thread can slip into ldc_alloc()
- * XXX and add a channel with the same ID.  There also needs to be
- * XXX a spinlock for ldc_channel_list.
- */
+/* Serializes ldc_channel_list and the channel-ID uniqueness check. */
+static DEFINE_MUTEX(ldc_channel_lock);
 static HLIST_HEAD(ldc_channel_list);
 
 static int __ldc_channel_exists(unsigned long id)
@@ -1165,16 +1161,17 @@ struct ldc_channel *ldc_alloc(unsigned long id,
 	if (hv_err == HV_ECHANNEL)
 		goto out_err;
 
+	mutex_lock(&ldc_channel_lock);
 	err = -EEXIST;
 	if (__ldc_channel_exists(id))
-		goto out_err;
+		goto out_err_locked;
 
 	mssbuf = NULL;
 
 	lp = kzalloc_obj(*lp);
 	err = -ENOMEM;
 	if (!lp)
-		goto out_err;
+		goto out_err_locked;
 
 	spin_lock_init(&lp->lock);
 
@@ -1223,9 +1220,6 @@ struct ldc_channel *ldc_alloc(unsigned long id,
 	lp->hs_state = LDC_HS_CLOSED;
 	ldc_set_state(lp, LDC_STATE_INIT);
 
-	INIT_HLIST_NODE(&lp->list);
-	hlist_add_head(&lp->list, &ldc_channel_list);
-
 	INIT_HLIST_HEAD(&lp->mh_list);
 
 	snprintf(lp->rx_irq_name, LDC_IRQ_NAME_MAX, "%s RX", name);
@@ -1243,6 +1237,11 @@ struct ldc_channel *ldc_alloc(unsigned long id,
 		goto out_free_txq;
 	}
 
+	INIT_HLIST_NODE(&lp->list);
+	hlist_add_head(&lp->list, &ldc_channel_list);
+
+	mutex_unlock(&ldc_channel_lock);
+
 	return lp;
 
 out_free_txq:
@@ -1257,6 +1256,9 @@ struct ldc_channel *ldc_alloc(unsigned long id,
 out_free_ldc:
 	kfree(lp);
 
+out_err_locked:
+	mutex_unlock(&ldc_channel_lock);
+
 out_err:
 	return ERR_PTR(err);
 }
-- 
2.43.0

