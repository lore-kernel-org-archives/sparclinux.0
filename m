Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177367;
	b=BHKKDAPXUakHQ7sheV60ZRbXoFIrkvREcb7Wz5TWdj8gLRErqodTCDoPEFXbm/pzNTox
	 Om62g7ewunN6WgRgMGiFF/oySBjogU14kFFcPpb4b5Z3JB6iyjPT2ddikKjRWzzNBC6Nu
	 eAAnVNfC/XNMwoIA+jqWuy149if64HXpV/DE37zFUjl4x8WSLmOVa3KL0ItbcTUov8RxY
	 6JvbG5txqNelDxOUvieNpwjpvuSLlHIKpWRfeGMWWScsM7WwU7wX20T17cdmvwB5cOicV
	 gWv6PUpPmFOPyfWkjAYkHsaAsOTFkx1cviZzv+e6a7JiSW52xvtAli5sNy0UwzObSgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+TWo//CssvQ+bc/dXyRT+U4/ngBsjpxGiMk/GjYd1ZY=;
	b=44Gg55tolTsgKT7I1aZcOBkUKkXljLhPYyTFPmaZqExtt98V1ET8u7Ni1Hs5O4fkhe5h
	 3N1YJgnSD9JkS8ZQpMYcSPzP8xR1ky3hWdY/A4Rt5hm8vVPPe2W1AqhRf18avVlPHITni
	 MvQSQboLshXScYIw97fjGDh3f65CyCIeWcCjMFBWiYjKYfZJaZo+UzaveZqC/E5rNVRR2
	 3FPk4zNHCiS6LuDmNBhf9GOoVFr7Gzxu2p9rgBETxk3Od+Lbwy0YUv3hMAebGtCApxfYc
	 N8acuczbQbOH6YnHiFtTiVdcRoPqSdjs1J7oo3y5gDlYE9mKkP15f0TJt7WfDmxL5aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iBo/fKGM";
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A0606EE84
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8A0606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iBo/fKGM
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso355841a12.2
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177365; x=1794782165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TWo//CssvQ+bc/dXyRT+U4/ngBsjpxGiMk/GjYd1ZY=;
        b=iBo/fKGMS3ppUZ99HujRWX8cvvgsVD6yvyy+8UhlVRxMNGH/33aJGFgFPr4WXAaY4S
         Y6o2NVXXa8dRqpi9RiI8t/sj/0x5uXb3V7crE27GYU4LW3HxsZepXB3Lm9ou4hkiHAwR
         /xI8Sq1yalmKn/Qfg2HOLVdakOzKRUXnbtoiN2ILAFE7Sed5CtUYUEgmkvhc2ewo7Mgq
         MxwdNv2vw87q1hzcz1JIk67Xo/B3O2m/988420fBhhuotmz4nlYuY8VdQ96raI9f3fMq
         se6ITY0Li8M/Ek/WnYiA8dasnz8z5S8jsCjF19RZIyEuZHdhxk0VZgV88IITevl4rSpV
         whAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177365; x=1794782165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TWo//CssvQ+bc/dXyRT+U4/ngBsjpxGiMk/GjYd1ZY=;
        b=L6dOIPohSvjW5tBBXHFjhSJDz6BDW6Un+agMDdsBHZCfjlRi3I8VUbo+w1XzV5x3PW
         HliXhh5e1zxLgd6UEniPJkzhylZeatqFB48kZUANcE1dJ5iOgi2eiGGxwzV+D2H4wP9r
         vozX9CQqvtiwF4OuOAcnqEV6esQWUdXj91KilHXORuWSoMfVX3dAInkx7tv1W8K3w2wK
         H7W9Uhdg4d1dBGQ7y8ZG0zIHI3l6NsUgrdrZOGZLFJSVW6C6WuZZUOyn/5O+ywqUYi75
         88J4xlie9LyPcSha58vqCLklhN5zxHVXZqWJ5zEe4CodUhu/0HO8wOm/yChpE2FUGUq4
         yx6A==
X-Gm-Message-State: APuU4Z8y6fwhFdyQOZiGfxCAJ8YSzkA7fL1G0zoCuXr005+VXQtUB9Od
	Tf1+2oS5FASzFrx/YHtswommoCcVVkiGUKj5/5+y1cBT9LPYSR49Dc0ywq5a3VBm
X-Gm-Gg: AYBFou1dhZVZ4D8P4xC6YO8wMwE3GUrXqkrQVCJVbi5syE9pmfMwmBzNDHrBvCw2xuH
	PTdaZCC8QNa/ArvFiB+qCfzOm9oB8+zsxKGfyLHHImrgZdnjCeyvOFt8aVHKLt4sKmLccEw+kLr
	WdjpnsojkE+UfvOTdSDy1GoGhcr5chwF56X3LRZCOX/nLqDLEgGWEKiQ3tKUGqRX5Dt33lVwynA
	cNnFgecm09DGhrYMM+Ldv27DtEz/Y/mjAIgQ6Sp/gQVYlwonO+SJTLgI97DusROJ7IELfB4Y0gT
	t0tAZxouZaxIexEBBPIVElAhXbMMJbl7uvFNws5s0cY5ZC+VS4MfDlLGum0BXFpkLoj833uUS8a
	xstMmBUCELAuY2gQx6COUE/hVqB9TlpBafjQIip/BcJz5DE0ZKCU0tOxtBqvbmT4Ej1XR+sRp6X
	OewXAzVfU9HC11GlMtiK78+e8/oJgoc8lsYCMD3TQML/Cq4R+K1jTO7OFelv5KAws0Fw2NshRGv
	QifB2gvAFZ1+uhoTdspMrGnIf5GEDD95nCqPbt2tIEAb8bWhYbrTxnQJ8ZhkUzdU4i8EU/VGue/
	rDPZVdRyuYyg37oLjOLIrD/7DDUKHmXIRYWqd1yxN0aZndURT+p272HISnvKwONml2hCh8o=
X-Received: by 2002:a05:6402:c894:10b0:6b6:f5b0:889a with SMTP id 4fb4d7f45d1cf-6b7224abff5mr1066267a12.35.1794177365106;
        Sun, 08 Nov 2026 14:36:05 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:04 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 7/9] sparc32: implement flush_anon_page
Date: Sun,  8 Nov 2026 23:34:17 +0100
Message-ID: <20261108223516.1125534-8-linmag7@gmail.com>
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

Generic GUP calls flush_anon_page() after pinning a page it is about to
reach through a kernel mapping. sparc32 never implemented it, so the user
alias can still hold dirty lines the kernel mapping cannot see.

The SMP wrapper checks whether the mm mask contains another CPU and then
uses the existing cross-call mechanism; it does not target exactly that
mask. HyperSPARC's unconditional all-CPU coverage is a separate fix.

The anonymous-page hook was introduced with a generic no-op fallback, and
SPARC32 has used that fallback since then. Supply the missing architecture
operation for the GUP coherency contract.

Fixes: 03beb07664d7 ("[PATCH] Add API for flushing Anon pages")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/cacheflush_32.h |  6 ++++++
 arch/sparc/mm/init_32.c                | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 9fee0ccfccb8..a65ee310e860 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -35,6 +35,12 @@
 #define flush_page_for_dma(addr) \
 	sparc32_cachetlb_ops->page_for_dma(addr)
 
+struct vm_area_struct;
+
+#define ARCH_HAS_FLUSH_ANON_PAGE
+void flush_anon_page(struct vm_area_struct *vma, struct page *page,
+		     unsigned long vaddr);
+
 void sparc_flush_page_to_ram(struct page *page);
 void sparc_flush_folio_to_ram(struct folio *folio);
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 9cf0065fc2d4..d0ce9d23561e 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -95,6 +95,17 @@ void __init arch_mm_preinit(void)
 	}
 }
 
+/*
+ * Called after generic code pins an anon page it will reach through a kernel
+ * mapping; the user alias may hold dirty lines that mapping cannot see.
+ */
+void flush_anon_page(struct vm_area_struct *vma, struct page *page,
+		     unsigned long vaddr)
+{
+	if (PageAnon(page))
+		flush_cache_page(vma, vaddr, page_to_pfn(page));
+}
+
 void sparc_flush_page_to_ram(struct page *page)
 {
 	unsigned long vaddr = (unsigned long)page_address(page);
-- 
2.43.0

