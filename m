Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B53B05B1
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194766; cv=none; b=Dp+TMNIVjJ3ggzbL9CwxQNC/QZSy7CizMgRDQeDifJEqIByzjh9Z17SfdFSwsgNJWYZKG5dDC7yKVI5RXtxbCSCTUDwBJ4F/vrRuoqhuK+67ByptyUtNgKtEjtTP6QQAnSt94zcysuAleje6xUirkqWAPDMyLY5yeGiC2Y2Z/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194766; c=relaxed/simple;
	bh=U5kUJj8tfW2V7b3/nuO6sQr9QzMENF2JMUJE8N1DAT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC981s4JVUu1O3gu0lMSMIYEMz9rejgQUItGuW3KRtmNqgTufKVEuUnPuCs7aPjBOweqIwkGdKXy804Yz/oMR2gWUbf/w9VciwtN9rcM10nch/zaFV+LX10iVWQBG9YtArGQ6avx2vVEF/rZVQJI8i/TYt5uvaYFMiZVzJOZnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8kuizLQ; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8kuizLQ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso237418966b.1
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194760; x=1790799560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBkTioHa1njfgepZWcJOCl/N0/x0qKl0Yu1MlhUgAqw=;
        b=C8kuizLQC8LCFKyWH7dW5kw8KLBQb5SSI0MEX8MNeeytGa8CpsoaPVJ+MSNFnBDfUV
         CPRjiyhiK1OzZr3W0aTd/ZXtalDeCVtyR/T3M0pywi6QEJvPWsV4GVh+aYmXP1CZ2XDM
         5ErssEnjlRN77I8EZCrLs9ZfMDLwTjSr3U7XZyAYlg592cvQ5U4hdklEqvywbsOOFMF6
         BjPHllK2+M5kA7A4SGcr9AvLH50F/e86W11Wf0yQxZ/ZCQGqNZvWUClaZ/Y+Vu3YKkOY
         jpw6kcITjuo2RkGkQRzYdRniePG2Hvi7errGaD4t2/Z2UYHcmsTEd+QY+77VcHFlW/I2
         V4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194760; x=1790799560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBkTioHa1njfgepZWcJOCl/N0/x0qKl0Yu1MlhUgAqw=;
        b=FqWjJ77J89iUv2P3SaelfHYUCMv1cLETOSOSPHicALfKmovMuhwHIrtYYnOrRLkpRo
         tCKnN2BRpebTb8ib5vjb8iUqfM6R8L3nDCZsaggoLYhFydl+WJEdvRDeu3Arf1vgwX4O
         o3ScEtZCCKKwuqN194oi+uvDQfI7MOqwHOcQkZgxkoBRXg6fQhKRsVDSxkUVrF7rz8gf
         aFTvfEUh8Oh4/dgdVWzjuuAkRTZ4TeroYbocNXTFEmjdxENTKMxwj2cVq3HQD3h3Pqx7
         cS8iKBEvl38RILVrf2M7FPwtFtCBE0rCtRZv3lmXJWgxf/P+OYT0T0rUH/xt72xN36x2
         0xgQ==
X-Forwarded-Encrypted: i=1; AKwUvByMVwo+tMdiVbQ1CXy+WGXUDTnelQXt64wXfJJut+wIgOpwdDlyThFX5QNbe/SHeIeMrkeDKKDHq3q8@vger.kernel.org
X-Gm-Message-State: AFuF++l4jYPRRTQSkSUdmlvKewhMjN42iLMKwNu+NDGcvThEEs4TmOBh
	fI7svLwlGW+PF3yn0X1PdjO57Dsdze2lAH2/7yhvauecA0DEpVtQcVjJ
X-Gm-Gg: AYBFou1ke0VpOrdZhJ1IcLhKOitQlU5OGXF89N2Z9cPTl477DDIQ6T0Og6Gu/rrwDzj
	slR+tznZhH8iIBGCCZClMmTLVpY2VmCbo5sStba3i4OkT3SuWLBQ+m0d1Ot7RptlYWXqv40VgtR
	d0yBo+ixbhoaQXTWBuqKOT7u1zW7PHxRU6VFcbu5wq29CU8eM/bcTz0kFugWN/Cz4/frUnLwBnf
	fDjMTdPV2iL7svk2sRFzRIOkZ6JA6UZ+i1f6utV6F0CwEd+Gn5f/oIGineg6qk8k8UvFIJ/GEuP
	aXPwAvLyozZzKLPh8YjNrtBeCPk67XbPq8xpx+GTavVS4R/XDudFDBhSy+CTMPXpm3OZxwqI7uo
	pmrn8VqMs8hlGuWK9KgRshQCjH1LRmQCaUr4f6Ofr914H5RspNB3lr/brVl9ITr4h5ENKOqujzM
	ZflyVYfweSK2HnNiKGqKu9ouVjXux3GKr2iRSxrY0h3bpwWGQGo/9GqkS/+Xh8uzH32hu656Stk
	0B5c4+C6Wmv/flOoHuycS8jxVFxyypZZeApAdGA
X-Received: by 2002:a17:907:c48a:b0:c29:f5d5:5a9a with SMTP id a640c23a62f3a-c2ac241cb87mr18810766b.36.1790194760417;
        Wed, 23 Sep 2026 13:19:20 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae63dc17sm183626966b.33.2026.09.23.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:19:20 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [RFC PATCH 3/5] sparc32: implement futex atomic ops with the compare-and-swap locks
Date: Wed, 23 Sep 2026 22:17:19 +0200
Message-ID: <20260923201830.865553-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923201830.865553-1-linmag7@gmail.com>
References: <20260923201830.865553-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparc32 had no futex implementation of its own and fell back to the
asm-generic one, which on SMP cannot work: it needs to update a user word
atomically, and pre-v9 sparc has no instruction for that. CONFIG_FUTEX
was therefore made to depend on !(SPARC32 && SMP).

Now that the kernel owns a compare-and-swap on behalf of userspace, the
futex code can use the same mechanism. Where the cpu lacks the
instruction both sides serialise on the lock array used by the trap type
0x91 handler; both callers go through sparc32_atomic_lock(), so the two
hashes cannot drift apart, parisc keeps the same invariant with a comment
asking that its futex hash match its LWS code.

Where the cpu has the instruction that lock cannot serve for the
read-modify-write. A binary built for such a cpu does its own casa and
knows nothing about the array, so a lock, get_user, put_user, unlock
sequence can lose that binary's update between the two accesses while both
operations appear to have succeeded and FUTEX_WAKE_OP defines its update
of uaddr2 as atomic. arch_futex_atomic_op_inuser() therefore retries a
casa until the word is still the one the new value was computed from, the
way sparc64 does it. Only the pre-v9 path takes the lock, where it is
correct because userspace takes the same lock through the trap.

Both entry points are called with page faults already disabled, so the
user accesses fail rather than sleeping under the lock.

With a real cmpxchg available the Kconfig dependency can go, which is what
lets FUTEX_PI and robust futexes be built for this configuration rather
than refused. Their runtime behaviour here has not been tested.

One gap is known and not closed here.

futex_robust_unlock() clears the futex word with
unsafe_atomic_store_release_user(), before the hash bucket is locked and
without going through either helper added here. SPARC32 currently uses
the generic implementation of unsafe_atomic_store_release_user(), which
ultimately performs a plain user-memory store. On a no-CASA SMP system
that store does not acquire the lock used by the SPARC32 software-CAS
implementation. It can therefore occur between the trap handler's load
and conditional store, allowing the CAS to overwrite the unlock:

  cpu 0, trap compare-and-swap        cpu 1, robust unlock

  take sparc32_atomic_lock(uaddr)
  read *uaddr -> T
                                      store 0 -> *uaddr, no lock
  compare against T succeeds
  store T | FUTEX_WAITERS -> *uaddr
  release the lock, report success

Neither order of those two operations permits that result, so the missing
serialisation is what produced it. The flag itself is not gated
CONFIG_FUTEX_ROBUST_UNLOCK covers only the rseq fixup path, so dropping
the Kconfig dependency is what exposes this on SPARC32 SMP. It has not
been observed in practice; it is reported because it follows from the
implementation.

The requirement is only that these two operations agree on how they
serialise access to the word. The macro is overridable, so SPARC32 could
supply its own definition and keep this inside the architecture; whether
that is preferable to a futex-specific interface is a question for the
futex maintainers, and is asked rather than guessed at.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/futex_32.h | 137 +++++++++++++++++++++++++++++-
 init/Kconfig                      |   1 -
 2 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/futex_32.h b/arch/sparc/include/asm/futex_32.h
index 6a332a9f099c..35ff08a6b2bd 100644
--- a/arch/sparc/include/asm/futex_32.h
+++ b/arch/sparc/include/asm/futex_32.h
@@ -1,6 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#include <asm-generic/futex.h>
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <asm/errno.h>
+#include <asm/cas_32.h>
+#include <asm/cpu_type.h>
 
-#endif
+/* These share the compare-and-swap trap's lock array and must hash
+ * identically to it; see asm/cas_32.h.
+ */
+
+static inline int sparc32_futex_op(int op, int oparg, u32 oldval, u32 *newval)
+{
+	switch (op) {
+	case FUTEX_OP_SET:
+		*newval = oparg;
+		break;
+	case FUTEX_OP_ADD:
+		*newval = oldval + oparg;
+		break;
+	case FUTEX_OP_OR:
+		*newval = oldval | oparg;
+		break;
+	case FUTEX_OP_ANDN:
+		*newval = oldval & ~oparg;
+		break;
+	case FUTEX_OP_XOR:
+		*newval = oldval ^ oparg;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+{
+	raw_spinlock_t *lock;
+	unsigned long flags;
+	u32 oldval, newval, prev;
+	int ret = 0;
+
+	if (sparc32_has_casa) {
+		if (!access_ok(uaddr, sizeof(u32)))
+			return -EFAULT;
+
+		if (unlikely(get_user(oldval, uaddr) != 0))
+			return -EFAULT;
+
+		/* Retry until the word still holds what newval was computed
+		 * from, making the read-modify-write one atomic step.
+		 */
+		for (;;) {
+			ret = sparc32_futex_op(op, oparg, oldval, &newval);
+			if (ret)
+				return ret;
+
+			if (unlikely(__sparc32_casa_user(uaddr, oldval,
+							 newval, &prev) != 0))
+				return -EFAULT;
+
+			if (likely(prev == oldval))
+				break;
+
+			oldval = prev;
+		}
+
+		*oval = oldval;
+		return 0;
+	}
+
+	lock = sparc32_atomic_lock(uaddr);
+	raw_spin_lock_irqsave(lock, flags);
+
+	if (unlikely(get_user(oldval, uaddr) != 0)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = sparc32_futex_op(op, oparg, oldval, &newval);
+	if (ret)
+		goto out;
+
+	if (unlikely(put_user(newval, uaddr) != 0))
+		ret = -EFAULT;
+
+out:
+	raw_spin_unlock_irqrestore(lock, flags);
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	raw_spinlock_t *lock;
+	unsigned long flags;
+	u32 val;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	/* casa is atomic against userspace's own; a lock of ours is not. */
+	if (sparc32_has_casa) {
+		if (__sparc32_casa_user(uaddr, oldval, newval, &val))
+			return -EFAULT;
+		*uval = val;
+		return 0;
+	}
+
+	lock = sparc32_atomic_lock(uaddr);
+	raw_spin_lock_irqsave(lock, flags);
+
+	if (unlikely(get_user(val, uaddr) != 0)) {
+		raw_spin_unlock_irqrestore(lock, flags);
+		return -EFAULT;
+	}
+
+	if (val == oldval && unlikely(put_user(newval, uaddr) != 0)) {
+		raw_spin_unlock_irqrestore(lock, flags);
+		return -EFAULT;
+	}
+
+	raw_spin_unlock_irqrestore(lock, flags);
+
+	*uval = val;
+	return 0;
+}
+
+#endif /* _ASM_FUTEX_H */
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..9eb8086af7db 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1875,7 +1875,6 @@ config BASE_SMALL
 
 config FUTEX
 	bool "Enable futex support" if EXPERT
-	depends on !(SPARC32 && SMP)
 	default y
 	imply RT_MUTEXES
 	help
-- 
2.43.0

