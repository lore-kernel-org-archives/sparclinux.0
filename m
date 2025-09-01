Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0927B4EB
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759848; cv=none; b=JgvY9yMSNADIhBof5nRbg8vYHCls1C+bh7KlWnaRxfHcV84WYKiUmJ6q0lXqwKAxaBRVHEM2jYPZ1i4DSx3I4xqnnzAmjSB4C7LLTSA2TPa5enFGwtSPLDsqyW4YcTybr/dB+es5iNucO6p7mRleBhiMYDJSU8URH9sAqxMGdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759848; c=relaxed/simple;
	bh=w09YN44Ob8oHKn+uyAjGgqeXNCZXncsfFv0uEPQT9KQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6juq1Kt3K/bzrnJ/tD/IfvACEft7riZjoPPfHFvMcPrzVrWjL2+cOBxZAqxpf58rQ1TRgbe3UBEq28gR8gLU+iTSFjmwOKYj2ykxNNkijwGXUlr0mpjwi3P6YtVzAb8lQ9rBRV8oQxftDIV+pwrgntBKdkpqBwA7KyvNgaIm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QVWzbnS6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QVWzbnS6"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7322da8so918625366b.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759845; x=1757364645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nlX/RfH4bxrhjLqRHCaPu5Q9689qctY9+oII9+YwlY=;
        b=QVWzbnS68cfJVWT1x41k0Vox8VFLJYY984lxcH1NdE+MWfg+wVnF4DZHMOtZFQSZbT
         mUZeVxn/YRZCwruyJaNFAH4HLppzBpwxhfa1mSjVMUOITlkk0OZjJOu4uyqOtz9Muh/g
         BUwoOaDwodyVOZaPxhJsmj27c4r6JVUNW2M0GAO4sjmWG2Nkx528+mnCtG6CcKfAXfjm
         hHqtT2zkrndHcRfu3nfyk/xQ16iVoUNSbQReCQMmauk9iQKxtbJOLj6AjGhdYa4KEVGS
         0VoTuyEKKSRC+yrbwHVxNP1Ha41CMyjTojgjUn9bPQYJ2LhEM0pZ7NsiXQCWWicDr0Kx
         i2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759845; x=1757364645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nlX/RfH4bxrhjLqRHCaPu5Q9689qctY9+oII9+YwlY=;
        b=pYdSyPYyRY0nhXPJpgNDawuQkow/UGP2/aFkwUwK2OWxwt0O6yE5+JdZvAwLbpdgfn
         LRdpepb0wjNZk+ySJ3/nTPIh4rS11WnRbSg7aXeoEjZESxo4m4lA2ZNy4pou3BzvRtur
         Iry12wTL8zFOk2YRvGtHZFJUqN/WYKOgFyI/kpmSGd0Zz7vlPoMe9cQ29GlfJocYujP/
         PzoS8CUH6lmcmdbakiUg/BfkedZKMeKM610VT/fv/KcnpcBb3zxgZmUJddYcRQU8w55m
         NvhZnWFwKvCjs8s3znrFBF8NfvhIBWlp6bSjFRSnCdmZjgx4V7nHEyO4qS0LBEbQvR08
         Bx0g==
X-Forwarded-Encrypted: i=1; AJvYcCX1XXf3wYwFJnedJ8qdzIuysydeAUsmeuNALIt2u03VlUS91xCmau4IW82GrjqJLluRG/1UFlYpuWff@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZmZAfO/zBxYNHWQipuazzb0ojweTFVTRTsl8a4jjtmyFULfI
	5yCMpUrhiVOFwRzdUQ2JnooyZAxNCoXx7Q3zYS1hCUQLxZgpnM8GjG+fDHPeUV98skU=
X-Gm-Gg: ASbGncvxapURR+8Q6X6i1m2wS2jUOG8B7CKES5GNJmyh0dIB7BiXAIfD3vx8JznsYIx
	0nQVa2WLHGLXIJUKArD8Gqr2Z2KMFwwH09FI3pMFseFXt2UVdo7U3+XSO/ybv5uLV24J/UgBNLT
	S4wJtOuXc6n7t7v5RNhxrxRWBeKmk8lGvzoFZ1TJ6/kS30AJ2tuawNN8QmUAdNdaBXcE1w3GaZo
	PmGlkKtxb7PDNcSzSR5TnN2lxZqPZbLgGNRc/tIHdiWuFzvXSjdAEigH04L/0H5fgRPHaPBxZAt
	MKK96r+zO53S2w5V/8dvrK9mBzddJMgQ0H2UDYLN2xXLIgrfsgIQNI5HV11yTc3fyudtjpgBeK2
	tulvRb5tN+evb2Za18EUAfvvi4e+cGEBeoH42m94uYXEkRBuhXMT+Jf4pyi2/fZ1WbpGo3gXNv5
	xyj/GvV0t0tRxKfNnzGPAM1w==
X-Google-Smtp-Source: AGHT+IFcANB8/RcKkowYdOQH/ARcgHa8um9z86mmrwre3BImDNI7cpbMntnFRJto6276WFxuuld4Aw==
X-Received: by 2002:a17:906:6a27:b0:b04:302c:fe14 with SMTP id a640c23a62f3a-b04302d0545mr375148766b.21.1756759845048;
        Mon, 01 Sep 2025 13:50:45 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:44 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 09/12] mm: constify ptdesc_pmd_pts_count() and folio_get_private()
Date: Mon,  1 Sep 2025 22:50:18 +0200
Message-ID: <20250901205021.3573313-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions from mm_types.h are trivial getters that should never
write to the given pointers.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..275e8060d918 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
 	atomic_dec(&ptdesc->pt_share_count);
 }
 
-static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+static inline int ptdesc_pmd_pts_count(const struct ptdesc *ptdesc)
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
@@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
-static inline void *folio_get_private(struct folio *folio)
+static inline void *folio_get_private(const struct folio *folio)
 {
 	return folio->private;
 }
-- 
2.47.2

