Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3CB652;
	Thu,  6 Mar 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270057; cv=none; b=Zgyny1Ln5KGcCLS1lJKz090KrSb3wzpqhBbSwajyg2Zv5vVQf16n1PEi438K9ZOMxhEhFzZNb29EWdP4LgMaD5dmNBMTlVXLdxHRJzxr2+wcTSc1DELcqluObKVwdq9PSkrhTUTXtRIst4tbg5yiLdDjZOA3Da3NchXx2DrfflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270057; c=relaxed/simple;
	bh=GhEXSN/EM4VFU8qGPpnHfmR43DlwyLm89ZZtl0vemMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOdPT9LYjbI66GQI3MlFiux5hyRmgTjR2Ku6K8wqmoU598xssCJJXI0ENcGJWeG+PlhAqzx3i0pVLxdECeNsMn1Zj7iMaxOXIgFstIwQO9heqim8Txe1XM+gFltUkuhisj329JsxuXTFRiIou+owQ9qYyrPin8k809nIvQVjv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OLdamC+0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coZCgYVN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OLdamC+0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coZCgYVN"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741270053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ubr7/L5tlTtmEcuGV6Bs6axhRGY5gsCdk+sKdxBFeI=;
	b=OLdamC+0QwGUeZLi0swRrOxjOz7vw8sadVtV3db53IswICETxhMgbaJr5skvAGTID8l+oq
	w1VJiB/y9F3sK8A+iDWozNWEPJlcSyL7KoA2t+jz8Cktq2tAnyQU2dv1YJf74Nk9J7O/uk
	B3fk34M/BUtCTxNoWOJS0WFMahIh1BTvrr3egtVDbSGRWKa6TVxtttwHRCJlaU1vz8Yw40
	TR7zFXkZqtJsXx3ZCIeo8y9pgHXy8C7tlJ3iz/eQ0YEUAN3Z8zNgsXtMCEAp9w+rWgReTa
	3bNHR80I7469WrgdbIzRpwX+xHmhcasTEHVnDHqdRMBTtO4s00CYpJ3XmCaSFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741270053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ubr7/L5tlTtmEcuGV6Bs6axhRGY5gsCdk+sKdxBFeI=;
	b=coZCgYVNdFtBby1kBQpzeCtHT/4/yk0P6OJBRo9aJlUb3lIneRZbbnKv6kD3iAK7xEf8GD
	SmED21CO9SE3VLBw==
Date: Thu, 06 Mar 2025 15:07:20 +0100
Subject: [PATCH v2 1/2] x86: vdso: Always reject undefined references
 during linking
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-vdso-checkundef-v2-1-a26cc315fd73@linutronix.de>
References: <20250306-vdso-checkundef-v2-0-a26cc315fd73@linutronix.de>
In-Reply-To: <20250306-vdso-checkundef-v2-0-a26cc315fd73@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741270050; l=2103;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GhEXSN/EM4VFU8qGPpnHfmR43DlwyLm89ZZtl0vemMo=;
 b=xGWwsJWhjPibKpAOr+k2aX0l8CG6oSOzAfSSPXMGXrJsGGYvIYZPzKtC28suQ1Dg1UsN+cCb+
 401hN39IZzSB3vkPvrm0DUBRmohzKw+Xvm+WEw1iHTiKFl3cYawymQO
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
2.48.1

