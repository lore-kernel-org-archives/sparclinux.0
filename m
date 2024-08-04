Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40562F2E;
	Sun,  4 Aug 2024 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722742845; cv=none; b=OZoNkNr0iqVLSIBS2EDRdwF9lLzlSyxxs7rfgTrAZnlhx4UPVSfhAJAWWRJv2klsToePv4StQX04q0oJsQ7QTNURZxBhjiLxeHH91QiG3OjT6EOLxzEtj5WN1gdIzmGkLz/my5q8TOH4L/0W/aVQgq089TunMDblUUF2NpWUI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722742845; c=relaxed/simple;
	bh=tTsJlsqt9PgjobXbGaWgUj5lIlY9CiKIWXIQpxm4yR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ixsIXO7lT2XbwAl1nJZejK5VnkEwipkg9kNtlODpBgq3WNPQdjTDMTYsffHIhnUDPwbGwPm4A9A2BtXl63odf53GHd33preIccckSGcHCnY9F0v1PEZ64AWKFKJF9GZ9oMP7796duELEPnMqqYz9z39r6NI1Z0OCujDNnje9EQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAj7dy//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAj7dy//"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 822E6C32786;
	Sun,  4 Aug 2024 03:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722742844;
	bh=tTsJlsqt9PgjobXbGaWgUj5lIlY9CiKIWXIQpxm4yR8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iAj7dy//39uhNuW1ig3EEYyw5ji+po4WcI0mqcoWKEFq/0ItPjOKSiZ6FFmaGg+JU
	 bxDfZxcbp+7IIhBWzLUqDx6Aol+eozg8TEuHCzuIPAdBH2WTBBuDfwNxCcU4d26V/P
	 v7ERjDKk4jVQB54KRwlzhhy/roGFE3kz7lz2fgg83cgPUnNpdcNRI653g4lNwf7AsC
	 L/QCkc4UORv3VIVVftQEJ4BO9hljiRe/+FF8aKJc0ldGWVznIQ/gALTC75EyjY7PFp
	 c6jQs/5zlqWoBOcHjMdrkiMCXS7skFnEUsiracWQuLnnuV2KKNoxXKFRJKWiQhniat
	 e3xc2FLHIIiYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F373C3DA7F;
	Sun,  4 Aug 2024 03:40:44 +0000 (UTC)
From: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>
Date: Sun, 04 Aug 2024 10:39:49 +0700
Subject: [PATCH] sparc/vdso: Add helper function for 64-bit right shift on
 32-bit target
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-sparc-shr64-v1-1-25050968339a@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAT4rmYC/x3MMQqAMAxA0atIZgtpKUa8ijgUjZpFSwIilN7d4
 viG/wsYq7DB1BVQfsTkvhp838F6putgJ1szBAwRyZOznHR1duoQXdgRE41jJEJoRVbe5f1v81L
 rB4OsFpBdAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Koakuma <koachan@protonmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722742843; l=3316;
 i=koachan@protonmail.com; s=20240620; h=from:subject:message-id;
 bh=5vLiK7ELLqD1RRIEMvqkT4bYtvygqFoGLfpouZxp/Ns=;
 b=VGHa0DUmTa67NoKaZwaMHf2po7TjbodTym97uTjAmdtk/iY/OmPZTEI5cVbFiZWWBQBEJKWku
 Jhid1FM83fRAZ8JbZbH+jGYt7MRV1DsT9z8K7DrQRITNzWjcW7eIzDb
X-Developer-Key: i=koachan@protonmail.com; a=ed25519;
 pk=UA59FS3yiAA1cnAAUZ1rehTmr6skh95PgkNRBLcoKCg=
X-Endpoint-Received: by B4 Relay for koachan@protonmail.com/20240620 with
 auth_id=174
X-Original-From: Koakuma <koachan@protonmail.com>
Reply-To: koachan@protonmail.com

From: Koakuma <koachan@protonmail.com>

Add helper function for 64-bit right shift on 32-bit target so that
clang does not emit a runtime library call.

Signed-off-by: Koakuma <koachan@protonmail.com>
---
Hi~

This adds a small function to do 64-bit right shifts for use in vDSO
code, needed so that clang does not emit a call to runtime library.
---
 arch/sparc/vdso/vclock_gettime.c |  8 ++++----
 include/vdso/math64.h            | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index e794edde6755..c0251a632bdb 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -154,7 +154,7 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 		ts->tv_sec = vvar->wall_time_sec;
 		ns = vvar->wall_time_snsec;
 		ns += vgetsns(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -174,7 +174,7 @@ notrace static __always_inline int do_realtime_stick(struct vvar_data *vvar,
 		ts->tv_sec = vvar->wall_time_sec;
 		ns = vvar->wall_time_snsec;
 		ns += vgetsns_stick(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -194,7 +194,7 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 		ts->tv_sec = vvar->monotonic_time_sec;
 		ns = vvar->monotonic_time_snsec;
 		ns += vgetsns(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -214,7 +214,7 @@ notrace static __always_inline int do_monotonic_stick(struct vvar_data *vvar,
 		ts->tv_sec = vvar->monotonic_time_sec;
 		ns = vvar->monotonic_time_snsec;
 		ns += vgetsns_stick(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
diff --git a/include/vdso/math64.h b/include/vdso/math64.h
index 22ae212f8b28..771d84faa8d7 100644
--- a/include/vdso/math64.h
+++ b/include/vdso/math64.h
@@ -21,6 +21,34 @@ __iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 	return ret;
 }
 
+#if BITS_PER_LONG == 32
+/* This is to prevent the compiler from emitting a call to __lshrdi3. */
+static __always_inline u64
+__shr64(u64 val, int amt)
+{
+	u32 mask = (1U << amt) - 1;
+	u32 lo = val;
+	u32 hi = val >> 32;
+	u32 mi;
+
+	if (amt >= 32)
+		return hi >> (amt - 32);
+
+
+	mi = (hi & mask) << (32 - amt);
+	hi >>= amt;
+	lo = (lo >> amt) | mi;
+
+	return ((u64) hi) << 32 | lo;
+}
+#else
+static __always_inline u64
+__shr64(u64 val, int amt)
+{
+	return val >> amt;
+}
+#endif /* BITS_PER_LONG == 32 */
+
 #if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
 
 #ifndef mul_u64_u32_add_u64_shr

---
base-commit: defaf1a2113a22b00dfa1abc0fd2014820eaf065
change-id: 20240717-sparc-shr64-2f00a7884770

Best regards,
-- 
Koakuma <koachan@protonmail.com>


