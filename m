Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89E55C328
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091463; cv=none; b=PXJXvfwOhiV7tNFtbnq0M5Uf/gh1oz3/Iou3X4Oei2F40LUnb1M7oSgPz2Ga8voUQOlhRc4hu5DT7onFnHkxgaOyZ3FnaBZmdWaYldTwCefMRJysU3/BOajd/w0KDqxYbdE2WtiATu3Va1rUW44nUUzXLwL8lTaIWDqEEaetKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091463; c=relaxed/simple;
	bh=9j8uXUnA6bXnx9uTLBHlFkCr+HVGmoerQr5AJpiH/L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+ZY7nXRt07jk8zTnpjtG7gpiMf3FY36lgvDCO6H6vxPKYqcgkjF6RE+lM760J9lLblNSMgM1bo6r3I6DCsqXDOrd4ql/eqUrcDU0aTYRjG2LRF45YrnJagL0sjojSDPUrekPrA1fYW4prbcm7L/nvEaPJeO4zqsgGO+mcNgZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkqbFoJl; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkqbFoJl"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f1dso17008fac.0
        for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790091459; x=1790696259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OuS5hhU7FDu24KRBC5uojc0lwdkfcW0XUMfKz4eA9iA=;
        b=lkqbFoJlzNednpOMFIRJ0HAv/3ZRwJBOoi0Yn1nAJxt/4uLUIgw9JnTMlTCxHb2HdC
         vZ3KLcD4Iu3biiQJppVLtnZQjnBtGi9jWy0L/6QHDcgNl8OXvXQ1inTWaYmdu4G61WMB
         W36Gvfiuyq4/W+bNKVsOP+wkMWdQs9oGtDBmzIRDb+BCntMOoaduHwNvA144gBtnm8UH
         yZN7PGCmB7Vza/mRg4Xo1h/WLLHi6Z4qj+FHaSOODu7Nur5xt8mwYvMOnmhVrq0vSbXp
         2tmVRJGSk3Z46tIsrOqkuGm7OZBGbCUAvuKRzf+HxxtZGst+xuoKYavQ4HFE+LdRqWHo
         ZG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091459; x=1790696259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OuS5hhU7FDu24KRBC5uojc0lwdkfcW0XUMfKz4eA9iA=;
        b=fT2xSqQYCzD7b7No7WcO/u5QAn+efJTJS54G8CunRMqDqeMyvQ/2CoJjDfk2Rvy+YV
         b3co/+0TULRFXLXHU+5VlbnOfwdHRlR9F0un4JiNzPBwplSNscEHUPDrNgQMGWA93tAN
         SY4NWO/0O9KBfEQPI15emVa88bK6iqcFniBKehGgog70wQQO+yY/YNDw5F1c/puBkyeA
         X+oXghwz0zfBMYAOPQNGaol7EhZEIliZMTTahp23aE7kWQXZO4ZDLhyMH5vesozeCLyw
         vqu2UbZbnMBfI7a4gltEEw/dPAmSsNEClqHqfyq4ninVlmPLLDhemioRzG8al9ve1PbH
         cMuQ==
X-Gm-Message-State: AFuF++mcD5KB/c/KheAJW+h39yGY78hnFE6WU5ipyao55hxzS68Nvxe8
	wI9c9GNUaKGyPxlSljuV/5qqQIHCmBd/fFPk9dvwIQononZpx8QKy9++
X-Gm-Gg: AYBFou05wZLR1S5cGiEsokMil0YE+JaJeP78+6oJGQY8cG7EoC9Xfir9X4z8f6iAH+K
	vuIZfwn2FBmyp2JxpSCxlHiETgDtoY2A2eQwax6+v9OzBzluEnmXPZuujOtaBtELMDkJ8eh3PTJ
	gFvt2/RypvZslvObci29PRiVJN22dEBEpQA6oBda3KJH8pi0BaYHvPhtrwqZyxJShDXRaWJmUuI
	bGKPRDzvywvCuRBT+qYNAkqVWFRmJLOBlJkWaIRpAzKWQh7y3Qx3PiLuPLPlV5iZXL4eSRPWq+L
	eJPLbHdDz1lDzBlKw503Dr1qWOpIOuZk8p0yJeea8fKspcEBDeSkCGgocqIIssC+0Sbm3ZJnRDH
	9tLI6gslPjsCPc+GJwAK6JPOAvx8y0axax0q+yV/A9+xAm362iYhcceWDKI6uy/uH884Uy1kpPE
	QwhLGP+yey6nl+AGh29QqyL9bhtFwwIl8B9iAaiQxHSwUacd08sA51dZ3csg/KgmYSU7fcgiGIb
	Wxud50qemjXx1QpmMTrEz5EPuq6zTg2LbPItmsM
X-Received: by 2002:a05:6870:a24b:b0:470:e96b:43e6 with SMTP id 586e51a60fabf-48fe435c714mr1114720fac.18.1790091459206;
        Tue, 22 Sep 2026 08:37:39 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48fbedb167bsm1318833fac.5.2026.09.22.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:37:38 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] sparc64: mm: use kmap_local_page() in copy_{user_,}highpage()
Date: Tue, 22 Sep 2026 10:37:36 -0500
Message-ID: <20260922153736.74167-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmap_atomic() is deprecated in favour of kmap_local_page(), as described
in Documentation/mm/highmem.rst.

sparc64 has its own copy_user_highpage() and copy_highpage(), so that it
can copy ADI tags along with the data. Apart from that they are copies
of the generic helpers in <linux/highmem.h>, which were converted to
kmap_local_page() in commit d2c20e51e396 ("mm/highmem: remove deprecated
kmap_atomic").

sparc64 has no HIGHMEM, so both mappings are just page_address(), and
all that kmap_atomic() adds is disabling preemption and page faults
around the copy. Neither is needed. copy_page() is memcpy(). On sun4u,
copy_user_page() disables preemption itself while it uses its temporary
TLB mappings, as clear_user_page() does, and the generic
clear_user_highpage() has called sparc64's clear_user_page() under
kmap_local_page() since that same commit. On sun4v, copy_user_page() is
patched to routines that copy through the linear mapping. No user
memory is touched, and the ADI tags are copied after the unmap, by
physical address.

Convert both functions to kmap_local_page() and kunmap_local(), like
the generic helpers.

Assisted-by: LLM sparse
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested under QEMU (sun4u) with CONFIG_PREEMPT, CONFIG_DEBUG_PREEMPT,
    lockdep and CONFIG_DEBUG_ATOMIC_SLEEP. copy_user_highpage() through COW
    after fork() (with both the child and the parent writing), the first
    write to a MAP_PRIVATE file mapping and COW of a hugetlb page: 3332
    copies. copy_highpage() through page migration by
    /proc/sys/vm/compact_memory, set up so that the test pages were among
    the ~37500 pages migrated. Every word of every copied test page was
    checked, and kprobes counted the calls. No warnings. With a CPU-bound
    task competing, the patched kernel was preempted inside the memcpy() of
    a migration, which could not happen before. sun4v is not tested, as
    QEMU cannot boot Linux there.

 arch/sparc/mm/init_64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..5af327e5aa64 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3072,11 +3072,11 @@ void copy_user_highpage(struct page *to, struct page *from,
 {
 	char *vfrom, *vto;
 
-	vfrom = kmap_atomic(from);
-	vto = kmap_atomic(to);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_user_page(vto, vfrom, vaddr, to);
-	kunmap_atomic(vto);
-	kunmap_atomic(vfrom);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
 
 	/* If this page has ADI enabled, copy over any ADI tags
 	 * as well
@@ -3106,11 +3106,11 @@ void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
 
-	vfrom = kmap_atomic(from);
-	vto = kmap_atomic(to);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
-	kunmap_atomic(vto);
-	kunmap_atomic(vfrom);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
 
 	/* If this platform is ADI enabled, copy any ADI tags
 	 * as well

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

