Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBF45DF47
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748673; cv=none; b=tMRqtipu6fFHdlI1QclTJWqYD1i4IomoEqf4pDiGerVNOia5lKRNgOt3Ul7TqDBLC5Q2/p4cBj/GfKcuWcRZlfYtXBd0CWBHDI//LWT/axDuSuFiZHJQ1QVIX4l/yJ+frmxYotEKDPy60YDRlXolllQYskQxu0U39CIeyhJiPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748673; c=relaxed/simple;
	bh=Nadl7HsFYXW6P9DTRKvVWpxRaLB4EMXS+QpbLsbVDjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfTxGEH0uQ0cMW74+HrQJ8VqupUzdKZcFPDK0ZTefQE0NHu9mSI8/mRc398bI2KsXnuxfiVKNKbbEsNJtTmnr7MhcNlZAcQuCfnySh5HjOWcBnuYoI2xrhP6esYJcRUfBJUnTQ52CG8NEPReWSNTfvamkmdGzAz2OydwECcNxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROms9/7j; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROms9/7j"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso1275336a12.0
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748670; x=1792353470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bd3F/qTb7l7go4vsYHnwO4e8nInvYSKDA0ySqIxH6Y0=;
        b=ROms9/7jMiTg+0GA5yfz0ljiBokccfUoeyAvsZ8NCtoJuaiZ0e8CY8kZqz3M4J7XVU
         SSvM7hhTuiE03VeEwjdnWUUEoncUTXlWGSNxH9ppoFDtS5B07xMCxB2nzxnaz8sDE3i0
         4WQtTymxISjjAuvhSThEqzhHvyugiLwxgBm+uOt792Fk1wHGY/EXqlFL6voaDwjmh0Dd
         ua5nLoSOHFdAmjkltTlc3BXZPZdLJPN9abIKunM8EuIFcH1pIFxmtDkw/4hRA+3Xylvh
         hw8AgRfv0wdYi2dWZ8JatEs4lDvDOYDBqYixAqY8Rnp0xaIHPa9RhkO+6+W7sZc9b2WD
         Arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748670; x=1792353470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bd3F/qTb7l7go4vsYHnwO4e8nInvYSKDA0ySqIxH6Y0=;
        b=hb9+xE/lPuN4/HoFuJLfMrACqREdffHsLiF/KY2vN4F6PF2A7mvCZHeTfLUc/i8h7b
         7oTJrOdSmJjQdx0COyZ0JEjuPikzdxN1wS0pH5dN3AlxnZFhTqg6TyQWhTEuBeahs7Bn
         Cr/jWvjHH4QGF+oPLNE4IBx3pD4kU8e+tyEZ0h4hm7ulYC/is6GOI8/rUOVhnklySXw9
         Z8UHC0n/m8hMqu7b1cyMcRgrS2ko8/EGksDKecR/lXn3iDJda/oKgKas/xkSZZ32s9kx
         5fN5u/TJNd6friaxwxFQiZ2vJltFh3BNBrL5FRfP7xT9kkE02v4mfQK7a8iObxCiT7CG
         zCfw==
X-Forwarded-Encrypted: i=1; AKwUvBxtO2Khw2Lt5xKSuBHnw8RLKg+YD8FCYPfBxnB93Ic8BGMdZCduCMbx843Yx2BSxzzhyPFIABSeygCy@vger.kernel.org
X-Gm-Message-State: AFq9FYLqvW2WJb5h0PZl14ZKwPnA8PEYfG0tA+eJ9sNZuU9VN8IebY3J
	/NZ0lfp1S9ySzWZhCSQ/qnNcHKKCybCIsXWYJWBi+8U8fOqL8jX6YfVq
X-Gm-Gg: AYBFou1TNeD1P3+bbSsTLYkg3ZQ2Oe+F2Ee3Mmz6mqMyZnAkY82XF12ytCQ4RJ21iVa
	ktdIOFPuB+Q55UgxtQ8hCouOoIwIyT/mSUHok/nb7603zseStrWNOyDKEE/dX73C44RUk7m4BMD
	0ESDXSpflF9z2zgZ+8/1jFVYRFqrB4Q1KYM8Q7U3UboU+q4WtoKUENCe9cWOpnkRrL00yPhBexn
	xyXdJPTwHe0EN2kLe5uRPBnsGbiT+3Yr7XMZ2t5PBlgEvJkjN3NrC/EKH4qTXt5Ie74P/TsSpHs
	wIgfk79YZC0T6zOJOHvAcNwDIW4qb2iH7ic9LgSwXp7vL5Rx+nsFfUM3c3PSlq29NabNtP3+5zY
	abBDf8sL9WOZ4H86JbG53m07TpQayPy0+LUdibRWoYzYHdianTAVD+7AevdmPypPmPYZ58uFqbc
	BSlKsPjZfvrUtXvkHzPdp6lRyc5Sl7gNqt+A/y4M/kbXJh/q2gvYuyOT2bgztStXhQMkTzz7ol2
	AoG1Mi1dyXQG96jgjeNMoXyklHXB6QiHbNM01ap
X-Received: by 2002:a17:907:9694:b0:c20:9447:bd5e with SMTP id a640c23a62f3a-c31a9fa1d3amr847020866b.9.1791748670007;
        Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
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
Subject: [PATCH v2 2/6] sparc64: honor queued spinlock layout in secondary startup
Date: Sun, 11 Oct 2026 21:55:54 +0200
Message-ID: <20261011195729.981243-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
not its locked byte, because SPARC64 uses big-endian queued spinlocks.
Acquire the word with CASA, release byte three and poll while contended.
Retain the predicted-branch barriers for Spitfire erratum 51.

See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..62f404b3079a 100644
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
@@ -212,7 +222,10 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +339,19 @@ after_lock_tlb:
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
@@ -389,7 +412,10 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
-- 
2.43.0

