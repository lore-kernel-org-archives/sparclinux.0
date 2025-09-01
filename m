Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CA35085D
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729873; cv=none; b=WqBMjSnli6lsDkpqpaCH085JyITJOqQH2XqYyZ3gHzZe1lftV0hMJ4tuhz2yfqoFTwbwojL0Owae0rgwjPR/FLWpLFWKM6I/BwFqgswenz+rR9WlTfqrTDYBbxHX1kefIluoshawI6GIh9CnsJYFcYI2kl7gBTelhuowwvgs7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729873; c=relaxed/simple;
	bh=KDOJlWebDr1r9JKcB/6qXXsMuiPZ+GrvsOQJ8M+vAGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBwBHGylW3RCj7q9NEIsBarp3QAsOnUzGQMKShdha82oFahAB/s9FDA2ZW881P9Mn92RLVw/yVRhsoiN1NN3G8aRguDcGpgv0aphOO8OcCEHZ4Nhb8iNdTU3sYn++9Zz+6PWYMwZCvslxjPSbq7keR8jxZx4hxVgGKhs4WDvdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QRQj1tz2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QRQj1tz2"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61ce9bcc624so4672738a12.1
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729869; x=1757334669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZckJdWYT65mLwvxCWKoPCArrn6/MXXjzKwssfU7w+U=;
        b=QRQj1tz2wCYs/dw/kpTXZlD+jIy5gt0yrnfJgBeIMZTw7rXoFpyN02yhhU0/c5CfOF
         3DwTx/LO7H0Shh7hHHvTY1L9bcnK5mj+kNha49DViiEK00n2lG0EcAJrXeE0UExKbUpC
         FXCIb3ZYwq7ih+LfEXYc8XOtBYA7mmLP36z8iPML0Un8008JO381ZlkusHZz+wzBOJBp
         mb2kx15zXIDojufwabs97GVReA+0X6+xyJdBBR4NYw/lmYEmiWhxi68HiXiqKR4RBXTl
         yzq4hBQ+CWvUq0RvyIz+mXXCFw/8+Tg3CbAF1TjyqpdPP5lo1KBs9ARYuYmm7Zow5fHv
         Mgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729869; x=1757334669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZckJdWYT65mLwvxCWKoPCArrn6/MXXjzKwssfU7w+U=;
        b=UXVBkwmKToXJqOsZwg3J1Sb0MhYNKfKc6Rap9BdJt2709EN5W0G2oQLVp3GIcmLSDY
         gXAilSk0tJVEnUEIx68NVibQlyFYjWGRhqogEYJs6csjce9tet5FfV0FCW4xktQVv0bM
         sDmOhYMw131q3X5rEIANtEZlKJMmWVlMlNcQiu98l4vsBbBKpRdiQ6+qjEzgfO4RFHQJ
         tBIII1egDrxIo4gWIueKvOnTHmzWYDBKawGVJlbh4I9Uyp8/gSP4zIg0aiyPiBuKZkNg
         DuT5GZbkgbP2b6duH/Ja/o56k33eds57NfLKRHy30PRgiKz8dkYFsUcfhaMEexpK6sye
         7EYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg7jbWFg0ssAjsOqfeGRlSYa2ODSSINoskDoqWBbxjoc4d2d86PnschmvCWqWw4IDfhKqGqJ6FRyxP@vger.kernel.org
X-Gm-Message-State: AOJu0YwVw1peH7/vFuvjLyEtlsRrX3m2ln23Fv6ZE5NseAuogyFjlB4E
	h6nVzg6HuqWORbGC17f6oziF23tc5PxJQtS6C7pvVzYd3sXNrlKJPmizvLtLzJhX2vydaazsiZ7
	reWaSwbs=
X-Gm-Gg: ASbGnctT//fEDJ61I4R6RwJXIK4EULTqpj/+8MuC8+lTjIWwJ83mgmPZxPd7MDv0r10
	QoWoxdWEvRM9f2Hlesmy4+vEz6iZ5CbyFoAGYm3q5QwD/XruLGdTVbHBDOwUxBSTzV+Yo6sM4oU
	eViXqaSO0HeFHP1yINPhAa4LDdZazngcaLp7pIhrH+1j1oNzSI+swpE+eeI1es56biwy0xMDlPO
	kedUJgp3z6oiucHQTg9EQhbhOOiL1ELOpkQPT9dAtYf2bZlORF+QdMwFhXDPsydQx+NQn5Ai1Fz
	b9zoHh+DQZuuQFJ2HB+dWkgCK0WrInb/HuBnmPGN1PY9ZBvFQYMxaziRObmsq8ta49CQAvFJiLs
	sNr0xYGdm5pBkLLbHVhAqjsV+caydxlWePidavjnc8rnLHCGV7iv9jbIlDbPRm3CuCIHILEcC7k
	RPbkMjstAqbeghpB0QjQ16MujQ/yZ+yN0P
X-Google-Smtp-Source: AGHT+IETxUI3qvvcJof3qThaTHBjP7BahOV3yuMasi46ZJMakvC6EwAs8jjOUppbppRZ2B64GjsX3A==
X-Received: by 2002:a05:6402:5207:b0:61c:5cac:293f with SMTP id 4fb4d7f45d1cf-61d26869f4fmr7390296a12.6.1756729850374;
        Mon, 01 Sep 2025 05:30:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:50 -0700 (PDT)
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
Subject: [PATCH v5 09/12] mm: constify ptdesc_pmd_pts_count() and folio_get_private()
Date: Mon,  1 Sep 2025 14:30:25 +0200
Message-ID: <20250901123028.3383461-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
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
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..46e27ee14bcf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
 	atomic_dec(&ptdesc->pt_share_count);
 }
 
-static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+static inline int ptdesc_pmd_pts_count(const struct ptdesc *const ptdesc)
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
@@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
-static inline void *folio_get_private(struct folio *folio)
+static inline void *folio_get_private(const struct folio *const folio)
 {
 	return folio->private;
 }
-- 
2.47.2

