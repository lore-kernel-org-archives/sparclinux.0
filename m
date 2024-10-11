Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA020A5F0;
	Fri, 11 Oct 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638336; cv=none; b=SxzovbsQDCjSqW3vlJu9P9NTBNlgmXB0iAAtEunHuAXLw57J4T2wlWe9Utth65x0sR0Q0MjgzOtTW0yUVu8I4yyj2YlSbBqC2cqXPm+j+eNnw9WWo+4t+mBlPdCJLV2AKM2UYY1YQviXgxtqpl5gewHGJ5a/Jj0XsMcXqBBGlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638336; c=relaxed/simple;
	bh=8graJ88b/1tuzP7zyilPImJgtI4+2y3oe5+fECRuaC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cuES5QMSCtu8145bI/xFFUjNeetL7Mj8aJxmecdVUxY7mtVM/z0vIh8Zcsi/wBM9JwIya+kJytvii5h8eDAJcKziEsi/0xFurHiehMPmP7lhXKuyupofEQh6QxeDWPVfIcq+3ViTtN4gigBIrI3kJc8pZ+0ufZpcs1egeggZ9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMItqUBA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HoF1+6rt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMItqUBA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HoF1+6rt"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WofKWQfIubfeHKDL8Z7mLX9FYWEFQjb7A3Rqqw9UA/8=;
	b=pMItqUBA1FGTHUAJGwjQLn8u28ELmvCCdkFJp61+T44IQEHQy66+ju6NrDUBJuj5paWP44
	DDlqLPIjTe3ZR/YONfALP5fDqWR30q+BWI6oPxvifwN/K1EnqauT7SJ/Wzwos6LCdH3J93
	dUJSpqzQpBYWDbgyLMQwbxhV80N8NqA63cnwzTeMOjoZPC/8RHBbxmbnnp+2nl0GVN0A7W
	AmSHIhIaVy/+MwcvHjJwVq6/C/iefgkWzROQhiVwLTjotScE4f7CEE2XGLkCDX+5gBaGOl
	Ewb6fz46k4VD8RM0BZYlR9Oseo89C2IEEr6+1c9GvtL/3mYDBDjK1dopCiz9MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WofKWQfIubfeHKDL8Z7mLX9FYWEFQjb7A3Rqqw9UA/8=;
	b=HoF1+6rtA7cY8FPUyY2ENIq3BU8v1ZjnYJVrIo3MatrHGR4E19nKDGVeWzMY0exIp1C2fT
	UCYWjl88JJqu3jAg==
Date: Fri, 11 Oct 2024 11:18:25 +0200
Subject: [PATCH 1/3] x86: vdso: Always reject undefined references in
 during linking
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-vdso-checkundef-v1-1-1a46e0352d20@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=2103;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8graJ88b/1tuzP7zyilPImJgtI4+2y3oe5+fECRuaC4=;
 b=QbuErtNhAAXbGdrRJr2jxflgPuO9hwjLb0cgTtUeTw+X0nZP2svxJLWcPCHmCWk1cJA1jKJ/P
 /VPOOwcIsHfAUDmveF3GaogL7lYf0UB7b3T4G7lZ5MxpZ4eetTYT+JB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh script.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/Makefile      |  7 +++----
 arch/x86/entry/vdso/checkundef.sh | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1eb8c1e5bc5e33b41e9e40c7924cbf..99de18d88bc39f8f83f35e554028efd0a76fccec 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -32,7 +32,7 @@ targets += $(foreach x, 64 x32 32, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg
 
 CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
+VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 \
 			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -151,10 +151,9 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(src)/checkundef.sh '$(NM)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 \
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 --no-undefined \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
 
 quiet_cmd_vdso_and_check = VDSO    $@
diff --git a/arch/x86/entry/vdso/checkundef.sh b/arch/x86/entry/vdso/checkundef.sh
deleted file mode 100755
index 7ee90a9b549da32c9c12d694215b89d08645574c..0000000000000000000000000000000000000000
--- a/arch/x86/entry/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
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

