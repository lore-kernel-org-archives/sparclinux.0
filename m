Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36FC64ED8
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 08:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjBNILl (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 03:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjBNILj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 03:11:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064922DE3
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:11:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso5521008wmo.3
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvpaBOHRxynQVN76sYSm78ChjX1znmriOrQIpZIS+4U=;
        b=5NlXgVjhh9vbvViub6LhSOmr8tVa6IBVEyF0zRfB83IByLzArwAM+0qw+VxsNI/v3O
         9OWtZbrdL8JfvpiE3iq+Owwbn7WHXgFSoaFB0e4OactZe5gsW9qsGGDTPeYgJylr7/3s
         3F4MpYflrtieowDacsXG30s/rLOj/tHYjrMAdlnpeXOJLEslGasAHVP98/8wE2cbZHi+
         DtJVObK2BvR1NA+BCeSfpJ7/0/Xqxv3cM7UfBXMSNhytYiWpfcvUEjSNTOi8cKTr/Na1
         dTCAdzJ5u+E++JxwEI0i4jgV9lz/WMEz6jZfUqV1tX/DrncLas0AKVlLr+8/5kI49TKM
         W/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvpaBOHRxynQVN76sYSm78ChjX1znmriOrQIpZIS+4U=;
        b=cJW4k31Gx0QN5de+OpItKCNKtHPU6fSl8CbdKH/lzcX+dCyPkwIq0cqVZMRjoaVpxB
         5ckxy9W4Bb/lWXj9MwNx+DGPYIbAvfqC42tx/n12r6Tjkx4hV29AaVK6ZP2Fr8YrGiCq
         n97mmBBXgVGx6arBiS/Qv76BnIzMhgmIoiet115YDK+PWisNBBhLCTaZLBzAZffqEaSr
         SvFOj8uYftKXcFniATi8ScBlIOPwdz5dzU7Ng66Gl4nia8fj6hC0ol1n4WqwBd2mlF2m
         d/V3wnrWtiHP3iwOi+0iU/9Czt3sQvPD4kC21C5NQQWLQ0VThyv8S7MMjPSV/xzVPT3J
         +zFw==
X-Gm-Message-State: AO0yUKVnNxBULvFUeo3016ZKMiDAW/Vn6AqcDUYUWn990D8GPMm9RH95
        7pbT8ttuMDJ0DxwpACYUCIgJlQ==
X-Google-Smtp-Source: AK7set/6ZO0GzOxTpCDrsVlt02f4BgyGKOm1zeoaq0l7Vu0+xmZuXJDnZSoDV/hFx/zxMjZLosjRIw==
X-Received: by 2002:a05:600c:994:b0:3dc:5937:35a2 with SMTP id w20-20020a05600c099400b003dc593735a2mr1855049wmp.9.1676362294487;
        Tue, 14 Feb 2023 00:11:34 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c459200b003db03725e86sm18173022wmo.8.2023.02.14.00.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:11:34 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 21/24] xtensa: Remove empty <uapi/asm/setup.h>
Date:   Tue, 14 Feb 2023 08:49:22 +0100
Message-Id: <20230214074925.228106-22-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230214074925.228106-1-alexghiti@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/xtensa/include/uapi/asm/setup.h | 15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 arch/xtensa/include/uapi/asm/setup.h

diff --git a/arch/xtensa/include/uapi/asm/setup.h b/arch/xtensa/include/uapi/asm/setup.h
deleted file mode 100644
index 6f982394684a..000000000000
--- a/arch/xtensa/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * include/asm-xtensa/setup.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_SETUP_H
-#define _XTENSA_SETUP_H
-
-#endif
-- 
2.37.2

