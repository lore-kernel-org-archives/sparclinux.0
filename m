Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369C1A7AFD
	for <sparclinux@vger.kernel.org>; Fri, 14 Mar 2025 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936379; cv=none; b=gFDNO2uNN9iQk4gO7IVanjfCXxX32ShPgmy2Zituj/1BoHlqsHLE7Pvfaz31CRktG2E+kbnpq1+XOw6IBhWxmMwYULmG3t/8k0dturC41VnU9yf71fYT+1bJvpLDTcqUslUHoFZ5xAQlIiOggkZo5ZrwIXzbmObIeqpNEscdKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936379; c=relaxed/simple;
	bh=9xQL9gUZtsTa1+i31s/L1XOaSXuleBbD/ohPxCzyXvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skiMZyapJE9IQXq1xyQq7Cr0We3Lq4b739OnxFZYTHhA3lxbKS3t+rdZwmmTjGrZS9WUphZ2TxobBcgSHBWSzN3Enf3AjgkOIE6ZVJtVSRhQ47SlPscF+Ss2zcUeLDnqU0v/xc2UBzBemQA87dXK8bnr+C8qHWn7RfhM/bXaH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtPh1HSQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtPh1HSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iay0CrVptBuvnGbejO4YL8azX+712wm3IP76Ts/cWEE=;
	b=dtPh1HSQmwgiYDEc1lnN3izrlCnCDIcKlBdRsbc19XVfKHeZ9Nh3dKdEtAyrkPibQ57lzJ
	CrCz3uXNAyz1dVLUP3/SmV8UHksXw4OJPgHppLuQ2QjmtdqilXa6p18/GJAzQLqXeuMv5B
	TYZ0XfqdbCHrc9HtD8k2r9c+yBSUNUw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-4bUaToxWMbWRtxG3JC4W2Q-1; Fri,
 14 Mar 2025 03:12:51 -0400
X-MC-Unique: 4bUaToxWMbWRtxG3JC4W2Q-1
X-Mimecast-MFC-AGG-ID: 4bUaToxWMbWRtxG3JC4W2Q_1741936370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C861119560B4;
	Fri, 14 Mar 2025 07:12:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F7EE1801747;
	Fri, 14 Mar 2025 07:12:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Subject: [PATCH 33/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:10:04 +0100
Message-ID: <20250314071013.1575167-34-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/sparc/include/uapi/asm/ptrace.h | 24 ++++++++++++------------
 arch/sparc/include/uapi/asm/signal.h |  4 ++--
 arch/sparc/include/uapi/asm/traps.h  |  4 ++--
 arch/sparc/include/uapi/asm/utrap.h  |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/ptrace.h b/arch/sparc/include/uapi/asm/ptrace.h
index abe640037a55d..2eb677f4eb6ab 100644
--- a/arch/sparc/include/uapi/asm/ptrace.h
+++ b/arch/sparc/include/uapi/asm/ptrace.h
@@ -15,7 +15,7 @@
  */
 #define PT_REGS_MAGIC 0x57ac6c00
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -88,7 +88,7 @@ struct sparc_trapf {
 	unsigned long _unused;
 	struct pt_regs *regs;
 };
-#endif /* (!__ASSEMBLY__) */
+#endif /* (!__ASSEMBLER__) */
 #else
 /* 32 bit sparc */
 
@@ -97,7 +97,7 @@ struct sparc_trapf {
 /* This struct defines the way the registers are stored on the
  * stack during a system call and basically all traps.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -125,11 +125,11 @@ struct sparc_stackf {
 	unsigned long xargs[6];
 	unsigned long xxargs[1];
 };
-#endif /* (!__ASSEMBLY__) */
+#endif /* (!__ASSEMBLER__) */
 
 #endif /* (defined(__sparc__) && defined(__arch64__))*/
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define TRACEREG_SZ	sizeof(struct pt_regs)
 #define STACKFRAME_SZ	sizeof(struct sparc_stackf)
@@ -137,7 +137,7 @@ struct sparc_stackf {
 #define TRACEREG32_SZ	sizeof(struct pt_regs32)
 #define STACKFRAME32_SZ	sizeof(struct sparc_stackf32)
 
-#endif /* (!__ASSEMBLY__) */
+#endif /* (!__ASSEMBLER__) */
 
 #define UREG_G0        0
 #define UREG_G1        1
@@ -161,30 +161,30 @@ struct sparc_stackf {
 #if defined(__sparc__) && defined(__arch64__)
 /* 64 bit sparc */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 /* For assembly code. */
 #define TRACEREG_SZ		0xa0
 #define STACKFRAME_SZ		0xc0
 
 #define TRACEREG32_SZ		0x50
 #define STACKFRAME32_SZ		0x60
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* (defined(__sparc__) && defined(__arch64__)) */
 
 /* 32 bit sparc */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 
-#else /* (!__ASSEMBLY__) */
+#else /* (!__ASSEMBLER__) */
 /* For assembly code. */
 #define TRACEREG_SZ       0x50
 #define STACKFRAME_SZ     0x60
-#endif /* (!__ASSEMBLY__) */
+#endif /* (!__ASSEMBLER__) */
 
 #endif /* (defined(__sparc__) && defined(__arch64__)) */
 
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index b613829247250..9c64d7cb85c2a 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -105,7 +105,7 @@
 #define __old_sigaction32	sigaction32
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef unsigned long __old_sigset_t;            /* at least 32 bits */
 
@@ -176,6 +176,6 @@ typedef struct sigaltstack {
 } stack_t;
 
 
-#endif /* !(__ASSEMBLY__) */
+#endif /* !(__ASSEMBLER__) */
 
 #endif /* _UAPI__SPARC_SIGNAL_H */
diff --git a/arch/sparc/include/uapi/asm/traps.h b/arch/sparc/include/uapi/asm/traps.h
index 930db746f8bd7..43fe5b8fe8be1 100644
--- a/arch/sparc/include/uapi/asm/traps.h
+++ b/arch/sparc/include/uapi/asm/traps.h
@@ -10,8 +10,8 @@
 
 #define NUM_SPARC_TRAPS  255
 
-#ifndef __ASSEMBLY__
-#endif /* !(__ASSEMBLY__) */
+#ifndef __ASSEMBLER__
+#endif /* !(__ASSEMBLER__) */
 
 /* For patching the trap table at boot time, we need to know how to
  * form various common Sparc instructions.  Thus these macros...
diff --git a/arch/sparc/include/uapi/asm/utrap.h b/arch/sparc/include/uapi/asm/utrap.h
index d890b7fc6e835..a489b08b6a33d 100644
--- a/arch/sparc/include/uapi/asm/utrap.h
+++ b/arch/sparc/include/uapi/asm/utrap.h
@@ -44,9 +44,9 @@
 
 #define	UTH_NOCHANGE				(-1)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef int utrap_entry_t;
 typedef void *utrap_handler_t;
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* !(__ASM_SPARC64_PROCESSOR_H) */
-- 
2.48.1

