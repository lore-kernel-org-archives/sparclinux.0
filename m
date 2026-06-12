Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF356395AD7
	for <sparclinux@vger.kernel.org>; Fri, 12 Jun 2026 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288124; cv=none; b=iJlRbVNsC1mJlX3MWG8q1H2av9QukyNwOIJzIHhgTBpwNrHgjBlylVnCxmNXrIq9oUFzE94R/dWnBGUFB4XNGcP3mzdcqUQ+46vSQpSCAPLKWYUE1vgxdPNJqRFMS1RntWA/6jhmddiLIw3XpAsDJDNqy4lXFVbvOc9RM6+kOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288124; c=relaxed/simple;
	bh=vsANt1h9HdzXbx7N3oL80yOXLqH5oygsCyvZrb3biUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz1LJr597w+vEOjx8Y04kcgga6ZJAIeMNef4BLgeR6mCDNxG3/yPLL5VKYvMf1X4GZrIoAqLqxRFr6K7Kf+x1TSedxQZZ4LARxPNrboQwKAdUQ2ti85Pgeau3LvZugdtntJNYlYPkCP2f39RqBTkmrRuJYJYxvfQVfSNYem4clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqvg+V5i; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqvg+V5i"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304f590dd91so1537074eec.0
        for <sparclinux@vger.kernel.org>; Fri, 12 Jun 2026 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781288122; x=1781892922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpLH7pAfvy2/Tbtaa6B4TgQbD2Aufq4wSSHnGDhKK04=;
        b=Mqvg+V5iVdf/RMZJNevCpWFp59yoKZjLcgcT+evgFMVyK0IFmGLLsQXHrRXK/5RSX2
         RatWvDlVdR4vnmStQ8+4hprYD4/d+7OSec70rHeYwAjXjJlgSdlJ9esi95EaJ/23UO5E
         H8Ev9QTAkh0s3py5YYvemPep4gRriNW1VASwZkl1wRly5VAi1YgnwESFB4B/+shwQFA2
         lMCI5qcBsQASALpm+i/ZBs9hdqts9DqLrnCWww4+bgv6YJwDg8ARVtm/bZpdaRINmh66
         nMhKvoCCzYLCXVFMzUkVSJmHCetgTmEm1GZzFV4qEUP5h4cuBb0BF3du2SZ1MJlhrQzz
         i5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781288122; x=1781892922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpLH7pAfvy2/Tbtaa6B4TgQbD2Aufq4wSSHnGDhKK04=;
        b=iTDhpGtbbZ6k+eU8mPdQgIfQ9Yf5MZczhxI7g2CcJ/Ja7hKkk5bb2DTE/CSRZkHM8v
         53m3yawWZBEoWKqJCkkkoTbWEJiINMuTzMJTAA7uPIrp7+IK703thxQVggoQjHLu6IDX
         rI+iBHwQ/sFa1XWg/g85HbdcItxlo70KmL6khgVh3MtHOYDSdG74EiAC8FpgrHvubRgk
         8uJqfiAOtODo9GBU/fJinzULPYAaxDUYJn7cfJxpljfE7E8FJOXwZ423bMoh30k8LATf
         DnLYrrnoJ/6osG61FvoNFxqepA3Z+rEj4LjRjUvisnWkBCgRmNlMcMj3wtCrXoE2pOyc
         siDw==
X-Gm-Message-State: AOJu0Yx9kyFNW3d3uxayyidSYLYd1H9EdfDokr8VJyYKG+wWIRYiZGrp
	zVONGVp6Mhq0aoaXU3qjeDo519ExFtTGaPTmIhV9gK5WYKudJ5RJ7da/6K/L6w==
X-Gm-Gg: Acq92OHQxPMkGlZuhsLhlXlmJtW9a59KpSjDb+PD2XiWMGV0IqmRq0gA/WjKDX0kAl7
	gYZSW45QYWtfuEetHjQPg2wutQIAogGD/t/yynSIYRER2ROpmbWuI94AIaTfg+rPVCQDiUHTXSc
	ygSEM2dKc0JHgw06AyUA4UxT8TgsffRvTA7eyPpDse+UbIvs3fMkPowMmt+u+2c2ymUbhuk32MW
	08A1ULCfoSYtmae7rpT76jBeQh+y6CVAfmwmCljc/F1Yrc7gQIDOzBFFH/29w+aje8z8xs7nJdU
	eG1+w0quETwKnUWQ7cVM7ye8F5JbPPphYyXEIxPbOTuOwYL+ekx0vhwHWZW83m3wXpYx/YqZin3
	uvz65bP1PRriRZ33NJpbH0FBXf7MdRTHqZks6dQbuLQNXRYhkVg1JFzRqwT9dwS1J9AAkt7QziZ
	Ass+05oeY1CUW1XGjhMY4Ju7Uq1AQb7kHb7d2UWx0hjBtu2uxsmDfMnH7dSVMvF/WkQKxcliSdQ
	UcloaGqgIRq6OapJAWV1WXVRVlLFa77cg==
X-Received: by 2002:a05:7300:e7a5:b0:2ed:e14:e954 with SMTP id 5a478bee46e88-308200c2827mr1977791eec.30.1781288121023;
        Fri, 12 Jun 2026 11:15:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm4765327eec.4.2026.06.12.11.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:15:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv2] sparc: Export mcount for Clang-built modules
Date: Fri, 12 Jun 2026 11:15:03 -0700
Message-ID: <20260612181503.4509-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang emits calls to mcount for -pg on sparc64, while the
existing ftrace support only exports the _mcount name. With
FUNCTION_TRACER enabled, modules can therefore keep relocations
against mcount and fail during modpost:

  ERROR: modpost: "mcount" [arch/sparc/kernel/chmc.ko] undefined!

_mcount and mcount are aliases in arch/sparc/lib/mcount.S. Export
the plain mcount alias as well so Clang-built modules can resolve
their profiling call target.

Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add declaration in asm-prototypes.h
 arch/sparc/include/asm/asm-prototypes.h | 1 +
 arch/sparc/lib/mcount.S                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
index 270c51017212..a39a24c53216 100644
--- a/arch/sparc/include/asm/asm-prototypes.h
+++ b/arch/sparc/include/asm/asm-prototypes.h
@@ -26,6 +26,7 @@ void *memset(void *s, int c, size_t n);
 typedef int TItype __attribute__((mode(TI)));
 TItype __multi3(TItype a, TItype b);
 void _mcount(void);
+void mcount(void);

 s64 __ashldi3(s64, int);
 s64 __lshrdi3(s64, int);
diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index f7f7910eb41e..0309ba2c4712 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -21,6 +21,7 @@
 	EXPORT_SYMBOL(_mcount)
 	.globl		mcount
 	.type		mcount,#function
+	EXPORT_SYMBOL(mcount)
 _mcount:
 mcount:
 #ifdef CONFIG_FUNCTION_TRACER
--
2.54.0

