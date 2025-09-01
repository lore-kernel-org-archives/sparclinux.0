Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FF30DD06
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718375; cv=none; b=GXgdrpjvbpZeSiofvvrElglsGGwPr12qWDAEGEo8i9m5LrdDDAt/5mv0kMx8vQbpF1XUYomDWDer6P4s5HyqJAPizEgpPXgte9oBjmmDuC10H+hRd1dvHDvzdqVkCaGbh9RjicDGcV78F+h4al9ooUTB9cSeeMiAQNHXpXKIQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718375; c=relaxed/simple;
	bh=fqMfYftVrFkOy3wbJRO7r0XLlbG/lU+7XLovauzZWxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDbEOHwUn3tlvXFW6OjGTCKNi/NYsZJd7uJrrtoZErZGfNSWeEvjrBB2Qi3sUEogRKtSeX3WLkAqG1vUOwXzml+BEKr5+UsvvnjG/h78aSlTaFwozM/MwbojjY8WF+yARBl0cQRm7DY8tbYZo6NOCWD8eZbkw3dL20KxIUOmXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Dl7V1wER; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Dl7V1wER"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04163fe08dso202573766b.3
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718371; x=1757323171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H3eprdm8oiBq+0anIaTODIO0eIcUyIWc/5jJ7tDkes=;
        b=Dl7V1wERFzMleKB/mcdbkOLSfivKh/0qTbbLHtW40hL12fF/PHC6FBC8qSvS+8F/AH
         5823j13P3EjHQyBXddCElPlgiJAomY75h48tIKrF7Aiqehm9JKkfycrMNH8tpoI8wWhE
         1kV99t9hXTKOXn52zT9HzwBCAp5xD3jTg0cA4HwqoPkGOq+MUNBgc4RNYD67veOaFXv5
         yMZaKCwx/18ovZe7OG6CWpIBvjMi9DTLZhuoxCYTOkVPoG3Z2oVQNvrAnl7JC2RXUv/e
         CqNkBD/dICQCC+BKKzxrAq0FOGHnwGkJC+NZt0j7I/UEBoL31gvVNsHRUc9JZHTuF0S0
         ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718371; x=1757323171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H3eprdm8oiBq+0anIaTODIO0eIcUyIWc/5jJ7tDkes=;
        b=v8n/gf3CEzOiuX6xDKx7RlsAhbr3gC3P5yWdJWG6eS6xfQVwd7agWM/vTv61AzgJnO
         V1OvARG8KyBfFnGKeWH50WBE0C6nyBkhYkRiqTcGNF5lpqz4eQfntRgU2CkWIxOoK1GM
         /HJdfLOE8H5v7+rVRJaS0LRNWg4ffisjiNunSHSmqUfUxDYZ2p/DN1njULZYqGCHHgn/
         VuDCkJ8i53ZjeJ1/DjW1P/4ybIUkO1j6aAnlERVm3fDGjuX6wn9In3nyoE8bZoS/JfZD
         5idpe8ob1+aqj9kVbhGuBVaL2p2TyeUlUXEWmWTlS1/HVNftFgPZ70xOjnuORRuHY6hm
         od8A==
X-Forwarded-Encrypted: i=1; AJvYcCWbNSwwiQlfEkVexC0D6iku39RD4MYcXCOFWxZdlImTPwkRHF3+TiytpF21cc7DlgOA3uUgc5vXxEy6@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEq4wsnaJKdAHuzLfbOPqNO5vjUHVxhtowyzIB/KiJDdUhYm6
	yK3rz8DZxKMXIkCKsIdlIAY3o4XTZHKpgzPX6a7spJYHPrUDWI4c1N5KJWAAs5oHe0M=
X-Gm-Gg: ASbGnctkxVVayJ4XlAsLBbv4JsiHZU4C/O6VIHQwNHU/2UmtzFsLXJVZXoQMySXUlT8
	96codDJD4oTw3IuuRqnjRyUef6Rm5A2hovXKfmRSrM1/XDTJqVFPoe2C8EPbmeDzx2T0IwV9/pV
	CnnHUJ9RmSv6sc+A1bUoPmH8E44IlMIyeqfWzoiM+EUCRmiSFsbP9qKr5Suq7P0Mvcni1uSmnUY
	H7kNjv+cSikKlFEh71DBk23EaRXTJik7kfbqoGrgapO/9+jQ+3Ip2dP05SqMMAX+5C6/Ncsr2gn
	QR+V8iNTsBgmLmn2nA/3TeAM4r0N3WWdGo4/zIL8G1l2Qn43rmli5Zlvko5foXe+qIL/wGM897m
	rhSIGDlPUg6CgOD837glXL8KZR/VOHmhSyACuRp5Ypg+w/ebHgn4zeCd9mm64SZVJ6Bi21f99iI
	c/ZPviLid71yIBElFZLBm2Lf79r+YU0n/Y
X-Google-Smtp-Source: AGHT+IF3CGqBNxa77EXUE/Gi7n0PBGLpiMmjL4vqume2Hy8S1ALFuVUh9cDg4qepPIlJtHhtd6svhA==
X-Received: by 2002:a17:907:7ea7:b0:b00:5399:f5c0 with SMTP id a640c23a62f3a-b01f20bfff5mr728590366b.62.1756718371341;
        Mon, 01 Sep 2025 02:19:31 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:31 -0700 (PDT)
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
Subject: [PATCH v4 04/12] fs: add const to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:07 +0200
Message-ID: <20250901091916.3002082-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to address_space pointer parameters
in filesystem-related functions that do not modify the referenced memory,
improving type safety and enabling compiler optimizations.

Functions improved:
- mapping_tagged()
- mapping_mapped()
- mapping_writably_mapped()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/fs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..8dc46337467d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,8 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *const mapping,
+				  const xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +586,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *const mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +600,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *const mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2

