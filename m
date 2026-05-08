Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F324503B
	for <sparclinux@vger.kernel.org>; Fri,  8 May 2026 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778206300; cv=none; b=SQ7ffcP1x9gv03OmhJNhws8oAzgSWot5Ojkh19NvahDt3RXVXIgJlL3X8ZJIfpd6gpsY7Tmbd/S9qJWnevR4ur5zmFx4WHrAjkjYjlKz1j87L3FfHnwoxwDopKTl0Ic6QU/iXzsiFlO8WyY+aO0pr2K4JJ6UOMddIPy9rzrjk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778206300; c=relaxed/simple;
	bh=zcuDlvfTQjwKaid2r4G4QhvfGnrUZyPpYyuO+iIQo/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3oy1j6xMkq35hC22JG6FI82uzfTQ0+GzCdXxQpcgsHMyOlpKmSihsd+a2dJymzvZl8ocXcPJMiEIxTq7eYB/EZEDhw9+Vy6O84dWPiYD9An5LW0Fi3jhSJJT/uAhD69//svItVn04IHz74jwX0bVVyHxzUjE3eGZTnOzvnq3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAH0mD71; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAH0mD71"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba6485d219so9879785ad.3
        for <sparclinux@vger.kernel.org>; Thu, 07 May 2026 19:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778206298; x=1778811098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjl5jAW0z3TEk+mYG+Ravixfsv3DlsZiiyMW4sxaDzQ=;
        b=jAH0mD71v7jTQDqVEd7+Hm2cFGA4mqMwO4FzvY9Hf9XLaRRpbMaXpg3gnjqOEdSuxp
         3vROZ5YQ0lkd/4WPXuSe3JO3x37/p33LIyyN14frxqPc1ru1tQDz22odL+xZ0bQQ3Ynl
         LkEnL1rCg7g4EhbgcasUMpPF5ssNnXjghhjbZapvmud2mJ4ozAgY7etWM68TaEsYTRMb
         qBNJ/2srKP69gd73TplcpoJWlGpRqw3ZZFkXJsH3bppt3oqZNIfXqgydr0VaHQpUp82w
         5hycWe/WAnm86+jtJJLfopZAghPg7VvyPJKRsXe7+OUIdBlIWv4EOaLeBLntqENVI8Ok
         NiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778206298; x=1778811098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjl5jAW0z3TEk+mYG+Ravixfsv3DlsZiiyMW4sxaDzQ=;
        b=T6rustdWRBn6iTCZsXSZ1J18GqhfWRt4V7nb6PgYZpECeVHG7OvUfH0QoOqeH3bO6R
         KBvDsblvaqK8CNK3qiV3oCzmxOb6NPI5odckRT6ZqV6qgDOLHJ2UDTjf1H4CcH4ync7n
         qN2p/jyg6YlafTH5Znruqzce+vClsmVssTX9JJIv4HolQjUJIuREOW1k6Eexba7nPaNW
         EY0I80yemNgHH1cpraOpQnlr1zNsOw4to2ZmcD6t7ZTJNQTxpDMRIVx/oLdAUl0Qs5ML
         A//qbUzBPzhfORJnfxyXiXByx+YBj5/3O8Ya/a+HtiIIoKfr2ab/OjlyM75muo6gA9Sf
         mJjA==
X-Gm-Message-State: AOJu0Yy+khf4MalnvXmnpisEwO3LAbcKFG2cHAG728o1muSFz4Qqvtjx
	h2ufe+fgrxUNNUTU8W9mhJAFEpfAZ+h2xEyPk5IHYVo23kHMxpqn5tfN8j4qDRl+
X-Gm-Gg: Acq92OG6O+44jcrLYXEZiRc6a32Pgx6RhOBiOjswUlyLiZrmPFCieFdbehV9EAUV9bw
	Mjrgg1xQ4mcoOZx4pForMwmXh3b3qSnoHIcp/XLW2buGFjStZ9HZzMmpUm9FKD0tnkthFBtFrzn
	UlzpTMEyUNtASmpBj2n9sVni9kOd1YiqL3SzW2BnFwwVAtdBc1T2YX4yRKi4Ufh5HEbU/DBcJVP
	NPHbi3W9xaEXKf4zrXoDL/+EaY7eeo2/q+50/ob/J33b9j58gO9FEj9qjYBgPaXSqY16mP1kR01
	B57NZTa/nzUrEBVw9Bs7/LoFsL/j+udaE4AmiN2KJmWRXCCd0VtCFahgT55wd6/tg4Po9bQWbi+
	8Smnk4e2A8bQ6r6GMmVjjKMK1HwDF+7ZSTXvGA9vT7DDuadseLatK5dTGyNoebfob9xonU4+nOY
	sUdcBpKMlUTJWqpbcVfsuNbZfFLbd2B4yvEKWt+CmIEg2jRNwd33SasIQ7OJ55dTZjWyM3NzMHW
	c+yaBAFNp2nww6YqU525RiLCe47q0DUF+08CmDUOisk0w==
X-Received: by 2002:a17:903:46c6:b0:2ba:9e1c:7c93 with SMTP id d9443c01a7336-2ba9e1c7ddamr80600225ad.40.1778206297843;
        Thu, 07 May 2026 19:11:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4094fsm2124135ad.19.2026.05.07.19.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:11:37 -0700 (PDT)
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
Subject: [PATCH] sparc: Export mcount for Clang-built modules
Date: Thu,  7 May 2026 19:11:19 -0700
Message-ID: <20260508021119.1635054-1-rosenp@gmail.com>
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
 arch/sparc/lib/mcount.S | 1 +
 1 file changed, 1 insertion(+)

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

