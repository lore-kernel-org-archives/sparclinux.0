Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC4137C2B
	for <sparclinux@vger.kernel.org>; Thu, 25 Jan 2024 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211209; cv=none; b=bvIJqPHvVaJcmqRQWDQ1XLwOJ0I5x/Qpjt+c+8FNrzvHtjmtKWH8vuOTlKl1iL4dwR5ofxNukp2ypWTxEvhYSF0ZwhUKWkWWUHMGiXTC8GAFXJRlUp3La0O8jabXIopFVfgU/wdBeUatcTP3srP+xnz1/OrXFlSWPbWhh3hYHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211209; c=relaxed/simple;
	bh=ND89z77MFR+zvpNlTF7OTYgSP6ZPtepphjakoIxc3F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiI+xru8BkO7WtJzggCtO+0NIcZnE4Uz2mrqQvZielKPdv89hfni61yg2Rzulh99YNlZhAsCmKa+XIvi/GogyzXiGdAWCFzc7L6VjAJfDjRkPRITRuxwPIdNCfME2cmZWUIzW2Y5hO0B+uMtACy/kdXw81E0pwqGrTj39PwVrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj2j+Ms2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj2j+Ms2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706211207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+md2pmrHp48BftcWE7oPMr3+y6qzWNOJ1IOyjx24C4k=;
	b=bj2j+Ms2WpWkWKZ990RcIdmmxsOge0M5v4/h7iGhKU1+Pz4J1HK2juYnl9Q4AJYd2HAhBz
	x1+RT9qCaYV7ywFnHrHE84Tw3RrjlYwzdHRuxWC2VLw+zKeqG1BnyJwRQ+rubIG1MoQTgM
	TNkzrGuXJ514jtoecj1HPavSC7zM+RQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-07MQqOk2OR24s5b8tCmCuA-1; Thu, 25 Jan 2024 14:33:24 -0500
X-MC-Unique: 07MQqOk2OR24s5b8tCmCuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 658038432A2;
	Thu, 25 Jan 2024 19:33:22 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4DC1492BC6;
	Thu, 25 Jan 2024 19:33:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 08/15] mm/pgtable: make pte_next_pfn() independent of set_ptes()
Date: Thu, 25 Jan 2024 20:32:20 +0100
Message-ID: <20240125193227.444072-9-david@redhat.com>
In-Reply-To: <20240125193227.444072-1-david@redhat.com>
References: <20240125193227.444072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Let's provide pte_next_pfn(), independently of set_ptes(). This allows for
using the generic pte_next_pfn() version in some arch-specific set_ptes()
implementations, and prepares for reusing pte_next_pfn() in other context.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f6d0e3513948a..351cd9dc7194f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,7 +212,6 @@ static inline int pmd_dirty(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
-#ifndef set_ptes
 
 #ifndef pte_next_pfn
 static inline pte_t pte_next_pfn(pte_t pte)
@@ -221,6 +220,7 @@ static inline pte_t pte_next_pfn(pte_t pte)
 }
 #endif
 
+#ifndef set_ptes
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
  * @mm: Address space to map the pages into.
-- 
2.43.0

