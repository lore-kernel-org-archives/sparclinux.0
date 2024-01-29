Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8F679F6
	for <sparclinux@vger.kernel.org>; Mon, 29 Jan 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532479; cv=none; b=JlyHICLxfzyQtW9NbCgOWdHjyzaAUEOrrjJyfWtaFsedrwZbdjvDKNy8bhzW8VQDk5NA72f4x3Qzz+JNn3s7uS7/xDj3hHpoF60wNSiQyQSGfcHTRmZttwgxa6/ZA+TFnstgzAjbvjdR2bnbEEUxCvuxSDfgAR7+iCbbTkJTs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532479; c=relaxed/simple;
	bh=nuChnFMgPS9fPt8xp1x2/jToewLj0lu1rRdDXCEB68E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoeU1IoBmORIhptQyP+KY05rTONwfKdP0Od/GLHTDlUYsJ831K7/1O8StpECAiuSCfjYmXEkGePRfDc57QXUSKKsvS6G2NDltNVsJ8VoCOuVcywk0fWuHpPZb++G65V+/Hy6xDGJ+/w2h8JSEFkbVqbEWpWaYd7RkqA1lsUcUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFtifYoH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFtifYoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706532477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKY0nJ8fYJnC2xkC+wk3vcUZKJJkEzEBPQxWgaxQbuA=;
	b=jFtifYoHHPqSe9yRyum88g6zWosGxTNRG5ugVZDFBeUHoSWgQthMvYaRNTk80MjU1Fznz4
	0eDegwzjWFsRcX0htZC6v+G4hQXjEnoNZ/Ivocc5TMANDuXTJF7QIccqxlVlaDZCKiMujN
	hZRuZ/MspjIojeOV2yEBc0Y7oT3qRZ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-L0LUIbsCOk-VxGFEn38f-A-1; Mon,
 29 Jan 2024 07:47:52 -0500
X-MC-Unique: L0LUIbsCOk-VxGFEn38f-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AC391C04325;
	Mon, 29 Jan 2024 12:47:51 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 304AB8B;
	Mon, 29 Jan 2024 12:47:45 +0000 (UTC)
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
Subject: [PATCH v3 09/15] arm/mm: use pte_next_pfn() in set_ptes()
Date: Mon, 29 Jan 2024 13:46:43 +0100
Message-ID: <20240129124649.189745-10-david@redhat.com>
In-Reply-To: <20240129124649.189745-1-david@redhat.com>
References: <20240129124649.189745-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Let's use our handy helper now that it's available on all archs.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 674ed71573a8..c24e29c0b9a4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1814,6 +1814,6 @@ void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte_val(pteval) += PAGE_SIZE;
+		pteval = pte_next_pfn(pteval);
 	}
 }
-- 
2.43.0

