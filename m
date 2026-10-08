Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073D3B8409
	for <sparclinux@vger.kernel.org>; Thu,  8 Oct 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487036; cv=none; b=B/5nZ7fGMP2oySY52gcf+HQlimDOZMYkm86hLNzLPDFqpaHDuUsSScWF8mxhcpHWcHMG3og2rS0JJPV3qF8Tt8KeU1kZMVpu44ST3F85XdB2Z1NN5lJEYLD+GCmk/Lm9EgCdME28nl7/iwjwL8d5tFgniw+4qC6YEjeIRKkmaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487036; c=relaxed/simple;
	bh=41LTbWVjpTvo4M1E4NbCgmRFCizGUSRpVOrbjrIjkRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ll969zEugCGkPioQ5iDckC/CbYkmXjPIRatHpbH3KdXzlp5BeO+zjGROpiFDPAlKRxbQ/m36EtPpXRqqt/gwK24mbt84iwxefe7QOjixIlMHhM7NXZypr2n7EQgWqraaCDnxt5zO+emeGvjjIZEvymmaOH2gbLqkNIDKSsCxKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W37UHwyy; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W37UHwyy"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-919abb3335fso13848316d6.0
        for <sparclinux@vger.kernel.org>; Thu, 08 Oct 2026 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487034; x=1792091834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUu+rVVcA0+9TqEMKJogDIMf7RBcjtzwW2+KKNlVxXE=;
        b=W37UHwyyO9QRs5wjYNWroqMNExP8R9dbTpNj2zvJhaVCHnBxwoXQxxqufz1+9VeP3/
         HCnWy0V11RelkewyfIiOfV5HesTK26DNzqk/75tsWJKwKNeZTBMiIpnZw1l7farGtMJy
         PUWwtEk2sGJLsU9ONpgt8Gbt7ljtduVk/csdk5m+mlisFk6qIil6nZ8M8JGSkGJFdMFa
         4cZ++6mt3Qf/RE3z7Bx6/81VmorpHxh2Kkgo/5nB2atIQwONJY5wGdvi+hvtnZ9opiAb
         plSVuVVa6/7nj92eExc/LF/kDItko0sfq9tLHiSTZhfdpOIwnQ9FU58pfYEPbxYqNaal
         p+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487034; x=1792091834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUu+rVVcA0+9TqEMKJogDIMf7RBcjtzwW2+KKNlVxXE=;
        b=Wmo/WF9jB2v3RXYQHTpxvdBLPAhS2yBYXRNFi+eUljOWYIYqJ177+3W3RXr2Nynt04
         MqqaWtmmjQm/gJapsHnKA8jzIszrN/mYRqEpzJCH6DXIMGJGgmpH/I7TlCecNf99SDo9
         x0YMOBtunfc/M7hJtcOHqdYrXKgvm9gcJNKqIck/9zgIVLYiw73JrHRrzBkyFRMJqc1G
         Gf+GJbYxiMXbf8b0WRlD1xZephRPv0t8/iWzn+rrqaiYuBkQFAbpxNGCj8SswuNdKdF8
         MlUetWi/tWM7VL7lWssnt1PMEC2Y4MbKGsqNgHdoeUmzUP4h/PlXOlGJLenLC/tiywq3
         vIlw==
X-Gm-Message-State: AFq9FYLYcCz0K64Y109JraTAzHzqO8q84X2aOMqy1kAUykNXGHz7QYy0
	HNrLxRBZNROJhc2j/0GbUfL1TAjHvIrA7EMcDCsbjMbaqCWZbrPN0TWM/UqXFNls
X-Gm-Gg: AYBFou1aJXXuUmtDXAALKCDxVbCq62iu5icfCMuQtKKyeKc1xyZxz38kKgQi6G/SP80
	7QBD9PvGrNiSFzLsYnFG6J9xqAMk7gvTga+d/l/8ooMxU6blaNjty8a74GW1Ku5zyLZcldaOtGJ
	pgzguRmlvZnCJCJd0YRXsFgP8R564hl3jmIJRfVbwXHHbV6oCTuZnCdpKlY80muv4N4vldxBSUG
	5rnpGNC7AR07P1TtdlGzWu7i9cBHHP9jpBbDYSiC3aX0DudLBL6zOg9oHRnPesGVqu35lgm3Zz+
	Zw1HQy+O6ncm2oynZeHEvSEkfaBEHs//tH0ZvkBil/mR2x8YzlYMyE6MMBqaFsh29qx8PB7Bhzk
	RF4GGMNY2sdxbawtLZ7Papa4lwhBxkAnTy1uXDuuRt3zZf79pcxbOiqJyYNtB5H6viq8DBmtYBr
	I290YExd9ph1mfiAcqCatyjIzP0RpfvbyHldY/V9Vxmy3XGYa3wRSWeJ0F1L6UfyONrVqKW8KiQ
	PnDoJMAT1U3gMXbxsOYOwrV67XHLvRDy07k+7zCHA7HxFJDcj4OK4Y1s7yh4ics8gDkoXoH62EU
	tGsf1AXbben1fITKjeJMY45SppsRV3m69Tq6xdhmjeGX7znW
X-Received: by 2002:ad4:5c6f:0:b0:919:952d:f5b8 with SMTP id 6a1803df08f44-91b53c8beedmr229366d6.50.1791487034251;
        Thu, 08 Oct 2026 12:17:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5199b032sm4046936d6.4.2026.10.08.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:17:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH v2] sparc64: Define p4d_page() instead of stubbing it to NULL
Date: Thu,  8 Oct 2026 12:17:11 -0700
Message-ID: <20261008191711.223236-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sparc64 allmodconfig build with LLVM fails in vmalloc_to_page():

  mm/vmalloc.c: error: performing pointer arithmetic on a null pointer
  has undefined behavior [-Werror,-Wnull-pointer-arithmetic]

sparc64 defines p4d_page() as NULL, on the assumption that it is only
used by stubbed out hugetlb gup code. Generic code now uses it in
vmalloc_to_page(), ptdump and KASAN. In vmalloc_to_page() the NULL is
used in pointer arithmetic, which clang diagnoses even though the
branch is unreachable on sparc64.

Define p4d_page() as a NULL function to silence clang's warning on an
unreachable branch. sparc64 has no p4d leaf mappings, so there is no
functional change.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use a NULL function instead.
 arch/sparc/include/asm/pgtable_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 35a217bf6e5c..54e563eb0efd 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -851,7 +851,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
 
 /* only used by the stubbed out hugetlb gup code, should never be called */
-#define p4d_page(p4d)			NULL
+#define p4d_page(p4d)			static inline struct page *p4d_page(p4d_t p4d) { return NULL; }
 
 #define pud_leaf pud_leaf
 static inline bool pud_leaf(pud_t pud)
-- 
2.56.0

