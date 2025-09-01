Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A120C47C
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729839; cv=none; b=HpyiosqralzD1Yq20WBcWlKFIKoB4cH2UGian2Nu0suldFukSyB57BuTVm3RIK7gZEI1zcO/URzOjzPJ6R+SR+EnKcSxCGraEbRXp51X9quODeulwAY6XzihXT1VCQGHpF1iuuz+wcD6fvbCcfc+VVfzL35bBgIp7GgyQ+3NArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729839; c=relaxed/simple;
	bh=v24uZZ9KVAxxo/0P71k6jf7BKwFIJrdpDNs1iZ9/YH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNgwDxNLjYHl1BM3uA7RMIj44SFHkiKk1Y4sBVJ7662y2ywMzZ2qO7DgxRBM+xSi9I4TPOqleS4qutGHsLEOnBD5b6sB7DisSZllmFyVogN56FUUmqk8ZiEwehUDnQWEunS6eIL4SZo99yc7Nr1kX4WvekRzemAxT8o6w49xCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bg3wcAgF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bg3wcAgF"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so5790621a12.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729835; x=1757334635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKIQLUaaWXpeIWzcvUskrPePOLIqiIThIa1QtzzvUMQ=;
        b=bg3wcAgFvz6eccB+aOUXxMPDfC+OoWDE6CerXdrkTW1e/F5L12zGQtf53Mb6D2fd8C
         UBXLDuIN77FktIrntj1YljasfSdTqK+rtsZsfNBKTO9rwP/ddiHmcmgBkFUl8ppQgGj9
         u6uEpC2J8ErfOofMFZrQoiomYgRFi6Kd+yztu+9qmpKLjZ/L1aaLoPIiuZZL4KwRKZ/P
         WNBFbDxEUKkAdaWFGbxuJB8nuDdQbkQnXanRjih9qp1Fj98Lg347QbmCG6YNGo4QFxMD
         W5ulon3uX4L8ZIqCTkri1jduQKlH6HFQm6aMWekuXdwopIDkVRg08PheKUlOrpaq5n4i
         7izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729835; x=1757334635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKIQLUaaWXpeIWzcvUskrPePOLIqiIThIa1QtzzvUMQ=;
        b=hlmaRbcEjqPxQ2bAPsN+FpfuIqdLNCdgaltvZDidP/RFkK6613bxyVRA+C+PADQ1Fg
         hSQRCORDcl3KdFrZ5X02WsrRxiLP2syz8KxMPefnkjmP2pJ9HCRwRbH4+gbhR8lzZmi/
         52PlW43f2NDgeymNSxCT1FNGTm1Hz7pCEW7Zv727eNmM/ZDVcUMC7ajaq95BF7HPbRS4
         3vPb52zHS9xhFfESE/QbaZw+bjcXf3BnoyXYGwkKDpvFrt8W4fbFy+faTOt4vsSqLo6m
         iiXT7xsRXE1xlm0ymO0B1wSuk+xjyQPVypaFSAd8p+3z94+v4lh1z+iMBO9CvIKYj63x
         HYYw==
X-Forwarded-Encrypted: i=1; AJvYcCUfetM2dAWSosbXO6GNzSkinFGh6rmKrceNLnWLEGktXfXbDTMpW3DCQMnwAualk6MZhZI4OmFNyaMq@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbLqqQiFvbnxD6KhF74geYGqZIvd2KlRXBSXlW7LHMCab5RXQ
	YZKQeNYcu9ZnPvTI1EuLACw68d2B9iGguP56Na3gy0aVxYq7IGeEVjoQzaGME11dR7U=
X-Gm-Gg: ASbGncv4Nnp9aijUVHkS9Wy8//dDYbP2xdYTMLb4/YaYUuNcmuZOTr+NP41+yw6p96z
	jN5Ja0sOiaISYovu/PxUIuX/ORkFgsEITmWn/AItrVyQvSLIzT0dUKBwasXh176mX7KonQ12cNc
	Tn+PdHpWrxHmpOdsyVb0j5VBA+ad2IGl3LbL2GkZE1dRYYMWjRnhbyHHLAC9OCTXajOaWx/fLR3
	pBPU7pXUQUc112PhcldiP4WYS70a9Z6rSUivoVxIitprVVIbJbvp1tqnktcu1cGT663Rlf7RCHQ
	oxIG6S+r4TPsCTd87d1jIRRHztsKEF2znbB88u+sKSs8KGcgGWCQtR0VJz7Yg7+9NfGcElI/YCR
	t9oFmxvzVpFJ/zTN30mL926YkwjAbsXF+yT174I1NqhRqHN0FwEjyAkQbr+xnduZF/2Yx2gI1ZW
	3wuXmB2Ym/gZ1118+J+thauw==
X-Google-Smtp-Source: AGHT+IGDWKKpCY+gwaNyKUXSsMGebFFbg8AoojoUj/75zRe+ebpEqmLb7gpe5dy7vu7IufqwC7egRw==
X-Received: by 2002:a05:6402:505c:b0:615:78c6:7aed with SMTP id 4fb4d7f45d1cf-61d26ebcdffmr6326182a12.32.1756729835027;
        Mon, 01 Sep 2025 05:30:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:34 -0700 (PDT)
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
Subject: [PATCH v5 01/12] mm: constify shmem related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:17 +0200
Message-ID: <20250901123028.3383461-2-max.kellermann@ionos.com>
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

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

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

