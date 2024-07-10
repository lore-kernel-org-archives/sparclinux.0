Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6218FA0D;
	Wed, 10 Jul 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604526; cv=none; b=ekxfPof/3g/EwrMXx9eBCLESPttCYNLQWimsIcsmUH9Y1v9lIKK7Vn+LUbfcXqyGRA8iuUDMww2BBgo/3lGh3+glBJJeEaiuogip/D7RFLrHZJ7NfSHF1r7Y4UP4s0YXZt7s4opl5UMyFbRolPr+NEmnl7jnoSdNIGMWN6iv+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604526; c=relaxed/simple;
	bh=oT4qnGTBSL6osUq5+bgm51YJDsTOy/zQaUmSMCwUkfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dw8wDIgM0YXegcBHvYPg0Wnw4jhZvssfMG0zcrWlzvSWbV4OI25JXJnA3VF4CPxT7iLOB0weBBawAp1tyzfZ0tmPCSeNghtB8hiv7IAICgjx9zQ56IJvcnOoFbzHok0FqCzoOCc/RzybwpJxXKNUEnjV5z7kahVjA8PoiHSNCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=oF3IWqlQ; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="oF3IWqlQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WJtDS73k7z1DPky;
	Wed, 10 Jul 2024 11:42:00 +0200 (CEST)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4WJtDS5461z1DPkg;
	Wed, 10 Jul 2024 11:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1720604520;
	bh=DpvbunLCjfokA5NVvqpcuBWAdMmDrLOCoNOzlpxsjqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oF3IWqlQzGxWXgVtXyjgGQQHMZPgd/B56NnkDnD5hOvOwa9xh2wzwT2HQK5JA5Yzh
	 TfX0kOsIMAu6EAwD6m5oQc4+E7tmLuzuITgBCIDHoRa0iMbQHPmnSk5bkBYXqASPVS
	 TS82leyF3fKUmbVv82LoEmU6eCIqaqqnWHelaJLk=
From: Andreas Larsson <andreas@gaisler.com>
To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sparc64: Fix prototype warnings for floppy_64.h
Date: Wed, 10 Jul 2024 11:41:52 +0200
Message-Id: <20240710094155.458731-2-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710094155.458731-1-andreas@gaisler.com>
References: <20240710094155.458731-1-andreas@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following warnings:

arch/sparc/include/asm/floppy_64.h:200:13: warning: no previous prototype for ‘sparc_floppy_irq’
arch/sparc/include/asm/floppy_64.h:437:6: warning: no previous prototype for ‘sun_pci_fd_dma_callback’

Both sparc_floppy_irq and sun_pci_fd_dma_callback are only used within
arch/sparc/include/asm/floppy_64.h that is included only by
drivers/block/floppy.c, so declare them static.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/floppy_64.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 83decacd0a2d5..b0f633ce35188 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -197,7 +197,7 @@ static void sun_fd_enable_dma(void)
 	pdma_areasize = pdma_size;
 }
 
-irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie)
+static irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie)
 {
 	if (likely(doing_pdma)) {
 		void __iomem *stat = (void __iomem *) fdc_status;
@@ -434,7 +434,8 @@ static int sun_pci_fd_eject(int drive)
 	return -EINVAL;
 }
 
-void sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event, void *cookie)
+static void sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event,
+				    void *cookie)
 {
 	floppy_interrupt(0, NULL);
 }
-- 
2.34.1

