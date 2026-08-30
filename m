Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659C3B3BF2
	for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091685; cv=none; b=tzMVX2AtVlu2+5Y+fXUYAoFKHXUEf/OfnWSLdmKaL4Wobt5bV4CWY2dzvhJzkhkR/wlFqbh0/+A2Sbwn8h1vGox8UzQHgdLnYL8aXmo13MPqekM3tj9w1oU0sv35RWxVGCOxv8dSirJJ+FloFwuayH7rmp6xyYhgSJWp03mILBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091685; c=relaxed/simple;
	bh=VmbFlELFJ3Rn+I0JOfMdlDLEE3OEnrmuWAkyZTBARKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6aK/oEykbn4GLpCuWrwBe1XPSpFhNEDS98pURYcTuN8bzoWZCkYwkvSm3sbGK0ePjGjZ6sJIdjwoudtdB2/MOOgHkKzP6cYcZpnAjQrHJ7zdXRR1eJl1FjCB1kG1d+ZtNFLhWjLslnwNbQVBMONtUDGgyV2vMA78Zdcia47YXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUKynZOk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUKynZOk"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2569aa5116so250660666b.0
        for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788091681; x=1788696481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJ7HB4Zmwe3amRULeH6fSoLAudldxAC6NdOXYXWuTOQ=;
        b=kUKynZOkJTzl3jCgeGVf25oKJ285QGb/XO9krKc6Zp8qZH1eqybC8+4xiZpfMHhfgq
         YDAYhw8FLUG3dDLnCjO4kRLBYkDg+erVwByOFmDzgzUEiNHnnOVkGLspNSInxQrthrvk
         5+0gM/7iPyFos1nQboGirqRmQi+V0Hs8YFg8Vy9Wnym4WNeUa+/Ocxr0VQ0FBRU95Z8U
         7PP1I8euDpfvFEkcsOfsZKKuzeiHYLxtiCCXsW46klFN2G9sjkUg0rKvTYsgi6kzVTbs
         0IHpQM0noLdqeTmUVK2Kuwr7qUWsvp7fNqQjDZnUTzh5f+KKpCzeyODODVE3PPGTT/1v
         9Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788091681; x=1788696481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJ7HB4Zmwe3amRULeH6fSoLAudldxAC6NdOXYXWuTOQ=;
        b=DNjgoU/IgpJnRgo04ONH2XmTKX75tRjmwXMJ6xYRb7vt9TwuHkr3hYXVY/YMlvzAip
         8OOJPUDdJxH1+qMiZdnxz10F5BCcNEdHndaRX5++VBL/RMPnVTO4qCu5Umjqs2ISw+kn
         HawJLqtaL+/yuGorvrwcBkIPbRTtomAJtR82sl2PWzqqCE3Xb1ZNdJ3JaRQrwbYNMyqh
         sOGguteXg61X4ezpf/9QYPmgYuEkXqMMweLuNWu7K6zcByD19xsg6g1gP9JYPnT1+TFJ
         AqkK7lBKEKs7r9K2NFITmUdO7nL6OdEHJE79SYZG8NpHlVPHNUety0cIvQ2ks0RQcEU7
         58tQ==
X-Gm-Message-State: AFuF++moy7MEwa5nfiDBIiPKugqA0GGnAxTYm2aizzmYHDd6xCzfkcVs
	EJ16pj74sifgUozoak0N7Cb9VFEl+l5D4s/Y8gQUL8sCxV4M2e/aasCtdIHNKJrS
X-Gm-Gg: AR+sD121A8OfBs6WsLuNDNopFZL6ZxYdPE1yTpPVa8NyyAjUYhvHZShh7dmBbwu2jNT
	EDOsl4ikNvGuQrSgOp18Wdr/4NdOa8Q0zFnJmFvBGWOvTKyR5S/D+nzjGkquzS9by08I0flD+ne
	dJprOp9riD6mr1lbZlF4TRw+pi/1XUYU7jeoz92y605euNqtain/nzLAscwOxUN86vU8ymoW1cv
	KgVXs1+XwEzjRuSYnpMxSzoUh2qJHZaJWtzioXAG5KVnygngk6VWTZAP/OHmFeTlGVOQCpG2WCD
	LKE/Z1iIhXTa3BA4YtLItnoypXFG687cx9GwJgENFhb6qu8lPrJl3dUcLkuCDpVzJXzk5Q8pFGW
	MSKFIIayRumj0k9WvqH+xWVXARkmNfF8Dm33aJNMgfQbKKjh2RTVhm3apxg20dRryyEVCD0SLsA
	DaGLHb5ofTx73Kde5p713SlRKVPYS7J4pasOgdvvlkz26XZ13TAoNEAGU+uMgxdByhrk+JhjiEf
	rAMeoOCRO/anJ2EWpW0W5UsTAS2UQg=
X-Received: by 2002:a17:906:99d4:b0:c25:3e36:acc8 with SMTP id a640c23a62f3a-c25966d7ff6mr110233066b.4.1788091680875;
        Sun, 30 Aug 2026 05:08:00 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee09eb6sm304287966b.10.2026.08.30.05.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 05:08:00 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2 3/6] sparc32: populate memblock from the PROM memory map
Date: Sun, 30 Aug 2026 14:06:42 +0200
Message-ID: <20260830120742.20950-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830120742.20950-1-linmag7@gmail.com>
References: <20260830120742.20950-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add each available PROM memory range to memblock as it is discovered.
Keep populating sp_banks temporarily so the remaining users continue to
work while they are converted in the following patches.

Since the complete PROM map is now present before bootmem_init(), enforce
the mem= limit after the legacy bank processing. Adding a smaller
overlapping range would otherwise leave memory beyond the requested limit
in memblock during this intermediate commit.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_32.c  | 3 +++
 arch/sparc/prom/memory.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e0e66f91ceeb..75050dfbc2ea 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -165,6 +165,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		memblock_add(sp_banks[i].base_addr, sp_banks[i].num_bytes);
 	}
 
+	if (cmdline_memory_size)
+		memblock_enforce_memory_limit(cmdline_memory_size);
+
 	/* Start with page aligned address of last symbol in kernel
 	 * image.
 	 */
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 269d6ab5ef5e..59962bc0bc82 100644
--- a/arch/sparc/prom/memory.c
+++ b/arch/sparc/prom/memory.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/sort.h>
 #include <linux/init.h>
 
@@ -23,6 +24,7 @@ static int __init prom_meminit_v0(void)
 	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more) {
 		sp_banks[index].base_addr = (unsigned long) p->start_adr;
 		sp_banks[index].num_bytes = p->num_bytes;
+		memblock_add(p->start_adr, p->num_bytes & PAGE_MASK);
 		index++;
 	}
 
@@ -42,6 +44,7 @@ static int __init prom_meminit_v2(void)
 	for (i = 0; i < num_ents; i++) {
 		sp_banks[i].base_addr = reg[i].phys_addr;
 		sp_banks[i].num_bytes = reg[i].reg_size;
+		memblock_add(reg[i].phys_addr, reg[i].reg_size & PAGE_MASK);
 	}
 
 	return num_ents;
-- 
2.43.0

