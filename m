Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003935;
	b=VFzCjtI0AHUBFFjW0HZZOyrAM4fVdhQllAmvxryuGi6974Go7oynb5/RGY3/fSUX19Iu
	 mLIi12zL+uVpTXHszVk/KOoi2txdyv1OuSjnktUdzku/TByaJ0F12DvRXYtWVBjDFw38C
	 OIJ2O1K9+h59qrb65xaDEhc1+DhBG7SAv7h3P3gC6skvrOKUlMn/TK6t7XOkv7a8CDrz8
	 KsYstJhaQIF6RlFu1gkVwVhA6DrCGbbHBp2/6aZYDw2CPG6F8MYVbrEAz/dG7q7wlv1p/
	 Rcndgd/HxO+FgknzU8w2SD1Ve+HtavUxTsPHMPOXdoKk54bEvLmmeGY4EbzT3sSMXNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+MsbjmZXyQIGIrMSZDLm0szNexGnhEGpcLnezb5K85A=;
	b=O0u8t3kPTtY1v7kNCuB7ElmrZD6RgDhKE13nrps927xjKvzmq2nc3ilmU2e+YaU3oecq
	 WToxnAfDVg8zBEaeSZmQ56/umaPg4x83/ek+v4M8xolf84aYUlbs7V5kkqWg086FEzNgM
	 hDahGmyKQlecteDQpRjYcvDx3BQ/H88kogMoZLyST58lWGlfCljAA52hVf6g/ZXAAb09a
	 k3J2w1o3M+D0pomQMA6fhgYeyLhZp2mRlJjJPbzeTpHGE3Jc98uiJff4heGkkfULscuQx
	 iZQpUbEf5z2IkktiO2hLVDci0U0UIpH4gFfZ1+VAArMHFVcCgDY27ymSSB13pPNBcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gBpdk1S6;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44181606A320
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 08:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44181606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gBpdk1S6
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c45551fa84eso396173066b.3
        for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003934; x=1793608734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MsbjmZXyQIGIrMSZDLm0szNexGnhEGpcLnezb5K85A=;
        b=gBpdk1S6DRVeuljO+Stc1a2ikSJw13AEqo9tYqvDT/LkyFs1i+CQJsKk2w2Cc75aex
         3TLHt+aC3mlD5r0S4UP+7jv6CsSo8AVrAjFS4XZnG2d9lJJZF1qw5Cax2PnLcGP+TBys
         Om3WkPcl4r5gadbR23eeWSivdSHpB3wQooIk3EFWqjWX8O6L+kXvW5csbYqTxkSf/qHn
         PaCESo6On67Gjeklhp+jOMq5S2ppGo11ZhUA7hSDDp3IcO6njPNDPxlyEG8bz3tVvT5R
         kvoexajBLBOLqif5O9P+vFrCqst9g6dLzIjaAaBhGDHcI3Bv0YSgGhzujnspGQNQaAbx
         Ms9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003934; x=1793608734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MsbjmZXyQIGIrMSZDLm0szNexGnhEGpcLnezb5K85A=;
        b=Gw1KkNL2K1Il3SfQcuQaS4Ti5oXFZBlEFC70zzFjeVq3oNLZt8BkwhAUexAij/f53k
         q/4rWannLKchN4DDLSg9irBjnap3kzm+nvPse4mwImiyDqnHArHBpaMHdLdt6D92BSpT
         C1hV09AHaDIgxFzZKy1dTFnYXwHaMSwTawH0KvAy/Wp85pVaEpk58pVWfN7aVeqL7qe9
         wexzvTN2vk/x3jXiQXR0eDAbIYIUBBmx9SW5Xu5vyzQRVHBQxrCPAPrTg3W3rPEsjh0B
         6SQ1wMjoSFlzR1sPKyYXXa+LsnzbWWT1yk2hXpeQvJ5Ank97bUvWZ62M2EnQlfkvIr2T
         s9zA==
X-Gm-Message-State: AFq9FYLD/G+enpK4bOH/7mxRr8bd29ekZgP03og5/SCAcsjv3mXRvPUI
	e3HPu+S+4jB8v89M5Gua4CQaS/ygLiu8g5F2oi6KYA4XCFNjZ/JnlbVmKdlkwezm
X-Gm-Gg: AYBFou23KMyyWxrjTWnRgt6L+1yP1LiwgmuEw6edwEi3SKuYOrdXlKXKPmqeJ8MFEdw
	8IbkirPwYm2DzHVBCfqtKsLWKr20z9RKR/Ee3EF/+0nGU2HxS+sH8B36E69cR3cBnDza2wp3+dB
	MjGHQIUhnrDHhzmBUq5/CAug6oCvkjhJwZtqyai6RpqKjCUEkw7iLJGlCjz5EpH1NRwVp0AFSlY
	zoHfk60rScMDIT2WT4hjPWlPiCDh7S7dSLuOrkCAxo/O0fdRR6s360woyGBnTjG3UOO640vtF+S
	p93B7xv4j3+3UTOLkecwg72aL5bTHWROqvmn0UbmYaRvG+B42sbOJXHdXYObAYMvBtW01NvPJnO
	z77Z4mzhZhemsj8Z2Y+izspiiP6h1iSW1TaOE0zpCGGVRDFESgqd1z3X0WDhUryTp8KWEAJP46T
	hU3bFww44t4V6Xx2K/fYs45lIUDvNvSeoKinq4WvM8bh/U4fqaJiiAOOEn1Inxm6rBj3+Ru+ybx
	gDssUTBQQBwkVYKWIUK0NF5iw16474J/i4z0ULXxLihjcKNV2C+3Fli4A5zNAWrP5sV0ofs1OnJ
	7nx/6Z3mMJRGgk3DMqXK6Q==
X-Received: by 2002:a17:907:9611:b0:c46:2a05:b257 with SMTP id a640c23a62f3a-c46bdc0f3b4mr739291766b.23.1793003933589;
        Mon, 26 Oct 2026 01:38:53 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46c59c063csm249655166b.34.2026.10.26.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:38:53 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/1] sparc32: do not write back unchanged values in emulated atomics
Date: Mon, 26 Oct 2026 09:36:56 +0100
Message-ID: <20261026083837.1055953-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026083837.1055953-1-linmag7@gmail.com>
References: <20261026083837.1055953-1-linmag7@gmail.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed bit-lock acquisition can restore an unlinked hlist_bl head and
leave pathname lookup retrying a dead dentry indefinitely. The owner
updates the pointer bits with a plain store while holding the bit lock.
SPARC32's hashed atomic lock does not exclude that store: an unconditional
fetch-or can write back a stale pointer even when the lock bit was set.

Skip unchanged stores in the emulated atomic fetch operations and legacy
set/clear bit helpers. This covers current test_and_set_bit()-based locks
and older generic bit-lock implementations. Keep the hash lock and IRQ
exclusion on every path, preserving ordering, return values and
changed-value updates.

This fixes the bit-lock owner/waiter protocol, not arbitrary races between
plain stores and changed-value emulated atomic operations.

Fixes: 26333576fd0d ("bitops: introduce lock ops")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
Validation: forced-interleaving host regression; SMP/UP builds and QEMU
smoke boots. A native GDB 18.1 build also passed on dual-CPU HyperSPARC
as part of the combined integration; see the cover letter for scope.

 arch/sparc/lib/atomic32.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 8ae880ebf07a..30b4e0c12c07 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -28,15 +28,19 @@ static DEFINE_SPINLOCK(dummy);
 
 #endif /* SMP */
 
+/* Failed bit-lock acquisition must not overwrite an owner's plain store. */
 #define ATOMIC_FETCH_OP(op, c_op)					\
 int arch_atomic_fetch_##op(int i, atomic_t *v)				\
 {									\
-	int ret;							\
+	int ret, new;							\
 	unsigned long flags;						\
 	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
 									\
-	ret = v->counter;						\
-	v->counter c_op i;						\
+	ret = READ_ONCE(v->counter);					\
+	new = ret;							\
+	new c_op i;							\
+	if (new != ret)							\
+		WRITE_ONCE(v->counter, new);				\
 									\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
@@ -125,8 +129,9 @@ unsigned long sp32___set_bit(unsigned long *addr, unsigned long mask)
 	unsigned long old, flags;
 
 	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
-	old = *addr;
-	*addr = old | mask;
+	old = READ_ONCE(*addr);
+	if (!(old & mask))
+		WRITE_ONCE(*addr, old | mask);
 	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
 
 	return old & mask;
@@ -138,8 +143,9 @@ unsigned long sp32___clear_bit(unsigned long *addr, unsigned long mask)
 	unsigned long old, flags;
 
 	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
-	old = *addr;
-	*addr = old & ~mask;
+	old = READ_ONCE(*addr);
+	if (old & mask)
+		WRITE_ONCE(*addr, old & ~mask);
 	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
 
 	return old & mask;
-- 
2.43.0

