Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0B3DE447
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177500; cv=none; b=E9rjA34FCOzHt6AcVR+wfVGr4QJpIsGG2YFikBCTP175YXEDOkBXYzwhc4ObVwLH42fEwRff9aWmXLdm4Yp7iSD0Z8g0U9ymjq/yfOrO6kJolbYTotecoViyfhBVXAhdTRUrPYNPuYQbd1MAlui7hu4RkBDChdejqHDdMjtIO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177500; c=relaxed/simple;
	bh=qSmvIDluYHg5lZ1R/2z3mlCH889NGwaa3iiw3jrqOUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWBa1RyYsVEM9H9K7UY2GCX/Mp7XtoT0D2u0cB4lLx6D74AcE9X0G2vpcKqZSu0dgzMFHGDRMyaKAWpY/B0+Q6/gdsoMaye5OXAbBcp91psfJqh1BL3Tc0UnnGUGmq78O64UMY1jbyVDcmu86beJ+2lIdwixqAViPLFzwoE80rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc9Ol6H/; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc9Ol6H/"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-130c9dcbd25so2667409c88.1
        for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177497; x=1779782297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLE/5Z5x2pvR1MzqaWWc0fqhrvQQle2p46SKkWlKzS8=;
        b=Kc9Ol6H/rJcTKszCiylagHAZsnUbnG4/hHrkbS2mYmbuMaB9/I6v3rOtwgpOJbYWip
         33q3wYY4RDcOKvpYzmiCSs60djnfB9wFqTUsg426VRrLAOWcH6CF+9x5TFSbkkHorzVC
         VxmfDFaa9leuYBzPF2DdqxaZ3vJ0IFhIUgpRc2l8Gp1Lk9CUiPRWo47szq8XrgusiKdx
         9AB1hZV7TkdCD1uDMuTbQqAqQN+qUB6nG5LBMwcM1A5qKn5/hpDI84TRz2zHayaQLkxd
         DKNtCzc3jIe583ZapFP4mhf7Ctzu1R/MJa4AMSHVAgcI+V+z6y22xIcYOrHgkX7FAJF5
         iEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177498; x=1779782298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLE/5Z5x2pvR1MzqaWWc0fqhrvQQle2p46SKkWlKzS8=;
        b=o7YRy3J7kwWITJe0/6szPkCtV0opK6+xigqvP9sNUd3g7xjWOqM4GjC/51Qr7qftGp
         xM+bNcxjqsjvjYoU6gppgKlOJgNMDtMWPVkUdGJzO4Y1hCP1biE9SJfEPGSqIk8Q1ke1
         sxIuPUvhSo40RDSUpudBHk0CYxZOmY0dnKCaWT4S4+U6Hwl5byKc0cfcptLkaUcTOt3Z
         7DMygggSBDshZ/EvBTedwRdvQn8uIqic7gqHNrx/LvfAdaU3gjkLSW2WRpgZ1UmQME8M
         xhx+aG0DojC28BVS3kwODZaCpJdgmUIt68r8kIGmbVy0DZ7kE8O4T9wF2o1WEwxspOKi
         Olgg==
X-Forwarded-Encrypted: i=1; AFNElJ8pPzlNdCwEkQDk/x+YB9E600N4EfKhSVvZA1z4757txSuj01u6+btd9OTQY11xHJtfcg4Bw4qa4/kt@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLkjCdPDGIHCetwlJdIWV8URHGRsDeVEVGmfeZE/yEGwpqkk5
	PMHT0V7B1xmbKZ295iTOk2X6KsqsItPyY3yHVyanR+cjHWwfytAJXGkR
X-Gm-Gg: Acq92OEDALPYmgVjIeDoo/Mz80fZP9x+9UoZIECCyE6RofdxE3xJA0pObVN8hb7PFHb
	TzOtVJF0aPsc7UlQtgfUUKGcVraP8SWjUmaZacQTPXBvKlVWoIIPm4pjzBoKPd452CeyOCusK/P
	NIdt9W/ovsH87JfI1RY9M0AeSLgY56wXubsebAAOFzo70OjHsHX90UulEXAlJJtNx5mUam24A4a
	JKhUHvuvxcbLaOEwgpzoXJWfG6A7C3ZSpT4ly3JuKy9iTEdEdIdKD4BYodgr7sHvNfPZcahJ6t4
	+jGFJ+GckKzvVGEYQc46CD74mdfU4Og4ZKkCsdznXf/OeaQEgnsdIwYR07pewBbqSJraKyFCUea
	dHVCcubzHqJyFwdbQnwzidttmzpMILwA6JaPlE5ax4rivgiY316qU4AJaWnMFjGxBPdcEd4jqD4
	eFl9Igl2OrbmLKBG82oJHwDzpOHCPiTO1ch0DB
X-Received: by 2002:a05:7022:fe06:b0:12d:de3e:86b0 with SMTP id a92af1059eb24-135000a5aa0mr7277303c88.19.1779177497495;
        Tue, 19 May 2026 00:58:17 -0700 (PDT)
Received: from s7t7-debian-test.local ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cf44668asm18768901c88.6.2026.05.19.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:58:17 -0700 (PDT)
From: Tony Rodriguez <unixpro1970@gmail.com>
To: davem@davemloft.net,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andreas@gaisler.com,
	thuth@redhat.com,
	regressions@lists.linux.dev,
	glaubitz@physik.fu-berlin.de,
	unixpro1970@gmail.com
Subject: [PATCH 1/1] sparc64: unify thread stack sizing and add explicit 32KB stack
Date: Tue, 19 May 2026 00:57:55 -0700
Message-ID: <20260519075809.8993-2-unixpro1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519075809.8993-1-unixpro1970@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch restructures the thread‑stack sizing logic into a single
if / elif / else chain and introduces an explicit 32KB kernel stack
for SPARC64. The previous implementation relied on nested conditionals
and PAGE_SHIFT‑dependent behavior, which produced 8KB or 16KB stacks
depending on configuration. SPARC64 requires a larger,
architecture‑specific stack due to its trapframe size, register‑window
behavior, and deeper call paths.

A reproducible failure case occurs when usbcore is enabled: USB hub
enumeration (usb_new_device(), hub_port_connect(), PM/QoS helpers)
allocates large on‑stack structures and recurses through several
layers of device‑model code. Combined with SPARC64’s trapframe and
register‑window overhead, this reliably exhausts a 16KB stack and
results in early‑boot panics.  A 32KB stack eliminates these failures.

The new logic is:
    SPARC64:
        THREAD_SIZE = 4 * PAGE_SIZE (32KB)
        THREAD_SHIFT = PAGE_SHIFT + 2 (log₂(32KB))
        THREAD_SIZE_ORDER = 2 (4 contiguous pages)
    Non‑SPARC64 with PAGE_SHIFT == 13:
        Retains the existing 16KB stack behavior
    Fallback:
        Retains the existing 8KB stack behavior

Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
---
 arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index c8a73dff27f8..6b12a2b66385 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -99,13 +99,20 @@ struct thread_info {
 #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
 #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */

-#if PAGE_SHIFT == 13
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define THREAD_SHIFT (PAGE_SHIFT + 1)
-#else /* PAGE_SHIFT == 13 */
-#define THREAD_SIZE PAGE_SIZE
-#define THREAD_SHIFT PAGE_SHIFT
-#endif /* PAGE_SHIFT == 13 */
+/* thread information allocation */
+#ifdef CONFIG_SPARC64
+	#define THREAD_SIZE (4 * PAGE_SIZE)
+	#define THREAD_SHIFT (PAGE_SHIFT + 2)
+	#define THREAD_SIZE_ORDER 2
+#elif PAGE_SHIFT == 13
+	#define THREAD_SIZE (2 * PAGE_SIZE)
+	#define THREAD_SHIFT (PAGE_SHIFT + 1)
+	#define THREAD_SIZE_ORDER 1
+#else
+	#define THREAD_SIZE PAGE_SIZE
+	#define THREAD_SHIFT PAGE_SHIFT
+	#define THREAD_SIZE_ORDER 0
+#endif

 /*
  * macros/functions for gaining access to the thread information structure
@@ -127,13 +134,6 @@ register struct thread_info *current_thread_info_reg asm("g6");
 extern struct thread_info *current_thread_info(void);
 #endif

-/* thread information allocation */
-#if PAGE_SHIFT == 13
-#define THREAD_SIZE_ORDER	1
-#else /* PAGE_SHIFT == 13 */
-#define THREAD_SIZE_ORDER	0
-#endif /* PAGE_SHIFT == 13 */
-
 #define __thread_flag_byte_ptr(ti)	\
 	((unsigned char *)(&((ti)->flags)))
 #define __cur_thread_flag_byte_ptr	__thread_flag_byte_ptr(current_thread_info())
--
2.53.0

