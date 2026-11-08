Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177360;
	b=vsM4A1Y7KPOaY8ocDirlvAP7RXsvUG+j3lGS/DP8N3YstPnZ+uoX+gbEppls++EB8Obx
	 GnWsP1G4y9uuI3RaPo33hr53lzvK/lpbhd1WqVWM7GFyuRsP2aaATpxglBVGCnpyi1zDQ
	 ppVyQOxDf+isE89p0FfHRS6vpPMaFYZAA4z2z3mNRhJbgBMI8DS//lGHGitkg8eCmzxb/
	 YcW2F5E2+6qlrSZzihWFiIP7DDD1PhY2KXIOhvG2/tRAR/zFVM7fVqb6bm4mnuHHML0Pv
	 K/BvOhdzqhycR3W0cuW/sK4iokqlJy3QOr5VVl3AFEjnuWhU9pZOhx7KWTNGRd87D4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lg34nvpGk5bB3x2FmOllL1iUBWZczrJNM8FaVog84/s=;
	b=XnQmIFOJA48mXim/tiGrCneerPhWt+ItWfcDWWLAssQgpG+ncxxkmO+VR4CTyZb9r6iu
	 5l+9HD6g4X0XYvdq0NbSVJOGkdR6C2Pt0pCyyPbpKb2fVJrgOIaAl15L2SmIXPWaXKwEH
	 Y45uFX4HD5FSAtgT4UzSarXcpGICDE7TL88DNFU8DxxlkH8JI+qUlQRwnfPY8FX4wUYSR
	 o4hiKVswipQ6jyHXHIkFsB1cBPqy67+sNgiQl+rgYHcV7EtercQU2E8bu5FjUvQb/Aga7
	 3a7gy8fEAYcHB5pq5TZ/pqOTNES4/rs82Y5/X7n+KqTr+3ivs/HvxmbVvxvnhspxTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1K7rhsu;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B6606A338
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881B6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1K7rhsu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso279683a12.1
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177359; x=1794782159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lg34nvpGk5bB3x2FmOllL1iUBWZczrJNM8FaVog84/s=;
        b=W1K7rhsuQi9t32f+bQcHhZGOQsL0RGDjqQOM+hwJgGqoozREYqfc0E6omTcmSvZAGO
         hpg+3t+YpKMGd3S03fzWkLqC6NgEsCbCY2aFasjJFINDTvfzckxUQ3ZJRCK4tyDkoT1T
         EZzcAmTN9jTnKQWoPpKzXPV2hxG70Yb4bRcGu9xgj6aQpKzWlxEBjH3+gSONSAND1jKQ
         q4R+tVSf7d0Q4EtKepDOVrAoOVfVvl/Uus+MxXKZr0bdXQ6+vAhzdC81d04XnoXXIwWR
         388tIorh0ozBQ9TFuIf/wddtWkenYopRM62PzNxC+92E37gDQxavAR0sGGxm4s4L7l6r
         +TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177359; x=1794782159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lg34nvpGk5bB3x2FmOllL1iUBWZczrJNM8FaVog84/s=;
        b=p+O5dXQH9z4tEUa6iDL0/1zi29nR7ZxrFFOdi2AYR101euohdi5H7mfOaho+WWqfle
         FyxNKUfi8ld4mruGHFebsx9ZG7HmGj6NVhaSZEcE+1MyL6Dr5HIYwmogD5ET7/oHdKD/
         pN49er6VuR8EYG7RSKzR2RJS98nDAP9YE1PqlgnGBbtCBmXBcx7XzKzAthhhUMnXRUAa
         u9cA4rcUnesvS41WopEbG2n79Es5DWZ7d5JJ3muXqKvwzERiHlxJwpvS3V5MkprpuRow
         zUAu93p+lwpVS4wbX52maQUvCpWWkaa2f4Ibb8H5hCoMBay0F8IzFZaimfbZY3VNKqvR
         LxMw==
X-Gm-Message-State: APuU4Z/lU1Ur3QIc9WQdEMXkGxSvpePL2dSusHCEBbx2yzOCt1RJrQW7
	QjgAKUsr+VLmuDrnm0VrBM/RrqeW/rc9I4O8tPNNGiJDFnpNhlutIvyW
X-Gm-Gg: AYBFou2ADibkpK45wByjscMGQP510TnLFbszspGSvZ7M9jt0rFqpY9n7AaNWkpxUSR5
	Irnf1gTVcdUtkL29RYyp7sfuL+QebarCGcMMLXZzQz/ZN9yHMyq1SLNHIpAnxG3XXukgN4sU9ox
	tt3VMKiUQFJHJsWbL8cypdJ2e4rjBK9+eflNQ7zCE3Zi9kzENHuGbHaNYJSPNMgWwqanxATTE/2
	RDWx1CLS7kUI7Q8xiY1aLpHBVd2QBe0oRGCW8G2maxBggxDxV8e4T+hTYSk74DGUlo1gELIv5LJ
	dESAXpyjLRNNs8byjxCAtUGpctZ1OxTmSaU3s/OZVCohq6wQeocKVeavqTrcsGCOe6OJxqg8TNn
	RCUQldW3M5V6cpMK7ESE6jyg1mYG5gzm9ppHn/sfFy154wzBvKwngjS1ndv65sAuK/ji7Ak+IXT
	aYxwVYSU5dRFdM4ooJdjgZCD3wWqlVf+CiglPxvF51+3kFXtIh1W8UVxkJ2M+R8PXalM8v76P9z
	iOwetWNhfPkOePwbJ8yQQ5ZgdI4LDwXYONmu034cLuHQwqJ6B5m38bYcG4Rg1N6o6nhpY/bdoK4
	29RYy/su+wUt3keBdEiubvlCYEBoZVrS0VeZlYOkvTgSnlBynxcrxcW/zJmD4On6zgWFo94=
X-Received: by 2002:a05:6402:4501:b0:6b1:a86c:7b with SMTP id 4fb4d7f45d1cf-6b72247ff69mr1628940a12.36.1794177358857;
        Sun, 08 Nov 2026 14:35:58 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:35:58 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/9] sparc32: flush the source user alias in copy_user_highpage()
Date: Sun,  8 Nov 2026 23:34:12 +0100
Message-ID: <20261108223516.1125534-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
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

copy_user_highpage() also handles lowmem pages. A source user alias can be
dirtied after the fork cache flush but before write protection and its TLB
shootdown complete on another CPU. This explains why flushing at fork
alone is insufficient; the historical tests below did not isolate that
particular interleaving.

The hyperSPARC external cache is virtually indexed, so index bits lie
above the page offset and one physical page can occupy 64, 128 or 256
distinct cache locations depending on cache size. Two mappings of a page
do not see each other's dirty lines.

copy_user_highpage() reads the source through a kmap_local alias, so lines
dirtied through the user mapping sit in a different set and the copy reads
stale memory. copy_user_page() then flushes page_address(page), NULL for a
highmem page, with no NULL check.

Flush the source page's user alias with flush_cache_page() before reading
it, and flush the destination through the address actually written.

Only observable on HyperSPARC: SuperSPARC's caches are physically indexed
and MBus snooped, so viking_flush_cache_all() is a window flush and a
return.

Fork/COW torture on a two-cpu SPARCstation 20: 7 of 20 runs lost writes
before, 0 of 20 after.

The source-alias omission predates Git history; the later folio conversion
also removed sparc_flush_page_to_ram()'s NULL guard. This change uses the
mapped destination address and covers both cases.

Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/page_32.h |  6 ++++++
 arch/sparc/mm/init_32.c          | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 7429291fb118..c968ec33ee98 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -28,6 +28,12 @@
 		(void)(vaddr);			\
 	} while (0)
 
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
+struct page;
+struct vm_area_struct;
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma);
+
 /* passing structs on the Sparc slow us down tremendously... */
 
 /* #define STRICT_MM_TYPECHECKS */
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 2f693b70dbd8..7b53ee9f061f 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -103,6 +103,29 @@ void sparc_flush_page_to_ram(struct page *page)
 }
 EXPORT_SYMBOL(sparc_flush_page_to_ram);
 
+/*
+ * The kernel reads the source page through a kmap alias, which on a
+ * virtually indexed cache lands in a different set than the user mapping
+ * userspace has been dirtying.  Flush that alias first, and flush the
+ * destination through the address actually written rather than
+ * page_address(), which is NULL for a highmem page.
+ */
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	char *vfrom, *vto;
+
+	if (vma)
+		flush_cache_page(vma, vaddr, page_to_pfn(from));
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	copy_page(vto, vfrom);
+	__flush_page_to_ram((unsigned long)vto);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
+}
+
 void sparc_flush_folio_to_ram(struct folio *folio)
 {
 	unsigned long vaddr = (unsigned long)folio_address(folio);
-- 
2.43.0

