Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94546C48BD1
	for <sparclinux@archiver.kernel.org>; Fri, 11 Jun 2021 18:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4B613D3
	for <sparclinux@archiver.kernel.org>; Fri, 11 Jun 2021 18:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhFKSGg (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:06:36 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39562 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhFKSGX (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 11 Jun 2021 14:06:23 -0400
Received: by mail-wr1-f46.google.com with SMTP id l2so6980812wrw.6
        for <sparclinux@vger.kernel.org>; Fri, 11 Jun 2021 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv1oOT7C4SvfVScA5OsmG0Bg/0buHsM+uDbdtIhh8hg=;
        b=TfjPUHiiIaTiInxzuqqFvMKVKQMum8fo+r0CFrnXATaosLR7VuHv9ihm4u+mXuKLb4
         LLbSFpuw8J4in/6tDmsMdYbje8pMu2cLz9GQoz76/cZo74fvYlXywk0CUbG+ppHk+TA1
         dxNnWpLnMSUbsPhLpcd2zTbdRpbwZaw0va5mC74l/8kMEk3nqqDH5tGzlkcsd//XkkkD
         URX8zN02sAPbC159BcujK5K/dbRHY3g9PFJhh37093WeK52tiYD1tYDgxbDFjjgjKW0o
         VpEal+ayUyLh3HotgJuwYFwbkAkZHqWsEHZge5uQjJC8FvS8DNZWANKVQ8IM8NiRU92B
         6lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv1oOT7C4SvfVScA5OsmG0Bg/0buHsM+uDbdtIhh8hg=;
        b=j7d7w+UVHo66Zl77gTeIwihNB+7uHSajHMzLhp68phJzCfjTvTtpHwcY2dM+MLz/Up
         cP//L+6fUbKur+bkBY6whcx8kicHTKKhQPPzOQU9gm1VF/RESFbnutYCOpstkWN7bL5g
         3Oef9g+4Usyn7fx1Av+JhIr1O3wRHBAMnWMUtM2pypxaXAOyx7vAEdmOccScB7ViQozd
         GfV8PoC3tiHEgpuFhSQRItY8eQ0BePPu/zHTpNVAV1w7O70Vj1ayiiub5fViSFmMfr93
         ZH4pqaWGhcCu5pN/0lAwLhclvYUktOraJwoZJ+F4ESJ3stJFbl8O+ungjtgiFzG5UjNW
         fNRw==
X-Gm-Message-State: AOAM533BM9arXsHk8bejOD3Yx27+KjzsRb/YD5HUCHAKfSRcBDeRABtv
        cCKkUFpPtKn+6l9xVVg++wzERw==
X-Google-Smtp-Source: ABdhPJwt5OAuskYJjJE8BX+VI3KPYNJUqpfn+N/q6xU8DoEe3ZlGotdtl6C7C6eegqTsHUuUSBSuQA==
X-Received: by 2002:adf:f985:: with SMTP id f5mr1224955wrr.201.1623434588299;
        Fri, 11 Jun 2021 11:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v3 12/23] sparc/vdso: Remove vdso pointer from mm->context
Date:   Fri, 11 Jun 2021 19:02:31 +0100
Message-Id: <20210611180242.711399-13-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Not used any more: now sysinfo_ehdr is passed back from
arch_setup_additional_pages() to set AT_SYSINFO_EHDR tag.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sparc/include/asm/mmu_64.h | 1 -
 arch/sparc/vdso/vma.c           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 7e2704c770e9..8e7892890d14 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -111,7 +111,6 @@ typedef struct {
 	unsigned long		thp_pte_count;
 	struct tsb_config	tsb_block[MM_NUM_TSBS];
 	struct hv_tsb_descr	tsb_descr[MM_NUM_TSBS];
-	void			*vdso;
 	bool			adi;
 	tag_storage_desc_t	*tag_store;
 	spinlock_t		tag_lock;
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index ae635893f9b3..94a43e01d2ac 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -414,7 +414,6 @@ static int map_vdso(const struct vdso_image *image,
 		ret = PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
 	} else {
-		current->mm->context.vdso = (void __user *)text_start;
 		*sysinfo_ehdr = text_start;
 	}
 
-- 
2.31.1

