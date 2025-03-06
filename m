Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C0823DE;
	Thu,  6 Mar 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270057; cv=none; b=WO58b6efvy5R+9Ks4dqPrUzhXY09kPrsWhIgTNzoOthx4ef239AOmyQFSd0oBpv9VBzkvcxdATy3GWw6bZtiZ9Fn0qehpO2KouA8gToCAwwtkJHHABURJHLcH+QGxYGd40YXf0VTdQ4GD6lWwAEXjNbfMcqM2wk2WfBUe2CI3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270057; c=relaxed/simple;
	bh=ACBl2Fq/Y+AeDxVyAuPw9jDrfJIgt71CLxWbfrKoGm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2+xLJZQ34quS5vYT3eZeOFGxL+XKVULM071x5zdiB1YgVE3ejhmIIe0i/lty75SsKI3b9sncV9Z+nXEJ3NJQj0yt1Tb1S49qh7/JuxhPLKGMbbtC7QNgL4OXkZxl6MHxtfhCSWh8jM7JHDs1caQqo5K06pfHWgNWLGaAJa1lSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Quig70Xo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e3b4mAdk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Quig70Xo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e3b4mAdk"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741270053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2crXcGvedM/l/P9SdD7SNW7ifDpTDKg+mtvUD2PYjsM=;
	b=Quig70XohAnNH332230EP8SIZNq+5lokc88kZRdKaR74Iq7Jb5Av6vEtdEXjslyBtDrRke
	gV55lCqAOOdIePJAALaLSiokDiCpVb4CTe+NFfSKrgqc0mSi4bhWOcPjHULDC+rS6BRAPF
	TqkaxxL7btm+O/qhJgi3KjGUe6zBG+nJKughRzoTSeIPjJm4JnuJ7c3SwobhAUi/43mXin
	ZtcN+PddciItSACrjL3yk2X+8BpixdXWzUbHtc126iLkrDXICcsGANmpEOvf2rdZbEHlf+
	ZNYIYd4Xi/nGVvP4Hz1ig8xueWbZAKiFmZx2BwpDGbONqZDQYgnSxJ0sAnvnOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741270053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2crXcGvedM/l/P9SdD7SNW7ifDpTDKg+mtvUD2PYjsM=;
	b=e3b4mAdkyWPAKE5CDWiWdjOx0TIl9bm+abod421qjbK1Us+ybqyoIFW8CBJUoJqEFmH9ud
	yne7yCCthEdsxkBA==
Date: Thu, 06 Mar 2025 15:07:21 +0100
Subject: [PATCH v2 2/2] sparc: vdso: Always reject undefined references
 during linking
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-vdso-checkundef-v2-2-a26cc315fd73@linutronix.de>
References: <20250306-vdso-checkundef-v2-0-a26cc315fd73@linutronix.de>
In-Reply-To: <20250306-vdso-checkundef-v2-0-a26cc315fd73@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741270050; l=1993;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ACBl2Fq/Y+AeDxVyAuPw9jDrfJIgt71CLxWbfrKoGm4=;
 b=UuaTRkXYjiIVxjUdQQMpfDmQC4YBDeYk6fa+gs14FSvUDvzMsPh0HIlcGVWDoQEtKJqZ5fQMd
 QecvT4zWUjQAxoJa5AXsLFgb2hu7KYO3I/RvjFhkmLnFCKpJin4t1ro
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
index 50ec2978cda5397841daad6ffdc9682811b9b38e..fdc4a8f5a49c5b27fbaee861b24e8b31cfe64477 100644
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
2.48.1

