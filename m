Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367B2737EB
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759838; cv=none; b=Nl2nyj6t2X5caiIIJEogpqC69WEo+MG/imWpg6nsifD/1b7/1b5TNcLJxhz6cl7ax/W8jVuv31yo17PIOFAaJqh++uhzyfHHr8+aIOzRe+MLmSsC/BcjP9HTlQgx2oaJVQvbWWVjw9GfPmmdNe5N+k8wmjRWzdjCrKHvQmzsGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759838; c=relaxed/simple;
	bh=9ZBLOgc8o7e4sYGe9wP+1FqjAVbgCQ4ajZen8ILi1mU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv6hh+5EDx2/1xG5gWiFjPtWqaS06PrJL8+OwKGPWkbFU3THg2lQpd1bDpljU8eRDecGVRt6thO/hnlJBckf+y1MdGBH8L84r04zrhZHbc/fd1HyUOMG9YxE56sRk+gj/zQr/hsAEcK3U5oVjC28Yc111Ksw+KIMQpSuAi/MWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fd7uB6P5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fd7uB6P5"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb732eee6so816276466b.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759835; x=1757364635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOUVRSUkKssTlOViJjAfm2Ry0I5gABWdPNOlGM2jpT8=;
        b=fd7uB6P54iPwC2UabKzsiHRweWKdRQtn3DyA4wJAfMScLZN1S+Cup8/pYYTAplSMEb
         oiBSDgN/cMndhVSnK3dy1F1xDzRmlHH4c+pwq64ndLkUHnyHTx8yv1/dfzMz3ypiPfn4
         8UHqEA9DVSmFJ3D1GH+q+8zaqZoBGK01uE8ypp59GqicaNHlQRnIbnL3xuQLNvvPatap
         hJ9P0AdKWfhJjWVQvuXfj3mCv1DMb9NxwlVnYUV9Vzq9E09vInVSwjrAf6Q9VRmB9P6s
         RdfdiJFKP0QNJy+RQC9MFfF+tm0mX1+QjBw9kw0Ow79PUijkwu5E1KqjA6WhcmNf3ZG+
         Tz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759835; x=1757364635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOUVRSUkKssTlOViJjAfm2Ry0I5gABWdPNOlGM2jpT8=;
        b=dAghHdFiVV3T/jqeDNVV/G85LmDE+gXLQ4ZUV2clyoRGpeKJmRqmcy1G6B0NO92nVQ
         WUzDjo7yunDi596tCesp7VtEazs7lvIupD6HRk6urdL2A6xIud5AFoRToHipSg3MGkca
         IXJ1ekzsyKBdI3pVZ3Qb2Mff5/WDYPXejeqz/R5GQ8lCZSAwzGQ9qbdshAY+cAYtGFBE
         N8F9KKNQ9qKPiSHNaqOKEO3fTIpCW4AtYOzl0oLOcACKPSPTMetDz4DX77Xglsd9mw0J
         v9TWnKC3iQlIHLQbEkKW2cJqL6ubhPIcX6sIJ61XxTL10yc3AmeUGJQj2z2gGoh3a6qc
         jEmg==
X-Forwarded-Encrypted: i=1; AJvYcCVCVyLXDZ2PCBaBZ7hlPjtpaqCIkarTmpGbyWfybYD1ktqg119L7zXroNqC2hDuRzhXyBGVmMHtnkqs@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBnyCHfLv2obDLUE863q9DtpKLaEQ38uQ5YB3wQryanwcq/VW
	PnDYKtUCBRDGLRtL2VCfdxdmQm6kTn2PBb2AVWsol2boPEFo/91jrmhCSTHDcrEMdo8=
X-Gm-Gg: ASbGncuSVwV3UG//1fr9V1vEZNAe8xliu4ni3M8GsuAkljzfH2LacFoxVAQKgnZxISB
	bxFlPqhRIw0ElsEQ866lPw/V/GXVHH3b1E525hRSfi00HA8KKqNMreWuACGqwT2pcgtI0MJJyzr
	rv6Tii1JjgE/ty0g/0PScxWE0Urizok3bUYbTB/0IOkLhMYv4s511A2emfs6HLor5V/G6WuseR8
	i2BKzJ6IauFB4Y+83VkmAvcbn6g5/U5m4E6yqwmh9pGks4wD9ZcnbXGgJMl/j8ChfyMvP3L2wj4
	w7yWKuPvBDQbNrUqsNHUy2aumj6qpmbnvXMNrTgezFryI0HNb2zbpgJQr+SaHrWjTHjZK2X3pSq
	B90wL9Lp8GRr/qDKFZQn0Me+oPhRR/h0S9HLxByYabzml5nwg8alT4RH6FZUuZAmlczqWc1qjcV
	rZV/Wwr/Df+9bJiiJCp+KPsxduMvPXXgxj
X-Google-Smtp-Source: AGHT+IGigtKDXFUmdSAlFGcDTy1NmHrauWomJBx5FIkz9t/2ArUf43T05qd7+gJYKJea9RCwhs03Aw==
X-Received: by 2002:a17:907:e8f:b0:afe:8f28:fd5 with SMTP id a640c23a62f3a-b01d9719057mr990403866b.41.1756759835180;
        Mon, 01 Sep 2025 13:50:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:34 -0700 (PDT)
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
Subject: [PATCH v6 04/12] fs: constify mapping related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:13 +0200
Message-ID: <20250901205021.3573313-5-max.kellermann@ionos.com>
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

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..0b43edb33be2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,7 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *mapping, xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +585,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +599,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2

