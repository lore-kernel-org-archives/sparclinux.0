Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5533B2AA
	for <sparclinux@vger.kernel.org>; Fri,  9 Oct 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581577; cv=none; b=YDi4iQgqzaWBnLjQD3YYbql4xWIbN2uszXmsICKntQU04HCFohbzP8ZAdjjJ7hTymvipJnN8EdKugzaACu1DwriJdZnoN0HImtC3TWRrQ8f+HPj9A3H+/IpRbuoI6SJgc42UPD9FQot1mN9Y1sC07qFZGs8frNQZwxNL5KxMj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581577; c=relaxed/simple;
	bh=tYoPTUJ3dCvu5GHSRIsiqDZLpqiBVrZfjRC+6TGss30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crHonVN9+HnOPZygXiQe0m6RLnnDjbfZeRy9GX7ovhUUZHTjHbHX1hq9u4VoMxP2AVpnY4EcXaOK/FqM9GnYrgN/wKKzTcjIPi/thSFVdlCveeEWtG3CpW2iaG3aEA3Hf12MmovWHjpc1O1xKhsdU5CPlwo6sDuRt+biNE5p+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSh2i8tk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSh2i8tk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so778325ad.2
        for <sparclinux@vger.kernel.org>; Fri, 09 Oct 2026 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791581576; x=1792186376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/FpltOJ2Bx3xU6yFNT6UsoheDoakZFC4nFP/xB2F2U=;
        b=DSh2i8tkMBoVnrtSLpZR/bjsbZ22nMntQjHbaR1k6CJFZAXtOhvUp69H4ZS2GdObNj
         +0YQwwXrpvZpjCIxr3IiqmgZDCDijvsgarqxSfZh+gxilbBYWiUEHBpiPD18Bxb0Srmn
         TGroLy6hVfT380SoKSoDfsHlGFVDH18ojegy39aXj/cYUHZCGo9a/JhTAU5NSH51v8Ez
         OKv46H2XBPS3xM1uXgrfpGPlY94OF/CrVGL0LUs3bgRPpo6wfNmp+7hYmGB31AfChWGI
         aHo7ydv3NdzPNlalIurkd0HBPGzvkyVri3nu2rAO65FvgsPg8ecHhtk1qL8cfdmtVAWI
         1+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581576; x=1792186376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/FpltOJ2Bx3xU6yFNT6UsoheDoakZFC4nFP/xB2F2U=;
        b=hPmx+Eo8T8T8zYPEwKxK3w+cIhLmO67v5LejOIoh/U59e3umsvfLTGtj9NzzGLMU2A
         qG9XGC6PagdwBosqShLxhYN7T1EwtrnPaw8GMIAEpgPPUMrYVKz7ETBResJ8Xh5LI/lH
         bRCrLRnuFS3F+oAWETqkUuIpqq0CRRudrBYKTBeL60jUtdiynfiVnBla5DrfPjfx999w
         dYguH3tdl7YH2KLkFcHpR1Qk70G4v7vVCGoTELxOcZNOcpTU56JDVCnQkWlRN6xj8yMs
         /QKIl5QUqVLKT0VintJtX17NQvOimK1iLKUorzZne0Q8uncQ71iMRNZgJ09BEhNvVaBm
         J5/Q==
X-Gm-Message-State: AFq9FYIrI0XMu1QGswNctlycEvJ66UWHSv7GCOeui4GPc0RgQBFm8sc8
	AoytIIrYv0ytNzTF0IGBEeUCRpYjBgBAx0RWF2YaTffnadXneqUo1afZbHFn7tDP
X-Gm-Gg: AYBFou2HUHnWJGPFkIfKnV1bIwszPqxK9/4Y5E8HkTMUe4iV2E4T1N2h2azMIfAEViB
	E53ZAz+yvYC7kaOtQCSSYvCXpAh24xnAKQtPq3rPe8QjaozTGdoYFEzuQlyKZc3dOPScDitipSA
	YEEW1rm9vlqPf33idhdnwVe3NPpMdgeR/srr3C18vgcy6yzRhEZRQtaQHigd9QdF/8kHGKxJ3m8
	92dtzz+nqiKpPOnGGpZeOpRW1rGzdxyLnW4CfwITuO1NAyMlXhbIEqyBB+QJQIO1Gqi/Yk1ftyc
	n8CoPdyG90mDHuvnxUlv2dmJpTL+fTSuHPfiNjnjLLHCGpQzVu+fI1SCz6U3Ga0P8zRMgQcj6T9
	fzGXVmATRjvjzDfKVQCslcyDshh2CXpta5OeXt/btZt3UrP45sZcm7nayXpNkz/OuE9aDbiH/LE
	UEK3n4JqICDu6xdDppcfY0Z7kOpMDfhYxvQBmn+VDhVmAwnEqf9a6urLqi8u4Vexp7MEC925C40
	UrpLgOxuafhyT6pNO6yLSUj/rA5/vNifwf+XgfLK4GrURtPYwZTuqhJaV4uazob8l2rLNXwyjT3
	S+SyZ6QOPUeQC2tLoPf0GNJ1rdWXgkoKvxyLoyMnXy/9ozGp
X-Received: by 2002:a17:903:2987:b0:2e2:b557:aa56 with SMTP id d9443c01a7336-2e842dfb377mr27906225ad.57.1791581575590;
        Fri, 09 Oct 2026 14:32:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8dabsm16581735ad.58.2026.10.09.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:32:55 -0700 (PDT)
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
Subject: [PATCH v3] sparc64: Define p4d_page() instead of stubbing it to NULL
Date: Fri,  9 Oct 2026 14:32:52 -0700
Message-ID: <20261009213252.111043-1-rosenp@gmail.com>
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
 v3: do it properly.
 v2: use a NULL function instead.
 arch/sparc/include/asm/pgtable_64.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 35a217bf6e5c..bd4fc65e4bfe 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -851,7 +851,11 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
 
 /* only used by the stubbed out hugetlb gup code, should never be called */
-#define p4d_page(p4d)			NULL
+#define p4d_page p4d_page
+static inline struct page *p4d_page(p4d_t p4d)
+{
+	return NULL;
+}
 
 #define pud_leaf pud_leaf
 static inline bool pud_leaf(pud_t pud)
-- 
2.56.0

