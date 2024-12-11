Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD71FFC50
	for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959711; cv=none; b=gFHtpjHUPvirxYBp2ifmSQsqbtHgUlU+HifPvsKnTcGqSQt8Y+1acmDeelVmUYhTt2Tj1PBoVWAjwfZMqAvzgjz0ktnLb68QxyU78Xq69JyOatGffwOha4QOfer6qVRfzbNDHhI8NnDtkSLwsqXS3aH0yPtPSGsFLbzfbW66sZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959711; c=relaxed/simple;
	bh=e6BnmSCV2QrrtoqE+kEeLZmDcpCmkfYXz43FlPij0LM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YevjpljUSavbTh96rj9Ciyw7FA1Tq4mZ3RJI7eVseEgr7CTYfrkvYbI7FOkmG9rI1gTOjNHHKAn9KwZni/DH3PFsn5k2YVazQEiu08RK6m/vdyJDngiRLFougA37iUm/Dvj+KvXJRdqJw0/SXhcKOGmjF9XIQ64pA/P+xyMeZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXajPhuQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXajPhuQ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-728e4e30163so19540b3a.1
        for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 15:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959706; x=1734564506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzI/WChqoEagnx9fXIUsiKk2yVJ1VLNiv4KjzJVNd2U=;
        b=OXajPhuQrIh+qiUrSPxrwqRABByE6r0uBtIra/NXAhrZWdRhgIXKn6oBQMg01UPGCE
         36CnE3+f1S7sGsp2c9lfX3FK2LFG6yaMe1UwcVQtHOyfH4pB4efEP1nDAJPbeoEOUfPK
         4t6z3rdpI4j7tYB3W0m1DJz3PCB+OO9lBVuPOvBd22D1rxzu3droH932qVtl9kbXTCPY
         SVhWEV4FWmckLmjCH6qRgFKfR+JUindoxy8maZbdre66KeN4iV2DBwDKHAfaBXq8RmDd
         LNPDeFLjao067G8USlrya6O0tfRLNcvx7Qu9KQOROGMgtjeB/l54BQzmqFdKImC3an7F
         Kt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959706; x=1734564506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzI/WChqoEagnx9fXIUsiKk2yVJ1VLNiv4KjzJVNd2U=;
        b=GRhrC78/jfRNKecQrmb3U8nKMWHFXHdAXBNORDGYQBnqypn9lot3/t3+ccqbv/SO+e
         eUs19P4jgnuK15cQEnLzwr8C3OsMvn53UB7lDxDPzD787GL2Ko7lI8SwAcoh/5yCNPf3
         O8pM7rt0eRklUcmSD8Gmz9WmpzfYi1Sh/Iz0Ni4TspGxVvBheW+SF9Ifjj/CieNOjwCv
         s+IifYHHSaXIhs6lpjv8uXAGMroK1UgSkDmsXCWEndTyDCd5aHyEuQS6KYR/Ty8TLhNt
         /MbRrGWyyodJuQKob6GYrRINHrvQTZq/Txm+ZCDoVXPGUaiVPWv9kteT1RIgn+KO2aor
         InFg==
X-Forwarded-Encrypted: i=1; AJvYcCXTOer4ZckkVJ9C3cRGGFEmt2JV7zdL9qpagrV3HJ5yPVdLN+gqBIbivF05TtuySH5FCLWO0CpOeqCL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx72fiSLfVRaLqbawvxMyv+5Gy7Fm9piMYGOVae6i1kLyGOolE
	OVaWhsxC+7qYNxuwYZs9r2gfLKCBOnD/RCMrur1Gp6HNoVnKemtWKoxfiROD6H5kijfSjmsS/M0
	U0pIxJjLRU1fXeiTDKuxv5Q==
X-Google-Smtp-Source: AGHT+IGnJnRJXQZ5IIc8W3PGTGxBtDfE/sIYeRjCrJpkHMTtOgcOp40OoEyKbTRESGUAjOdqxtzUpt2F+EP39npdAw==
X-Received: from pfbcw14.prod.google.com ([2002:a05:6a00:450e:b0:728:e4d7:e3d3])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a10d:b0:1e1:aef4:9cdd with SMTP id adf61e73a8af0-1e1cea82ca5mr1784516637.1.1733959706098;
 Wed, 11 Dec 2024 15:28:26 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:53 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-16-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 15/16] mm: powerpc: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce powerpc arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/powerpc/include/asm/book3s/64/slice.h |  1 +
 arch/powerpc/mm/book3s64/slice.c           | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index 5fbe18544cbd..89f629080e90 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -10,6 +10,7 @@
 #endif
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 #endif
 
 #define SLICE_LOW_SHIFT		28
diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index bc9a39821d1c..b4067c57c778 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -647,6 +647,37 @@ static int file_to_psize(struct file *file)
 }
 #endif
 
+static unsigned long slice_mmap_hint(unsigned long addr, unsigned long len,
+				     unsigned long flags, unsigned int psize)
+{
+	unsigned long hint_addr = slice_get_unmapped_area(addr, len, flags, psize, 0);
+
+	if (IS_ERR_VALUE(hint_addr) || hint_addr == PAGE_ALIGN(addr))
+		return hint_addr;
+
+	return 0;
+}
+
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	unsigned int psize;
+
+	if (!addr)
+		return 0;
+
+	if (radix_enabled())
+		return generic_mmap_hint(filp, addr, len, pgoff, flags);
+
+	if (filp && is_file_hugepages(filp))
+		psize = file_to_psize(filp);
+	else
+		psize = mm_ctx_user_psize(&current->mm->context);
+
+	return slice_mmap_hint(addr, len, flags, psize);
+}
+
 unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long addr,
 				     unsigned long len,
-- 
2.47.0.338.g60cca15819-goog

