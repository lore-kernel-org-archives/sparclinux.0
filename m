Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AFB1E49F;
	Tue,  9 Dec 2025 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765256619; cv=none; b=pTN1icwm0O+3J1jZ40FXAbMolwNZtlODiDobDIjgM5NbbeFhjIrUmp30nlIhTOa44iZfcBcXc6IM+thO8oi55Y4+QhKY9lIt1vBAYiPg7cIdp8014wXsI1mQgOL9t2cWfDZ5VPP0QyQjB6QLXEyiFlnnkGtWCzS28OQ37ED6C6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765256619; c=relaxed/simple;
	bh=0+GA1cRnNAJc78pUN75444gW3RaeI1k+dDWM0FyTSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1mgEjUKH9XSXwtqhghyhhtUw6kZCiwtgDYYe5gvKZOv9kXsrqvEULqw4HYD+6wTsb/9EeOvIT6OaW5LPT8wxdU5ueWeNpbpKN0gHG/vPsr5u4b9DzW1jx2osucsWv6hyaI4xHuB3uRuRV+4GpZW71C/FAXvNZQrbOqTDhv87SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WqALmlCP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WqALmlCP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mj+SnfzBIiBDaWi/pdexuvICTBtqP6QbVHcggxF0hPs=; b=WqALmlCPtANRWS8tywiMRYCIej
	TAjOl8Vw+vOADyaDMzw1JdIHrEbsn8v9S8zFQzQlKWaX2SURzoYVA32phTH/I2F7N8rVqFOEGv5Ad
	FjcqcYYXgn26cZBYjhAejJla3b0r4IP3k6NzIH1eEST5mUGbpijDanGav42HGmJwO833w9pO6i1Lt
	zwv2UARihsCqAreHUpvYrwFDcTmzPVAiC792HP7T5/CAMx23nYTzTb2h/MK3zYHOnry86MamZjetO
	8d1HUEta8PE/40wLq2AYn6Tk/nJ18YcIk88OABZcvkFK2ZenP6DLaBAkOadUO7yqgnlfttSQ+bNNQ
	WA5Ma3Uw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSpss-0000000DpKL-3yny;
	Tue, 09 Dec 2025 05:03:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Subject: [PATCH] sparc/vdso: add missing prototypes
Date: Mon,  8 Dec 2025 21:03:32 -0800
Message-ID: <20251209050332.881348-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On sparc64, when CONFIG_WERROR=y, there are a few missing-prototype
build errors. Fix them.

Add the 4 missing prototypes to <asm/vdso.h> and include that header
file in vclock_gettime.c.

Fixes these build errors:
In file included from ../arch/sparc/vdso/vdso32/vclock_gettime.c:22:
../arch/sparc/vdso/vdso32/../vclock_gettime.c:274:1: error: no previous
 prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
../arch/sparc/vdso/vdso32/../vclock_gettime.c:302:1: error: no previous
 prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]
../arch/sparc/vdso/vdso32/../vclock_gettime.c:327:1: error: no previous
 prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
../arch/sparc/vdso/vdso32/../vclock_gettime.c:363:1: error: no previous
 prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/vdso.h    |   11 +++++++++++
 arch/sparc/vdso/vclock_gettime.c |    1 +
 2 files changed, 12 insertions(+)

--- linux-next-20251205.orig/arch/sparc/vdso/vclock_gettime.c
+++ linux-next-20251205/arch/sparc/vdso/vclock_gettime.c
@@ -19,6 +19,7 @@
 #include <asm/unistd.h>
 #include <asm/timex.h>
 #include <asm/clocksource.h>
+#include <asm/vdso.h>
 #include <asm/vvar.h>
 
 #ifdef	CONFIG_SPARC64
--- linux-next-20251205.orig/arch/sparc/include/asm/vdso.h
+++ linux-next-20251205/arch/sparc/include/asm/vdso.h
@@ -19,4 +19,15 @@ extern const struct vdso_image vdso_imag
 extern const struct vdso_image vdso_image_32_builtin;
 #endif
 
+struct __kernel_old_timespec;
+struct timezone;
+notrace int
+__vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
+notrace int
+__vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts);
+notrace int
+__vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+notrace int
+__vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz);
+
 #endif /* _ASM_SPARC_VDSO_H */
