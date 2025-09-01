Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8330BB8A
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718369; cv=none; b=QigcyTRLANMv9v8mhb0Yr+imObnhB9ydIH2YjmvrxZbt56dnPPxd939YW8Efg/m9LwNuWzPdaXgPwJFNebzZfHcUCXgafC7rnhbfe+XKPLPhauiFakaOD7VXzU6vp50A0WN99ZJZNRqFSBatxW+TylvP7rKiT0E1vYFJVHUSa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718369; c=relaxed/simple;
	bh=+9zVED1lHiuNiZ1RPeRxS3Ssm9MpRMNLvSgKjt52v7k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAzqEk3RjsNAcfsPfawr+zzErOadYopp0QNpVBgbnx2xpXuOjRjFLrc30z7EgnZsg2K1Fi9j8r1wmbT+4G+37LHrX6Zrol51FSsrAO5EHebF8ExcVpjVf3P84l7gsa/UKFTPospWLlf4hnA7rxTpxB2VhkOWnh8iPFoLV7l2lKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=anaTr1CN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="anaTr1CN"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0411b83aafso213788166b.1
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718366; x=1757323166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsR/STrnydl4a6f2Yv7mj4KlfpOG0wbJ52LB7E1pZ7E=;
        b=anaTr1CN9wCZ5ePMrch/oFngDKxnpI2+DAygB3XZhVHI1kmdu+Jmcgl77x3ZOIgBi4
         CkhJm6RIsGmqD5sm2LDeC+j887fN4hAVplU+OMcvFvgKfL+xFFUmAdP8QOXkXvf7OSPv
         VybgUz9Xc1oqNnzfyA5vuMyXoZk/53KUfKBbWzVJUCTsLDCYOQqgEw3VjVBnl+1rcEN3
         6HGM7ny3pol9p4IBUPfbZLv96TySiOhJ6ZQDp4/vkUG8CsTJWmE8vFm83C9nYgHec53a
         NyH1mqimEN2SBabWMIKD1gUyjrC610ZJrM5ISxGR21cnPdGQ4TYteHUrD3PfrpHwZPg2
         uEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718366; x=1757323166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsR/STrnydl4a6f2Yv7mj4KlfpOG0wbJ52LB7E1pZ7E=;
        b=P6i6ua7WjzQz4RuYlMgeGnqCFyko28xDqNmGAEi4SV2jllWoq/E53ym4OBdbvw67lJ
         4cjcj50dnrs56PLUTeuyHDoNTEqS77D64qDRDXPu6OLRt92sllZtSdefH19oUVSeEu1C
         /HkE/kQ26J7Dn8fAxlBmbCT81pLWHtgFosoozBisVBL/basL/5ZYTHSjUd5z6S3CFpfb
         0ghIR1Hp/ZJE64eNVrQSPNHZiGQ7FsTMzCihw3n+k1nfjV1qXjrk7dow09nSUPWCMpvP
         XKd8vFzpr4mMpgJjFvYW+3xIga/Eh7XK0UEIgC3X+kSKcPEbqKToZgprO5dJWviHRMhT
         ZWkg==
X-Forwarded-Encrypted: i=1; AJvYcCVv32ee5JQVXNtKz6ChAMlzgRC9W7OhZnEsuPnS0rytNEwmOfvKZpFAwl3JkfFY3zaGhxt8jidgWjBy@vger.kernel.org
X-Gm-Message-State: AOJu0YxduAE2lWFz0U7bTpnn1p0H/SuyhlWTuLMayS/I/s7CulxLEZnU
	edRI19RnHV4Z5+fv6eH67amw05QhTqAgGjAQsUT5dXkA7Ba7Vc1jG8QYcp4AOEDGza4=
X-Gm-Gg: ASbGncvc7T5jI9HFE167BRxC+XLdrHJ/8kro6loovna1y29Et3andfaZjkzfarA+ocH
	wUse9hFUJPZq8wV9/qkAaVu2S1RzzinctBkXu8SXoGlL50+ugyTZgZ1FzzHVwUk6jCT4AvgaPHo
	3ZreTxxNm92PwNbAQytIXST9Vu/xZTm08+69J+YtFmjvrEov0wdmdCKguzDSbnYLQM4y3pXyac5
	AxGKB0lLaMQAQgQMPRB0nMJp6Y5PsOPVhgcFWAt0e7nb3GeQfriFPjMQPjJ9k8WhmGn4ao7q3aC
	mplo/UxDycMMrNWhuY0LTX/YxBwsxyRqXuSaLhLUQ1th9niXxjSloE/6GqOayVFSzrt1Ud067bt
	dhadw56YyIriOjnSxZo47SOXkGSjjHklPr9reDHqM6iO2fZcjZZFEWJpABvlpGVS6l3mcylXXx/
	cNQKJRJbSrE1r7aTdowguZoTW+PGzD2rrY
X-Google-Smtp-Source: AGHT+IGLx5jJD5g8VFu3vDjbftCHYb2Ijzb40t+FBcgd7shPE2wS/JLAjEdNECBMIdCPyPMz8moKGA==
X-Received: by 2002:a17:906:c10b:b0:afe:954b:25b2 with SMTP id a640c23a62f3a-b01d8a26dcbmr694211066b.12.1756718365873;
        Mon, 01 Sep 2025 02:19:25 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:25 -0700 (PDT)
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
Subject: [PATCH v4 01/12] mm/shmem: add `const` to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:04 +0200
Message-ID: <20250901091916.3002082-2-max.kellermann@ionos.com>
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

This patch adds const qualifiers to vm_area_struct and address_space
pointer parameters in shmem functions that do not modify the referenced
memory, improving type safety and enabling compiler optimizations.

Functions improved:
- vma_is_shmem()
- vma_is_anon_shmem()
- shmem_mapping()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h       | 8 ++++----
 include/linux/shmem_fs.h | 4 ++--
 mm/shmem.c               | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd14298bb958..18deb14cb1f5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -979,11 +979,11 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
  * The vma_is_shmem is not inline because it is used only by slow
  * paths in userfault.
  */
-bool vma_is_shmem(struct vm_area_struct *vma);
-bool vma_is_anon_shmem(struct vm_area_struct *vma);
+bool vma_is_shmem(const struct vm_area_struct *vma);
+bool vma_is_anon_shmem(const struct vm_area_struct *vma);
 #else
-static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
-static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
 #endif
 
 int vma_is_stack_for_current(struct vm_area_struct *vma);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6d0f9c599ff7..0e47465ef0fd 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -99,9 +99,9 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
-bool shmem_mapping(struct address_space *mapping);
+bool shmem_mapping(const struct address_space *mapping);
 #else
-static inline bool shmem_mapping(struct address_space *mapping)
+static inline bool shmem_mapping(const struct address_space *mapping)
 {
 	return false;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 640fecc42f60..d55bceaa1c80 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
-bool shmem_mapping(struct address_space *mapping)
+bool shmem_mapping(const struct address_space *const mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 EXPORT_SYMBOL_GPL(shmem_mapping);
 
-bool vma_is_anon_shmem(struct vm_area_struct *vma)
+bool vma_is_anon_shmem(const struct vm_area_struct *const vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
 }
 
-bool vma_is_shmem(struct vm_area_struct *vma)
+bool vma_is_shmem(const struct vm_area_struct *const vma)
 {
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
-- 
2.47.2

