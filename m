Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437D20CCD9;
	Fri, 11 Oct 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638337; cv=none; b=Ri1nTJs71RcnsvGv4ILuAr1mQW9tTi4rkL0SYen8/jVvBYm5QPY9mvv79+LT7pZ2mTiHi+YJY0XEe0EYXvz0/NPepB8Z/cT/xIcU8Q9QC8bSSWMreCIlJ79ZeSNgH4sosZCOc9M7IXTHaLdZsZRIQxtwFcU3pHENXcRAkI05Z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638337; c=relaxed/simple;
	bh=t1AATzKotfQo47rXCJvuPRI3mhX3sXVhtvZQtdB1CqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIKvVDskW/EmPaqeNHdK1CPHvkw4xjt5qZc+LBPb6z+YWc9+ydSmmRbQtBzXx+b2hmpeup+RmwV58yKa3a45Oe/X8oWlpLS5GU+FH2fgfdPkFk+xq6a6emz8dpHIm3ozL6N+v0CmkgZEt4BhTfUj5lfnZAL18OyGQG0zZJIypsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Azdsz7gp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQaX3Xlr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Azdsz7gp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQaX3Xlr"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg9B8PQ0+lOyKlgoz+gQ2Jyp4iAe3qYLBwLYXFt7qs0=;
	b=Azdsz7gpKjh7+LH3mmcClME+4j4GCUx//ySNzUyPGieMaTYeqheWB33EJDWCkOeeBClFDm
	8mOtiBEbKplTI0DloFBIinFll7YGD9/dT0Q9M5pulKs2dnG78hi0QmLb1fMYubVEtZGRJT
	gGgOD9fbCSAcjGXVCOyHHfbo09Dk5ovcf0hYSa3sVWeuqp4qK5+jhqeyLp8Vt0jnjJ5bwM
	TMfPzOKaxy8w3jZ/aEzgXRqRDblylw6SFQpvBnPfFfI5fDepGyjV6LAIf0x6JXFq1cQe1M
	OPkpTYJKswVzifW6e6QqjabKbojAtbjwJKTo1xb+Z+DQUFypYwwmgPY3Qt2uhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg9B8PQ0+lOyKlgoz+gQ2Jyp4iAe3qYLBwLYXFt7qs0=;
	b=YQaX3Xlru3m2t43QFH8dxz9o9eqAXcWc9oghCmk2YfnucKpAh7+poULkH5OfFCtT9vyvzz
	VDKp96rMH+UNZwDg==
Date: Fri, 11 Oct 2024 11:18:27 +0200
Subject: [PATCH 3/3] sparc: vdso: Always reject undefined references in
 during linking
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-vdso-checkundef-v1-3-1a46e0352d20@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=1993;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=t1AATzKotfQo47rXCJvuPRI3mhX3sXVhtvZQtdB1CqY=;
 b=Eek2fn25N6T9f+HSgVJC+e6+MNtLYV0HzJLw9/OPZ6RC3lZPRES2yGQNKYH1dSHp0sTu22Efm
 FMeeW9L9LMaAoXuDSKNNdJyDRYrCSWkAh0TVYmUhGvPBbu7ddYKiO8y
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh script.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/Makefile      |  7 +++----
 arch/sparc/vdso/checkundef.sh | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 243dbfc4609d804fc221c3591eebe891107ffdab..c7697884975ea09ccb9bda1e42d2f9f09f23fc49 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -22,7 +22,7 @@ targets += $(foreach x, 32 64, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 --no-undefined \
+VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 \
 			-z max-page-size=8192
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -101,7 +101,6 @@ $(obj)/vdso32.so.dbg: FORCE \
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		sh $(src)/checkundef.sh '$(OBJDUMP)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined
diff --git a/arch/sparc/vdso/checkundef.sh b/arch/sparc/vdso/checkundef.sh
deleted file mode 100644
index 2d85876ffc32519ab8a0702917fedd31293cd9da..0000000000000000000000000000000000000000
--- a/arch/sparc/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-objdump="$1"
-file="$2"
-$objdump -t "$file" | grep '*UUND*' | grep -v '#scratch' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi

-- 
2.47.0

