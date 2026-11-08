Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177364;
	b=uCAEdle8ber1os3G0Uw0yTfzOjWNR+JHs8+vSox29YAXxQ3YshyYaNrMSJO0kQEW4gSd
	 tBBj7QZcIFMul8nzUo4zoWXQYXHYoWSpE+MpboY385tpvDyXH0XxI0Nd1kTJMtzFwqJiX
	 Sw3Pz5FAoABgcYu6Mv/K0NhcgfpiaL6blq/xI/re0SksapxVnGF+bfe7f2E933UGLQltc
	 oMYdXqrJBjdgBLC0CaV72cA0gRQ+Q4MGwKEquLLitTyxevcJqggti9YUT0Ylh3DKDUKGK
	 Yi+K6zyznolCytPUHlBjDEHzBF7ixfihuXK5+XO6XAx+IxEDennUyuyb+jjqfuZWjIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yjigVlqZ7YlJzjIRljgnWOG1b/RgP2qYk03IHWd+kyQ=;
	b=ny5ZgmsGvlkD0np6MJgHNQOJJbCr3cW7ODtYfFCMQ7Zt66GPVA9tV8j5keGDK68YuF7O
	 SECZta6MfN0I5oz2EkdYS5y5bbBrvJ+Jb1FZTL86/ZrWroaPdYvY/k0P8ZtTXkw1P9CLl
	 yhOr5dvcimhqt9G5PMnA2zmQcikev0asht/1fO5t9gpNOfuzWJw0SDa0xo3foar+0XmYE
	 +/LtUBnTXOcONA3FVtLoShJDxwlx6vltRvXB8M4RcH8WVwHZmwmGE/sx/qWZl9rjkKXmx
	 h6Q2To7J4rjT0Qqs/ddVwFhrLrtUL2aCfFtZhDrXUtad1ygrcfJf8i69nVo1WlSRkpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPdEvlXN;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C1606D82D
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A4C1606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPdEvlXN
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so413622a12.1
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177363; x=1794782163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjigVlqZ7YlJzjIRljgnWOG1b/RgP2qYk03IHWd+kyQ=;
        b=qPdEvlXN/8NYW+AIFOUBAaAsmqasuqAXI+HQki9oDLjkSxLb6+KPwYlg0VepThaJ4u
         jhs0LZWMGL2Hti/VATF3AZ49ta8ezuKTNpoKCxa6Rm22lXmIENvG5E6MIfWkYMbA9J7i
         7M3BOY/40qFCSj+vzVzMjgYEWgWXhd7YDXjyfrGPZ4nKMkLAMqbKr9tADXgNZurxlGQ9
         21eI+WhVw1SaZrxx1xiGxKCVDzj74mh0ZAo2Dw63UKwoWmTQN5MgMTPqzV2lnmfdOiK3
         LBgvVAOq1j8lH1z7UO4wy4D7mcL77tqTof8+IQAdAfyPYuYQiwXG2BFuCqTi4GIM1uAj
         t0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177363; x=1794782163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjigVlqZ7YlJzjIRljgnWOG1b/RgP2qYk03IHWd+kyQ=;
        b=EqrNzMC4pir0cfTyPHh3PYNQE57TPX0UjOkPyyNZNHCSHnis3uJF9WFt0LtXjmY1a+
         MjO+g96oFN2LjsQ6i4e+kmVSOQhh+uPJ3TcwZlnVxloR3PFReiHw5qPumoURwlV3K/cl
         9BTeSoQ6ST0YA6NdLscSX7ZsCmkzu924Pnhq3P8yh99U9w4wy9q7PAg4Dxb9OIo4RGM3
         D92rEGyjbeOtiUHiv+dS7fvnY5T46pwVuagh/ddu87ikthy2v6QXBXU9Og1GmNQGUpjR
         OYi8SHF73SVdpNQddHspN7VlCv9Hr6HO3L7lvZ4rw8vqEmySuVXoL6SrqCg+uxGkRor3
         Ej1g==
X-Gm-Message-State: APuU4Z/DK1qo/bJDcwFvuZ34F8GTvjsOi6rQ6QpfYflcSJq/65nRA9F+
	S6MnCd1L+n2C4nzYix57il0tFTMQnlnQNGjsetilegF/TnkCqYA0Toe0PzxS2Ifz
X-Gm-Gg: AYBFou3j+/Ax6KssfQG01wgP0A8FGMgG2eyBi56XFBYlVYXg5KNggNkEVGoEEzHEzzV
	HP3b9xN+uN5wP6Z6nXJ6ZgxSzKucg4jJVZI5GPo5eE+aLvMqHNTz5y5/b4fc0BBjrNFf6sVSUDh
	BUFFF6Q7LggUZF79J0O5oyUs7Ky00WZ+ob8thZD83aLz0Z4S2wTNRcNXIB27vWh88TC6TgMtf7c
	d9IOaFXfYMG8ZULz+SJ/4NX3ZhVeyGLrBBKmLKKH6fmTjlwy2Fuw6ejf2kRFY/RY6Anqz3q/bhS
	Y2XZPwh7Yu2ispJbdFguVgUyx309Oh+W4IVI2yF3jEcfPzvQtEPT1RCNDiuv64wwVJFbP/hLs8x
	GPwMPWAtLANooSS099A2SvPM7vMAYbRSVrXwxVgIYUWddBV3UffJ8rpfO4lD5PE/FonyMve8pW+
	C/bsRyLLrmVLYaBS/cZiofDGLCVV9gjZ5kOp7EbvW+B+Fmd9L1lWp5Hp+2hjwx+QknAxg54pR5/
	kddLejvavqcNIzL3W5zUBJeRpSKrQIyvhJDtEyggSbkGrZGNQEt5KG5ndzqG4rU53q0s/l2JhC2
	LaIYQELMEAN1NzdKFwiMCMZo5v9QC8OEE6+6nhxuqQDrfWiKuceN3R9AlCxrlRkUed4v6lE=
X-Received: by 2002:a05:6402:5288:b0:6b7:1d67:eeec with SMTP id 4fb4d7f45d1cf-6b7224522bamr1427849a12.14.1794177362272;
        Sun, 08 Nov 2026 14:36:02 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:01 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 5/9] sparc32: preset modified and referenced bits in kmap PTEs
Date: Sun,  8 Nov 2026 23:34:15 +0100
Message-ID: <20261108223516.1125534-6-linmag7@gmail.com>
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

Preset SRMMU_DIRTY and SRMMU_REF in kernel kmap PTEs, matching
PAGE_KERNEL. These mappings do not use hardware M/R transitions for user
dirty/accessed accounting. The protection applies to persistent PKMAP
entries as well as transient local mappings.

ROSS SPARC RISC User's Guide, section 4.2.1.1, describes hardware table
walks and PTE updates when a write or translating operation encounters an
unset M/R bit. Presetting the bits avoids those updates for kernel
accesses. A whole-context cache flush does not perform that translating
access.

This also provides the PTE convention needed by subsequent alias
reconciliation, but does not by itself provide that protocol.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/highmem.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index 14b03f348823..d451232625d3 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -30,7 +30,12 @@ void sparc32_kmap_local_cache_flush(unsigned long vaddr);
 void sparc32_kmap_local_tlb_flush(unsigned long vaddr);
 void sparc32_kmap_local_post_map(unsigned long vaddr, pte_t pteval);
 
-#define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
+/*
+ * Kernel kmap mappings do not need hardware dirty/accessed tracking.
+ * Match PAGE_KERNEL and avoid M/R updates during translated accesses.
+ */
+#define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE | \
+			   SRMMU_DIRTY | SRMMU_REF)
 extern pte_t *pkmap_page_table;
 
 /*
-- 
2.43.0

