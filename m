Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACBC6FD1E
	for <sparclinux@archiver.kernel.org>; Mon,  6 Mar 2023 10:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCFKR7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjCFKRo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 6 Mar 2023 05:17:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CE625BB8
        for <sparclinux@vger.kernel.org>; Mon,  6 Mar 2023 02:17:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v16so8263637wrn.0
        for <sparclinux@vger.kernel.org>; Mon, 06 Mar 2023 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678097823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DzeLm98x2KlxW+99+p+QT5JJuywxTn9f4r8Pp0eFvI=;
        b=4cSW/LQ5s9Et6MID8LgfRx1uyewkB5JqgFPfFl7Op/JLO/S2L3Mkfcb+VkGrqRkrlV
         ipMmbloNieFRtHwlqLJ4wEgJ+DHEUg+f4rZlaQ825a2jPl5kuFx9bdykF8SeFf1dBXyj
         jFU2ntNuLC74CPhN41uv3CYij8LjnMFic4arj03r9hBLrJ4kqJP3sCkOjMj+lilz1UPA
         8oi/ajLkTvRxJSWP+dhqRh7nnLh0Vn1CDDbc4Ctnz8zButcnXL33rNCZbDBae8zlOcw9
         cVDxTwvnfbc6IeX0EDHwG19xMT2lIFgQO1B5c6hbn8cuKzRWV0IVtY5rqz7wIcIT2M+u
         GR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DzeLm98x2KlxW+99+p+QT5JJuywxTn9f4r8Pp0eFvI=;
        b=2LmyE0B6DP4b2wm8vcK0+HxovZ4UpU75vas8fo+oTO7/NdAnTnECRWaFDizki/j7P8
         OiKuqbmRSW113OXKDcW5Rt9W4Q622aYvujOczDWi3uFaE8JjKiuIJXiJC1EvWKs99XdZ
         I02Nc+13qbPymbuOrXa2MnUOzPCxHH3LrvS/TA2ZUcqHvIj/xE6Y3rDZJ6NjqsHxYtpY
         ssHevSyLqfn0NAAc2IikwnSpB0ZqIaSEaJwzDrQk6WPrzHXMLZzDkgPT663FKFCY5rhv
         K9CJT053rRHVLlCixvhnak3M28Ikob9gjHcKe0tobf8SsFvc1/lEOoeLR6I0/CaWfsIV
         +EBA==
X-Gm-Message-State: AO0yUKWJMaMupztCB7EwPthbDzCoDXQO4Fcyz4cjzlpUrzHPUYN+ZSd7
        YNUPNHrv5bqA4/9UI9WFMX5ASg==
X-Google-Smtp-Source: AK7set87MHg0/YFlXuaC+GjFPo/tzKFyPd2BNWIQb0qhZu4XveM0MX+k2JiDtlPsTxXRUM06ojldcg==
X-Received: by 2002:adf:f151:0:b0:2c5:617a:5023 with SMTP id y17-20020adff151000000b002c5617a5023mr6281664wro.71.1678097822928;
        Mon, 06 Mar 2023 02:17:02 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d61c9000000b002c54911f50bsm9443931wrv.84.2023.03.06.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:17:02 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 11/26] xtensa: Remove COMMAND_LINE_SIZE from uapi
Date:   Mon,  6 Mar 2023 11:04:53 +0100
Message-Id: <20230306100508.1171812-12-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/setup.h      | 17 +++++++++++++++++
 arch/xtensa/include/uapi/asm/setup.h |  2 --
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 arch/xtensa/include/asm/setup.h

diff --git a/arch/xtensa/include/asm/setup.h b/arch/xtensa/include/asm/setup.h
new file mode 100644
index 000000000000..0fc3ad86e0a5
--- /dev/null
+++ b/arch/xtensa/include/asm/setup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * include/asm-xtensa/setup.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 - 2005 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_SETUP_H
+#define _XTENSA_SETUP_H
+
+#define COMMAND_LINE_SIZE	256
+
+#endif
diff --git a/arch/xtensa/include/uapi/asm/setup.h b/arch/xtensa/include/uapi/asm/setup.h
index 5356a5fd4d17..6f982394684a 100644
--- a/arch/xtensa/include/uapi/asm/setup.h
+++ b/arch/xtensa/include/uapi/asm/setup.h
@@ -12,6 +12,4 @@
 #ifndef _XTENSA_SETUP_H
 #define _XTENSA_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 #endif
-- 
2.37.2

