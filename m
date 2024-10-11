Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DC20B1FE;
	Fri, 11 Oct 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638336; cv=none; b=WMgcRH+7QnItO+cycf6XR6vqWidO/vWUDRq2OiQSZDRDYNmYhqckBz+46fmo4zrIETJsORcjPToN3j8WT6mMOLv8vVdVT2qrsPOuqSfaZSJ9kG7EGv1Jmd3hKcRt7jVU7y4YFvfL58NIrwrdZ/rPazS5p7aJ/mXx5eCHoo9nIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638336; c=relaxed/simple;
	bh=4nsH7iUaC1vNnWJLnteSYFDSKO+10nuui0NbMwzEzIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOm8tGx8UgN1mkYtegEbfnrlNCF+J56hY22CbRE8fw+k8gYs0s9hQTcZ/bgDL3iZgeB5RJveHgMUi1aROI5rsvO7iCnpIuklzxiipwLQ8tvzaOWq66tI1qzfPxWxgz1sHJbC+rV37SuipdLsY3bjswUREGknPhts53BeQI6XBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qV61jMqt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AH/LVh1s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qV61jMqt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AH/LVh1s"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVgHJWb8aIu8nsLafcNeHRtNCU+jcBKUUidMTXtnX8=;
	b=qV61jMqt1rbSXMy8nrB0deuV3ixLNQ6r/kkW0phr5qiZK6cbPaWQBEMZKFud1Cj14vYfjc
	09x41BGu3YfYG+03oiHkiqy1pTRWD8Vt8J6iybrqFIekk9UcyQXOTmRk1nggMQ/242E98+
	dK1RYGdBRW+xUrrqb7bNXm8mFf1tM5d3xEneXgCbe/L/ZYwuAo0W8AxfuDSKq9k0A80kuK
	eIYEPFU6RYkabtLAesczh3oA7YF8xDYlRr8nz2ZtfoTIyKq0fsLKNY1GdT7VyvuIV2hUM6
	4sLiofZkT+8pIiLK+Y1CwvBaWL5R9nyBQkbaCd0jYtRGcA+ZtlNTHwAEX2N4Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVgHJWb8aIu8nsLafcNeHRtNCU+jcBKUUidMTXtnX8=;
	b=AH/LVh1sjzAFjZVwPqws2qdH0dvDy2IDOxCiGMLgJDjAQdYO9m1sHYu/NTnx0yP9Wb9lnz
	5aaCW1OlFDgukBAg==
Date: Fri, 11 Oct 2024 11:18:26 +0200
Subject: [PATCH 2/3] um: vdso: Always reject undefined references in during
 linking
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-vdso-checkundef-v1-2-1a46e0352d20@linutronix.de>
References: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
In-Reply-To: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=1685;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4nsH7iUaC1vNnWJLnteSYFDSKO+10nuui0NbMwzEzIs=;
 b=mRjvoxyz1Kbnltp6CHWtfEnNKzNvxFmhTwBwSDK6FK+FYQokpv6ZbWdD75ppr6tcxEJ9TIPc8
 KYz8CU9O2sGCdeBgVQdjMKxdtyI2OyOIfg4niB1NRuUzk9EG00M7NWF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh script.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/um/vdso/Makefile      |  5 ++---
 arch/x86/um/vdso/checkundef.sh | 11 -----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6a77ea6434ffde178d07b4466ec18ca83718baae..7478d11dacb713384655ed76af3b469aeb5bae81 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -56,7 +56,6 @@ CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(CC) -nostdlib -o $@ \
 		       $(CC_FLAGS_LTO) $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(src)/checkundef.sh '$(NM)' '$@'
+		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
+VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack -Wl,--no-undefined
diff --git a/arch/x86/um/vdso/checkundef.sh b/arch/x86/um/vdso/checkundef.sh
deleted file mode 100644
index 8e3ea6bb956fc8fead5e280bf82a52287d1328a4..0000000000000000000000000000000000000000
--- a/arch/x86/um/vdso/checkundef.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-nm="$1"
-file="$2"
-$nm "$file" | grep '^ *U' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi

-- 
2.47.0

