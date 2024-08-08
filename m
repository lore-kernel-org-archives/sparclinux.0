Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E4A23;
	Thu,  8 Aug 2024 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082702; cv=none; b=SZFCvd70XMON6STGcab+OYNVWtHbMfXguvl/mKAn44xtrP4bSgNh3KkAWxvWMIQ6j642BGLK+HKXjRkW4V2BrVWp+2OH9JjKXFA8+7oKCSyjSU5p6eedTkDhb5ORuZtpT2+o9osbn9rvQJQ8QRcFh4Y38vtBG/psC9hgqG8ma5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082702; c=relaxed/simple;
	bh=2EcT3zPydLdHe4h+d6LItih1FkoUOBaRXJ1Xwae7odY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zcy0a5SWWqdJCc61Y/8JAPzGsZWLIj0cjGE1klU9mZnSM0Xc4IA6TMgT44HJCIaBv1WjfwWDnL7QBp5VoRBEBf7Mzvh+hr++LdzciOwFML2X6ELFrV97YxcGZhSKMSkPCdrKsAq2gKASmIKGYZAp4tvfGeovoTnsnWqruLXtkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnfKY1B2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnfKY1B2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E7C5C32781;
	Thu,  8 Aug 2024 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723082701;
	bh=2EcT3zPydLdHe4h+d6LItih1FkoUOBaRXJ1Xwae7odY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MnfKY1B2ugtjj0Ah/aw35kKJY+FvKHU9WcoIangAwcExW5aK5Jorg3pVqxnI4yioC
	 8HhofzvQDyiQPI3ssLvHDn4EuMTrqoG/JOu3UyZ682j2p+v9WKJrsOyDPiXdHaAJ61
	 7/NYlWxweE2V3fUfJNdTJdVQg6dOmEfp1kcmxtZVktF+5XsHriLcWu8w7uFTJNq71h
	 BLI13zvbrWVxrs+cI30SxoCCgQU5ge8fm6ASclzcOtZ6u89OGG+4wJF7Rop9VuFhG6
	 2kna466QI6d/+Xk8LRCX85nedp6HHdBSc8gwIwQot6jK4321joN+Qn8MQ95VX6arFW
	 mhCqgDWEKjZhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3AC52D6F;
	Thu,  8 Aug 2024 02:05:01 +0000 (UTC)
From: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>
Date: Thu, 08 Aug 2024 09:05:00 +0700
Subject: [PATCH v2] sparc/vdso: Add helper function for 64-bit right shift
 on 32-bit target
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-sparc-shr64-v2-1-fd18f1b2cea9@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAMsntGYC/1XMQQ6CMBCF4auQWVszLYUWV97DsGhqkUmEkikhG
 tK7W3Hl8n/J+3ZIgSkkuFQ7cNgoUZxLqFMFfnTzIwi6lwaFSqORRqTFsRdp5FYLNSA6Y602BqE
 8Fg4DvQ7t1pceKa2R3we+ye/6cyzqP2eTQgrVYINda+u6c9eF4xrnydHz7OMEfc75A6nfi5OrA
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723082700; l=3512;
 i=koachan@protonmail.com; s=20240620; h=from:subject:message-id;
 bh=Si3c44/d6jXgPlqHAyYiaOjLlLDe1/nmaPBaKpcPsPo=;
 b=kN78zuvs/mL6hPLposgcU9M29S3E9kBq3BS+8FzltzlrdxSTJDNeaDNDLou81Sqo6m93sqG47
 MEVfcgCRTcJAQlIIHmzdXbKSV8zMnEkOycj+RuqbwOfStGRK4FjLCgw
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
Changes in v2:
- Move __shr64 to sparc code since there are no other users of it.
- Now that __shr64 is not in portable code, redo it in inline asm for simpler implementation & better performance.
- Link to v1: https://lore.kernel.org/r/20240804-sparc-shr64-v1-1-25050968339a@protonmail.com
---
 arch/sparc/vdso/vclock_gettime.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index e794edde6755..79607804ea1b 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -86,6 +86,11 @@ notrace static long vdso_fallback_gettimeofday(struct __kernel_old_timeval *tv,
 }
 
 #ifdef	CONFIG_SPARC64
+notrace static __always_inline u64 __shr64(u64 val, int amt)
+{
+	return val >> amt;
+}
+
 notrace static __always_inline u64 vread_tick(void)
 {
 	u64	ret;
@@ -102,6 +107,21 @@ notrace static __always_inline u64 vread_tick_stick(void)
 	return ret;
 }
 #else
+notrace static __always_inline u64 __shr64(u64 val, int amt)
+{
+	u64 ret;
+
+	__asm__ __volatile__("sllx %H1, 32, %%g1\n\t"
+			     "srl %L1, 0, %L1\n\t"
+			     "or %%g1, %L1, %%g1\n\t"
+			     "srlx %%g1, %2, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=r" (ret)
+			     : "r" (val), "r" (amt)
+			     : "g1");
+	return ret;
+}
+
 notrace static __always_inline u64 vread_tick(void)
 {
 	register unsigned long long ret asm("o4");
@@ -154,7 +174,7 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 		ts->tv_sec = vvar->wall_time_sec;
 		ns = vvar->wall_time_snsec;
 		ns += vgetsns(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -174,7 +194,7 @@ notrace static __always_inline int do_realtime_stick(struct vvar_data *vvar,
 		ts->tv_sec = vvar->wall_time_sec;
 		ns = vvar->wall_time_snsec;
 		ns += vgetsns_stick(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -194,7 +214,7 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 		ts->tv_sec = vvar->monotonic_time_sec;
 		ns = vvar->monotonic_time_snsec;
 		ns += vgetsns(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -214,7 +234,7 @@ notrace static __always_inline int do_monotonic_stick(struct vvar_data *vvar,
 		ts->tv_sec = vvar->monotonic_time_sec;
 		ns = vvar->monotonic_time_snsec;
 		ns += vgetsns_stick(vvar);
-		ns >>= vvar->clock.shift;
+		ns = __shr64(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);

---
base-commit: defaf1a2113a22b00dfa1abc0fd2014820eaf065
change-id: 20240717-sparc-shr64-2f00a7884770

Best regards,
-- 
Koakuma <koachan@protonmail.com>


