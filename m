Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312A3BBDE
	for <sparclinux@vger.kernel.org>; Wed, 17 Jul 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253749; cv=none; b=hAUDd555eZINI2cWm7BO71/M0L2Bqb6ZDquqiwsqJGITahm8E+TbLf75th3TDU33g0bYx7m3z7358TbjifwcU9n2B7ML6AygQyrW/ERfnKvGZFuTWNYpgqr4av05bopfF96FDhoaOgFzj/JRYFvMszwbBgjeusU1iqEPiDdVqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253749; c=relaxed/simple;
	bh=NcfwDzo/WAY/ja+2Q9yeFepQLgCd/NmFOsGANafDbuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Gk1okmsNDc+JFSoFS5Kl8ts8gxdWuhcasJ2cpxJ+vNpVM5oxiGulD5wx2qyz2Wg5TaFYLElV4HqaX41BTsDTI5+W/5Fc3TIZ0WUShOZLIPD4CdZId5ycgGYwNRbwgznYMho19Btyf3ZWWYbf+TaYDEKub7VTKNXX/MINkCx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJnOSk2K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJnOSk2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721253746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jtsZY5Ha1GOE7eeXCKiwGrLCKWt0M5FAlFhM8vgy8I=;
	b=aJnOSk2Ky+um/JOkse7yFgUDt26Oaxp0bqlarkmpBInI8g5MweTXUEstB1UaDmW2eQ5ps0
	1FzcZdjFNCLUKeHRs4AdS9I95caRBtkfNUPGH+nBXoZgXXVjfj8BsFmFzn3UEyDUFhcsmu
	/RqAwUbILNNLPjCZEOfb2tSrNJrBQqo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-ulscw_6oPWuilEswxoHngQ-1; Wed, 17 Jul 2024 18:02:25 -0400
X-MC-Unique: ulscw_6oPWuilEswxoHngQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44aeacbf2baso259141cf.2
        for <sparclinux@vger.kernel.org>; Wed, 17 Jul 2024 15:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253744; x=1721858544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jtsZY5Ha1GOE7eeXCKiwGrLCKWt0M5FAlFhM8vgy8I=;
        b=l/5iq8LOTxFgJ8FrbRaynmSB0Ho6SujpsBhLRk0xH8R/QmPRU/6BFT5tCZUPc7ABjv
         lcdvR73gdo1DLFNktKKbCekhT3uPUrDZapys/QmLCo8s0t5hjwq9/ycfH5Y0FUB3PZOg
         e2+hs4lqmpA5iz0S6bVPgnm1gvEnkJAL/y5qL7KMeYiBPdq0tkCti0RLN4WYd0XjKzCY
         aIdm5b8vqjVPII6E3d8UaWclMS1MrMcJnEl1wJsclDWHLxmY+ppx0yXgaPzSwLfBwu9u
         RqGvrlHGcmyTjy8QFS8hD8/RjFe1Q23QfptqVwxaGcOMxYE0UgAwvDEC/9jxIBqhMAZL
         8yzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkrcythtBCVyI+8Ja8AhGH8LxVoJx9zQIZBP7V/riWXtk995LPgfrw5CJ8OlRMLHcb8ULZZv5op+z2Kz3fK8Z55/jCXUQEQO42Uw==
X-Gm-Message-State: AOJu0Yz9ohb0x+BcQHDrzQVnOPz7xGECB+eaBnr6PAdj0upOAGVwfL0c
	b/3ipZvtVpSNQleYmiclHIsYCzEjBQbi68UoATATK23DuhMGzmDo2X7OPaNB6TSaMfn6xD+UWuO
	GkJMnpVY0Q6B6xCbaYRDaY39+L7gvhM5vHCR60qNcJ/2x3Z/GnibA3HJNH8Y=
X-Received: by 2002:a05:622a:19a8:b0:446:5a29:c501 with SMTP id d75a77b69052e-44f864afa6cmr22369431cf.1.1721253744673;
        Wed, 17 Jul 2024 15:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUvRqkcMnpaLn941R1BXuIssxTrm35f8/3mo50id9Lq3VPmnZD9wDrl4u3hs2U9BoucnNtpA==
X-Received: by 2002:a05:622a:19a8:b0:446:5a29:c501 with SMTP id d75a77b69052e-44f864afa6cmr22369171cf.1.1721253744329;
        Wed, 17 Jul 2024 15:02:24 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83f632sm53071651cf.85.2024.07.17.15.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:02:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-s390@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH RFC 1/6] mm/treewide: Remove pgd_devmap()
Date: Wed, 17 Jul 2024 18:02:14 -0400
Message-ID: <20240717220219.3743374-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240717220219.3743374-1-peterx@redhat.com>
References: <20240717220219.3743374-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's always 0 for all archs, and there's no sign to even support p4d entry
in the near future.  Remove it until it's needed for real.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h             | 5 -----
 arch/powerpc/include/asm/book3s/64/pgtable.h | 5 -----
 arch/x86/include/asm/pgtable.h               | 5 -----
 include/linux/pgtable.h                      | 4 ----
 mm/gup.c                                     | 2 --
 5 files changed, 21 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..5d5d1b18b837 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1119,11 +1119,6 @@ static inline int pud_devmap(pud_t pud)
 {
 	return 0;
 }
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 5da92ba68a45..051b1b6d729c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1431,11 +1431,6 @@ static inline int pud_devmap(pud_t pud)
 {
 	return pte_devmap(pud_pte(pud));
 }
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 701593c53f3b..0d234f48ceeb 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -311,11 +311,6 @@ static inline int pud_devmap(pud_t pud)
 	return 0;
 }
 #endif
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2289e9f7aa1b..0a904300ac90 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1626,10 +1626,6 @@ static inline int pud_devmap(pud_t pud)
 {
 	return 0;
 }
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
diff --git a/mm/gup.c b/mm/gup.c
index 54d0dc3831fb..b023bcd38235 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3149,8 +3149,6 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	BUILD_BUG_ON(pgd_devmap(orig));
-
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
-- 
2.45.0

