Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817254C7538
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331376; cv=none; b=BVtMdwEKLHI0doTBbOfkP4PPsiaCdfO0X4qa2lVXkJcMmodO6+ZwXv9RxDjtnOK90LfL7RkdDUPoDhP1OGytriLIg8iOE0et+KhYpBKMgQSxBkCF7kDWJcgBEmSr/0vlHNg0qnplvV6n5avve0cldfOk21pgMXHHXRtlX/FtWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331376; c=relaxed/simple;
	bh=G1F+mYzfQRs8/KGGawcQwgU5uDFp2pGRLYCJ7R+lFk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6tkeo7CLuWEQdiB+K8nDdKs1v3/8vprLJsJiMJgsye4OmYTUic5eEg0mkZM59bDdrGGoCWY93GyskDr5/3eTpgXU+fX20eMyMOY5agV3xHT2+OmhtHvd2J5beSAC6kygqp/qXeOze06U8pXk0SjMKSmevbvqpFB/N0ZNiv9v30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLSpp+ft; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLSpp+ft"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso204985466b.3
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331373; x=1792936173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=VLSpp+ftSBB82aGe0/Lkd/RfqraEpUZGje0VBXeLwN7SbzpCltXVlKdBkRLTLCdyvL
         hvesBKng28cvD2X+NrsYZBKvEM2bc82kR/cS+mBoy5SmuoAArXPoXMCiJXaqdf6liRof
         ARfk4vu/ldcOr4+7Z3Ap1N7UUiwKWVQUSd3KSQP9JpQp9N/c+YIOyFTU9QkYRqD4zad8
         yDo8Hc7v5+4UYyb9Xvlw0jpDtML9mSpWkX8O2lREWFYR8UuXMEh4WJKh06ZYZHVZzeB4
         z9wCOOjjPDF/Jk5y8qDaV5gZsnPp/5dphAanEI4L58Tteh5D1EOwvyUYUgYwi8r9kZmX
         nYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331373; x=1792936173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q77PTRWOtCfp0qFp7JupQqKfjSSIE44rzpjVu0S51AM=;
        b=FCait0ni1ytqNDmLLPIwwhfe7FZWBq0epw5M0cJ2oVW2W0ujYbnYnG/lXpc0F5vRnO
         xSS5tKb5leiXD5CnzIyKKuLceOIyXYXQA7X0cGNvZBPIXenOu3lgFgp/6FSJSW6nsQQb
         Rn7XUE7O5TSBlMK94QKqxuk+OPeO1GCqZNvGjtfcleZc/nEDerL5seiwCVBLLP+fW/lL
         VjW18Qq6sSpDvRIi1Jgcv+BKc3eQWo9iRo6ucoWsGy5rYDLmFNH3yONLm19a+CePBLKq
         oqxZ4KfPuAhg6OlriijaTYgyNtaXe/FQP7rtkqyn3G4wENkQZPdVLWMmo/mqvoE/voLs
         SYHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo0e0R23VoN0/K3+If6ZqZ5RpcqqH5XFsf7VQMKVtjPNjg2BnI9AmdaDjHesufShT85O0d6xmssHQN@vger.kernel.org
X-Gm-Message-State: AFq9FYKWMSqSsnG+RRF1yu7ttgrN1MKPaUgzDoXEtIUqmd9H43TRy91f
	rGM51TNfJnlVW0bPHPlEZWhKUfYpG5fvGOjecsZGMsAzvyvaK4ISuxcO
X-Gm-Gg: AYBFou21UnTJaokAwTwVd4nKa9zzKgUS1v25RG1bOb6XmYFE3e2UdkmC924I9PHvrTw
	vjgTVU9e+hLYQzN4DmQPYrgdAe9elHRsVv+XlmoidvohL2CsSz34ca1VXNtyxss2oZrbRqzc02k
	MECdFyxyJk3uhN95Hf+A2vN5MyOe9XOctm+EnFvPLOXDkaI+16Pi9YiZMWLHsz5dr1rzmkZKeSa
	ZmzUGkiZ7qraY3d8n8Uokn/XuLlFiUvhtbLiARh7b7xZ8+8ENYaoaXjBc+wKHr61+TPW8rZNTAc
	BraRENoR3k8aErEUHP3pspTzT+0rrbkdkjLkHOppmDB72LlxqzKbQsqvsKUYsPsYDflstseyXW0
	e99b5Lyi23+ifDuaJUA8dLE28SDvHv1OiTfoWOwg8PmYqg0iq80idz5EH6CGD3WDfNCy6nmO/EP
	KtXXg8xKZML7vGrWCuoMcC8wTzaq62DB5hl+JOs5kgs2PE2Fg6JIDhGrfOpaxYWSSCmTYXJ4DfH
	k7dqJHiUlvEzTFZvaZdOKetlaGZSDoKO47M/82M
X-Received: by 2002:a17:907:60c8:b0:c43:a881:3f4b with SMTP id a640c23a62f3a-c43a8814361mr97331566b.47.1792331372603;
        Sun, 18 Oct 2026 06:49:32 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:30 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 02/10] sparc64: honor queued spinlock layout in secondary startup
Date: Sun, 18 Oct 2026 15:45:04 +0200
Message-ID: <20261018134738.1016106-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trampoline uses ldstub on byte zero of prom_entry_lock, which is a
queue-tail byte in the big-endian queued-spinlock layout. This writes
0xff000000; with NR_CPUS < 16384, a C locker can decode that tail as
CPU 16319 and access beyond the per-CPU table. Testing this byte also
fails to exclude a C holder of the locked byte at offset three.

Acquire the word with CASA, release byte three and poll while contended.
Retain explicit assembly ordering and the predicted branch for Spitfire
erratum 51; C unlock relies on TSO and compiler ordering.

See qspinlock_types.h and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 40 +++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..447334730122 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -106,9 +106,19 @@ startup_continue:
 	 * We lock 'num_kernel_image_mappings' consequetive entries.
 	 */
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* Get onto temporary stack which will be in the locked
 	 * kernel image.
@@ -212,7 +222,13 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +342,19 @@ after_lock_tlb:
 	wrpr		%g0, 0, %wstate
 
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* As a hack, put &init_thread_union into %g6.
 	 * prom_world() loads from here to restore the %asi
@@ -389,7 +415,13 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/*
+	 * Retain explicit assembly release ordering; C unlock relies on TSO.
+	 * The predicted branch protects Spitfire erratum 51.
+	 */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
-- 
2.43.0

