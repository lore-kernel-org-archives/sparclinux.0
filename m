Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5B301031;
	Fri, 15 Aug 2025 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254519; cv=none; b=clh20uSxMZVIfp/ozsys2tiL6jTK4Nvy4e3O67IhGvntffZ4DUQuun9J3Cw8J06Gp9624crPBnDndYVhfSx6058M1xcsXYToxq2tggsPtsSiLiTYb5ALdQP38yvPRUjW9ZllsKlSwi7YjEuwoCiN0b7GjVuX4Xyv4U1vgOb3GKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254519; c=relaxed/simple;
	bh=Ngyyb+Tb2Eq2g4xCY2ap8PjPAMUoe2Wil/Ab9l88uDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FEk0Ajsz/V81NsCgK76gs1g7dza3dJx6zJTABHtCWgrHgpygOZPz3Y7xQxsjY1Ae2JSgJJBuNx8hgHjWT4cHkvJ20pWKzjHyTPGeOae7i3lPTmqRyXQagVX6hP1KaIrfzCRAPMHHESUR0TO40BqMmptcIN56UAlSl577ajPqsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srwTCiqh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NdXnOEW9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srwTCiqh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NdXnOEW9"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDoH1wg/PXmaaRjwmjbwG1Ox0g1S4AGQYYgSu/bm36Q=;
	b=srwTCiqhy2js5exRe7LeLCcdYss9U3z6/DyxiVfmvLmIe2Pz8heXuFeWGqFuW0jkSIPQ4+
	gaduylLBJmTzTsvembDuVrEhwWgr34jGzcTnqzgS8pViBD41Rx6/9EaIYwLc2wmlECBUFd
	z34f+qAtDo8sEcyn7uJ8L95J4NuiEji5RXrc/8rvmN/yDjgXpb1WQHggmsdef+rWgggFY0
	/KWuLtBdwW1MxLeCxlCoeLis03tFnD09281lRNUIOcqr0/XCQY3769FbnM3ottuFSDFtn2
	7q6LHx6V18lVuhi+uZ0Z97LK+JITTAhqxX9f89jxVjj1Cgj3XH+Ac/POSh0VvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDoH1wg/PXmaaRjwmjbwG1Ox0g1S4AGQYYgSu/bm36Q=;
	b=NdXnOEW9mLnXJNdBQnJZkohhilbLDwmWs4xZ0asWmsCn4iAmVQWvZpn0WE2MYLffBup6TJ
	NjCMxE7vGnCachBw==
Date: Fri, 15 Aug 2025 12:41:21 +0200
Subject: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
In-Reply-To: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=4460;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Ngyyb+Tb2Eq2g4xCY2ap8PjPAMUoe2Wil/Ab9l88uDQ=;
 b=HdfQWWGnq8Yziooivb0IMMoSlqXmE7pUHH9zen2Q6AjqygKPsqZn0JMjJOjAoyw0CvnMqzmAk
 BxV3bi9ouSBBcpPLGgCUc80y013FtfoxX9Zj6dEUAVsAuIqdb5um3WR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a vDSO fastpath for clock_getres().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/vdso/gettimeofday.h | 42 +++++++++++++++++++++++++++++-
 arch/sparc/vdso/vclock_gettime.c           | 16 ++++++++++++
 arch/sparc/vdso/vdso.lds.S                 |  2 ++
 arch/sparc/vdso/vdso32/vdso32.lds.S        |  2 ++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/asm/vdso/gettimeofday.h
index a35875fba45470ba961a7df3ae52bc17d2a4a4a0..ccd2bda0a0c42ec826eb0464b7a41f98b4cea993 100644
--- a/arch/sparc/include/asm/vdso/gettimeofday.h
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -16,6 +16,8 @@
 
 #include <linux/types.h>
 
+#define VDSO_HAS_CLOCK_GETRES		1
+
 #ifdef	CONFIG_SPARC64
 static __always_inline u64 vread_tick(void)
 {
@@ -125,7 +127,45 @@ long clock_gettime32_fallback(clockid_t clock, struct old_timespec32 *ts)
 			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
 	return o0;
 }
-#endif
+
+static __always_inline
+long clock_getres_fallback(clockid_t clock, struct __kernel_timespec *ts)
+{
+	register long num __asm__("g1") = __NR_clock_getres_time64;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
+static __always_inline
+long clock_getres32_fallback(clockid_t clock, struct old_timespec32 *ts)
+{
+	register long num __asm__("g1") = __NR_clock_getres;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+#else /* !CONFIG_SPARC64 */
+
+static __always_inline
+long clock_getres_fallback(clockid_t clock, struct __kernel_timespec *ts)
+{
+	register long num __asm__("g1") = __NR_clock_getres;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
+#endif /* CONFIG_SPARC64 */
 
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *tv, struct timezone *tz)
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 1d9859392e4cfd285349cf9155ca1fc25d3a7b41..3cadf94e6cee5392586755e97f629092d4bcab1e 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -38,6 +38,14 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 int clock_gettime(clockid_t, struct __kernel_timespec *)
 	__weak __alias(__vdso_clock_gettime);
 
+int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock, res);
+}
+
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_getres);
+
 #else
 
 int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
@@ -56,4 +64,12 @@ int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
 int clock_gettime64(clockid_t, struct __kernel_timespec *)
 	__weak __alias(__vdso_clock_gettime64);
 
+int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock, res);
+}
+
+int clock_getres(clockid_t, struct old_timespec32 *)
+	__weak __alias(__vdso_clock_getres);
+
 #endif
diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
index f3caa29a331c58175b67ea60d7ac15cd467fe5ff..67c64a3adfa94f61356ce11081df442c18d6d8d5 100644
--- a/arch/sparc/vdso/vdso.lds.S
+++ b/arch/sparc/vdso/vdso.lds.S
@@ -20,6 +20,8 @@ VERSION {
 		__vdso_clock_gettime;
 		gettimeofday;
 		__vdso_gettimeofday;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index a14e4f77e6f2222b855df27cc7a0d0a4f98bd4ac..d09b1893ee1411f450df935335e6fe8d8c8b2632 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -21,6 +21,8 @@ VERSION {
 		__vdso_clock_gettime64;
 		gettimeofday;
 		__vdso_gettimeofday;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }

-- 
2.50.1

