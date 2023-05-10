Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C11FC77B7C
	for <sparclinux@archiver.kernel.org>; Wed, 10 May 2023 04:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjEJEn4 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 10 May 2023 00:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjEJEny (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 10 May 2023 00:43:54 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFD40CD
        for <sparclinux@vger.kernel.org>; Tue,  9 May 2023 21:43:51 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a00da4e53so120896357b3.0
        for <sparclinux@vger.kernel.org>; Tue, 09 May 2023 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683693831; x=1686285831;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgvg6hJeX3BMksFNsRntaPo5LAnqTckLGOVnbotKcuE=;
        b=XSdzuZPhWyo8ejurmvHVm33GJPjVUgijuALNChj5du7O2iYt4Q9Jq2Q59opuXgmszK
         vq4MYv/Ooq0tJSiRkeuI3pPx9DX2hUCIacbsKIYs/Pr4tOgH5bBu2nqMFCUfyb6E02pf
         jBk8Kt3LARkTDDVXin2DqNhLRNsinTPL45U22h6RflNgwq03hTBYZXyT9mTDfKsms4Zh
         4IIRYWo2iyv3RHOXtIB0KC/5A3EJw7nNYEHLsDPx36g0ObzRlzcFoxapfv0z0w7dMYbs
         CoJBrp445oAQqRN0sKHpj5OzjqC03ok8JMyhyd58GQQ6Bw92QvpdqQzmSHjTpSRLST1k
         j19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683693831; x=1686285831;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgvg6hJeX3BMksFNsRntaPo5LAnqTckLGOVnbotKcuE=;
        b=A9mUniKIYSXIm/tMK16YZOkId/2n6mMCejR/2VtdQEZeZwC74Bc0PzX8StQ0iWPuSj
         v7r3A8iRs+p/bRP8utZ54UitZgQPIAnlGsWhhbHCfIHtdKeKdJBTgbFXuD19DKzFRXTc
         TgHfVB/vlqjShjn3KSST0+C2BwDqUhhk3qDVr/XJNZkJ5C1EkZO51yvlzBt1/NeFsCW2
         uxolC+NpKyeD6dp/ia1SIFglgKBOvfwav2/6TsdRPydmbmmaFT7pDUpb0P4o3SRpy0G5
         FN38hwJ08zb0A/pTQVd4wdSVA8ZOtUPH9jan5+bJHe4yqxcjiY/l9rzCpaUrPiTtZveY
         kyLQ==
X-Gm-Message-State: AC+VfDxKsbSfKVmzw3m8t+7Fs6gJ5IIT6iOOeN/LRrC4npPSd9wmHsYd
        IoBsz6ueEalmMXM+1H9tUq0ERw==
X-Google-Smtp-Source: ACHHUZ4VcJ8uys5Wg+XhQi/AqGcqZN5zPbzkOujNssPmQqlmUArRuZ8YDG3LYugsQYwQAHxQcBQMpA==
X-Received: by 2002:a0d:d955:0:b0:55a:ad0a:766 with SMTP id b82-20020a0dd955000000b0055aad0a0766mr17833906ywe.10.1683693830970;
        Tue, 09 May 2023 21:43:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p185-20020a0dcdc2000000b0055a72f6a462sm2214413ywd.19.2023.05.09.21.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:43:50 -0700 (PDT)
Date:   Tue, 9 May 2023 21:43:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 02/23] arm64: allow pte_offset_map() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <e72f6f3e-a8d4-3ed-2b4-5d3ced41484@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9e0db5c387e3..a58780d5fac4 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -177,6 +177,9 @@ static void show_pte(unsigned long addr)
 			break;
 
 		ptep = pte_offset_map(pmdp, addr);
+		if (!ptep)
+			break;
+
 		pte = READ_ONCE(*ptep);
 		pr_cont(", pte=%016llx", pte_val(pte));
 		pte_unmap(ptep);
-- 
2.35.3

