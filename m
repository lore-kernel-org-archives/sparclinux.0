Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5156440
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366448; cv=none; b=m69i0wsyWPXLnuuO548gLSzIm2FA8IXR8x0Vd+wbhixnKg2E0mgUhPNNcscvo0iM2LJ8SwQEkG762xfWbDkGmapd+y1kjzIfSEDVyZnpcN7Ube+YPD/z/8ITzLq+jacnjrzOO5UE0Jibpd55MdnjmK+Kr06NpEyZ4ufGvtxOt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366448; c=relaxed/simple;
	bh=0Lswo5GE77ATHQ8L+dlMWa1yM2evkibSoyq3AnC70nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQCjabtMzsRtSMqXaLwXjAaRb+9lBNcI1XeM9AmaHsLudE82lzV8BpFFcR2s09VZawPTyK/oph4gGICO1UBupKClAJKcUoLEqt92eGriew3RXItbt/osSMConl000qTL9YtDafrELAI7wjzWgsYGWUjDllCm18hU758JgxoqHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqNvRhhE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqNvRhhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8evz9V3UX8qsNtRrNT6H/1m1GM34KP8FDwkI2vjQ2A=;
	b=fqNvRhhErD7r4aqpHDkLwaMtGa2Y+PGhRbj7cxmqWyP5AaL0cnZ3v6xyAVUxZec+OOCRbS
	tEG7pM1v6TStprIv5bcwOLL4jbqilmmWPXhQ1MZbbJ/TU1D9IXmyf7eEwqlYrX3ZWo+Jeb
	VT6FtXhUNgalPxnZt8aYCCZkvS1dNXE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-uIkWHXfUPiiSVDO7dUlYEw-1; Wed, 13 Mar 2024 17:47:24 -0400
X-MC-Unique: uIkWHXfUPiiSVDO7dUlYEw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69120b349c9so1131476d6.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366443; x=1710971243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8evz9V3UX8qsNtRrNT6H/1m1GM34KP8FDwkI2vjQ2A=;
        b=vi18g/KbKKQY6cv1wg/tRQQkg6kcdIDoi2N7/ccCn5F/GOePKe0624QH5NqfLFoTC5
         QyHB6l3KEkGYnVt9+fZSGMvTsDQ3CCXgVpNJW7JxJXptewvRQLJpm3t5tepH7omPWU1s
         e6arZIqy4UXrInzb2z9aC9Y5VAVpHBmyaC6UT2FNOkPxp388xkEWvPBm3/vewf0x49BY
         QUbPMRnx4CeQYxGk5qPd13AsN1pR3aF59nhwpOWVXV1SKgMBVCOoYZJCIIl0lMTnNOoC
         CEJgeppIaAZUS4HAB0fJ8yPTu0wThX+CKBda++MZWPq727FYh7zbHh+08fc/Ot62umHJ
         x+dA==
X-Forwarded-Encrypted: i=1; AJvYcCWwApuJ9tl3KSLM/Wfpip0zYN3Zjm8tXGVGdibPUHeJJF5acVwNXnkw6MnbKMKj1hwCbqJ1zZqzceP2yfXLk2Yo5mFv+RBFlaiJ4w==
X-Gm-Message-State: AOJu0Yw/46srV+OBKCalQScmyMfbb/tPYfEM3ktNoD51KkCrms/kBQ51
	lkTqD45Kq7tBVdeJoLOqx4NviJYikOzt4XAZ6wx0OF8mT8KbxlY/1le7SuD76W9bQvNEfLeI7hn
	DTioUrk+TBR2AN8ye2Byv0m/8iM+qvoJej2UBrR7ZK8E4T8DfGgLeIK5xqg9lbBgY2LU=
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id dc3-20020a056214174300b00690027a00e6mr5703628qvb.5.1710366443330;
        Wed, 13 Mar 2024 14:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB+0sslZT/w15j/K+m+SJUdgZVImDODUje9EjvSi+lJj4JWIjdAUo0kKWd9JJ6p81zVpsztA==
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id dc3-20020a056214174300b00690027a00e6mr5703604qvb.5.1710366442877;
        Wed, 13 Mar 2024 14:47:22 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:22 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 01/13] mm/hmm: Process pud swap entry without pud_huge()
Date: Wed, 13 Mar 2024 17:47:07 -0400
Message-ID: <20240313214719.253873-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Swap pud entries do not always return true for pud_huge() for all archs.
x86 and sparc (so far) allow it, but all the rest do not accept a swap
entry to be reported as pud_huge().  So it's not safe to check swap entries
within pud_huge().  Check swap entries before pud_huge(), so it should be
always safe.

This is the only place in the kernel that (IMHO, wrongly) relies on
pud_huge() to return true on pud swap entries.  The plan is to cleanup
pXd_huge() to only report non-swap mappings for all archs.

Cc: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hmm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 277ddcab4947..c95b9ec5d95f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -424,7 +424,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	walk->action = ACTION_CONTINUE;
 
 	pud = READ_ONCE(*pudp);
-	if (pud_none(pud)) {
+	if (!pud_present(pud)) {
 		spin_unlock(ptl);
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
@@ -435,11 +435,6 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		unsigned long *hmm_pfns;
 		unsigned long cpu_flags;
 
-		if (!pud_present(pud)) {
-			spin_unlock(ptl);
-			return hmm_vma_walk_hole(start, end, -1, walk);
-		}
-
 		i = (addr - range->start) >> PAGE_SHIFT;
 		npages = (end - addr) >> PAGE_SHIFT;
 		hmm_pfns = &range->hmm_pfns[i];
-- 
2.44.0

