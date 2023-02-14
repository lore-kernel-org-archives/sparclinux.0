Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040DDC64ED6
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 08:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBNIF6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 03:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjBNIFl (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 03:05:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7023305
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:05:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o36so10387845wms.1
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ct5xtrlPKjjQBQKaK50Nq6yDXnm+cC6tgPBoUaDGX0=;
        b=1xRasjafQOUXarQQWSF/7kHUt/+VaNN41JsvVie78fHCvnBtsCj6XLXrQlYRyk8SMa
         GUvcrv27BCA5nhu5rZ94G6eP2FCJVlbcxEW473/DE88fooxiWY9B3ounLWgrhC4c354l
         WCThvbDJj9wDfwDG0MFuPCBT5KS6UkeI42mD0IwkIqFFeSHi8NMzagvzhfMT0/BwgnWP
         h8Hb9DgJ/7Q+wtMt+d0JNEWdyH5Eaer5oW2YbMyEVxGNa5XMlrHPlxrCXibcUIedhoSo
         MSEeANfbCIS64jx01S1TkpGuf4oDZKB8Ll/vCgOr+9ec/Px4ccZvgwXFQD+nV5t3n5cg
         9NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ct5xtrlPKjjQBQKaK50Nq6yDXnm+cC6tgPBoUaDGX0=;
        b=hc9hb+px2mp+pGXzxKqYRwpCu4nGZS4x7xLthvRhqSlXVs66R4SoUcq9ohWNL2MCNS
         Jr1wd1RjEoxBuGLEDPX+6Em6Vv1ccyyS7VEbEi/82btUG5Au6qw9sulYcfOioF8A37fC
         cRPyXcPnAnDtL1oOf93eb0NF/CvixJPacC5kFlEg9EjPhx0s4HcFMKIdQSY7rHnLaU4A
         NtAwkBR+wr7j+ejVJASM3Y3qoVpraDqfwsrEcDO9lMcdLkl8CgERoZMaCXuylrFMyKxt
         Grt4muFJKXHbbdKrmm5A9OhtoyGK7sAV9f7RQvDKHiofLVv2AleOUJcLPrQQYZ6qEcqm
         AkSA==
X-Gm-Message-State: AO0yUKUJdADCTfsSoac15tXolr0wPWmj9DY8Mg2L/fBUeKzqJkoS//S/
        PwDj7ROFMJHu9S4cN1wKX6F8gw==
X-Google-Smtp-Source: AK7set+BLoUtubkaXYrAKpwb/kFTGI2YrmVGXgoEUrVzZbAjF6WRjdC9KQBLGH8OODS4OAEhnIqBZQ==
X-Received: by 2002:a05:600c:18a3:b0:3de:e8c5:d826 with SMTP id x35-20020a05600c18a300b003dee8c5d826mr1140255wmp.28.1676361924127;
        Tue, 14 Feb 2023 00:05:24 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d534f000000b002c55306f6edsm6381370wrv.54.2023.02.14.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:05:23 -0800 (PST)
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
Subject: [PATCH v3 15/24] m68k: Remove empty <uapi/asm/setup.h>
Date:   Tue, 14 Feb 2023 08:49:16 +0100
Message-Id: <20230214074925.228106-16-alexghiti@rivosinc.com>
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
 arch/m68k/include/uapi/asm/setup.h | 15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/setup.h

diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/asm/setup.h
deleted file mode 100644
index 005593acc7d8..000000000000
--- a/arch/m68k/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
-** asm/setup.h -- Definition of the Linux/m68k setup information
-**
-** Copyright 1992 by Greg Harp
-**
-** This file is subject to the terms and conditions of the GNU General Public
-** License.  See the file COPYING in the main directory of this archive
-** for more details.
-*/
-
-#ifndef _UAPI_M68K_SETUP_H
-#define _UAPI_M68K_SETUP_H
-
-#endif /* _UAPI_M68K_SETUP_H */
-- 
2.37.2

