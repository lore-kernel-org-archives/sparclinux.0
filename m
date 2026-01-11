Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B322689C
	for <sparclinux@vger.kernel.org>; Sun, 11 Jan 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768117507; cv=none; b=dVWutr1neK0bPe+ry8tQ8t9InzWAi77BL/yMN6Ou/B3huU204W8pEDLVmCvBiYwn9XU8uXka0k8R0kFXkhFd1FJoS6zDtXB0ejYZ5l6/C3eWDkz5y0O8soFxiwM9SHZJlzbCFyYuDD9ARUoyliTuRPy6sw4SsyzQszmqJ5ViZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768117507; c=relaxed/simple;
	bh=ctyjlPxIuBNkcBTTRNokGW3gITDA5OLUAodp7Cb/9ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=De7DxVTypRNAvkUuxkGz41eeYodhWYphNelYDHAYQ4I/d2Ci2eCIYPrTzb8KLCcXDRr5FXlgfsx9s1IIi4Z+KuhvaFcN4M7OHqf9qMYEDkb5yrJ/As8rymQUokxRNJRQFGJnNNmY/uBUvrbzDW0vILa7Vxkru/wWj9w0bDN5+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGwHcRrw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGwHcRrw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so3509117a12.0
        for <sparclinux@vger.kernel.org>; Sat, 10 Jan 2026 23:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768117506; x=1768722306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91Pn9D4Lx686aqQc6EvNJCkVLTacmBgG0CY6/mdSfQM=;
        b=VGwHcRrwD8+jSgGyLu1XxaALpOjvUWRvowbRwlxi3sAgwrRUdXFn0YN8u8kIINJl16
         7GYiXaouRiEvGfpKNwa5IF4f1ONav70ZP0K8TcesJkiYGfPPVu/w4dP6lDbd6Wz66FDW
         HNMtpEb0La3yqAz9cbDaFFWhmuhRKGQ5w/Y1BEGPST8RcKyHeQq3avKnVcgY5fEgf77D
         v9ZSjUa/BFWYHFYfC4Jp+AN5lo0SBV30lfg9RGksCvyUps1PmMVGx6iIj8pMkGy57l3C
         rCnKx2qbdRmKY15hI/JERV53AjO/SLfQ3J9L5BzwNh6AiOEjzhEKKueGZIAPqlifp3It
         DvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768117506; x=1768722306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91Pn9D4Lx686aqQc6EvNJCkVLTacmBgG0CY6/mdSfQM=;
        b=ui2t/Iw+xHMnQZ+pvQiZjc/9hctmEU4pqlXGrKDzeGlZQvyOcucUU6onP7ojIL3LgW
         6eguHuKPhnd1kk3OUAGSmgVL3QG0aBiFY7Rv+BbYnLIZ2DoiKzuvymmS8wz5Cv4JDglz
         uvZOfPB8ZylMozVRYXbEpfaajoBmZbqy8vwvXM05SzUQCaNnFw64bwdtZOoIBch7dNCK
         3nu2DLmwHxq4RnF0jL46EByjVnBHjS+AwFMt9FPeloUSziCkTL6PAmAmmKidEGgxtMB1
         H4HOtFJpqTKZJoEqquhOOykaFbFEa/kSBDQEDdp1UvmHDyJP4kH55YZZF1c1RoWr9GbH
         Ns8A==
X-Forwarded-Encrypted: i=1; AJvYcCXNM0A/Bya3/sTmcPZjv/uU1zt0H0truPFLLF9qzRnOi15RVMaY1KuqQfFdygeQ5pGxP5D+OBr+fB/A@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzC8JmucPse9roDHtoS3Md0mFkCQCXg5aVByMajH0Q+lxn9+W
	UXQQjBpkVk3i6qCD+GeUz1mpJMDZe9gCB1ZaSpqUC1BBDGjAffycPn28
X-Gm-Gg: AY/fxX7mbkyTW7fJnI2HqYVffqV+6KUDxNTaBjs+cAMWG/OJH63Uqsc7eiEYYmk6QG3
	uUjxRcTrafkwmsniaHMmUheVWCGbv3o7ZV5AzNXwyDzkXbL07uOw6Icqz8SqBqCFJEU7C8tQWSs
	V+ZefNuUJMukDObo83sSHAJSkI5MIOcp5X8sOwyYQHFJnfE91iS5NKi+ids91VQqrY896bJjah4
	2zdnPUvDr+Nn+DHc0EPSOLibYJulzfCCGiiNkIKuDbNb8BpK3eCynnGurxQ4q3M2Y6y7tHyNGFW
	JTlh3EnlRQZFbZttqzL0qJhpAGmvO+0MGuoxoheAAxv9KivgpENoEORn1oSzbqt/7Jek0zf+y22
	p6l+wI876aYUcsxWEHOzqGoLCMBGmuqjBuBiE0aEBPirPgU1nD2aJ18GD6sPqhYRQPydL+73lrw
	oMzU8GbSvt5KWFE4DM93RoIM95KTcES8FwtEiHb8+a
X-Google-Smtp-Source: AGHT+IESX9jR3Ww8200BgX5GPnSMc0XzoGJnxCyRuzNGJw1YTB4+hhScgEv6qazvZYWBl4/2/rr/tA==
X-Received: by 2002:a17:903:1a8b:b0:2a1:5785:4417 with SMTP id d9443c01a7336-2a3ee487487mr140445715ad.34.1768117505862;
        Sat, 10 Jan 2026 23:45:05 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2f8asm145284015ad.57.2026.01.10.23.44.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 23:45:05 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Cc: kevin.brodsky@arm.com,
	dave.hansen@linux.intel.com,
	ziy@nvidia.com,
	chengkaitao@kylinos.cn,
	willy@infradead.org,
	zhengqi.arch@bytedance.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	chengkaitao <pilgrimtao@gmail.com>
Subject: [PATCH v5 0/2] Generalize vmemmap_populate_hugepages to sparc
Date: Sun, 11 Jan 2026 15:44:51 +0800
Message-ID: <20260111074453.66728-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change sparc's implementation of vmemmap_populate() using
vmemmap_populate_hugepages() to streamline the code. Another
benefit is that it allows us to eliminate the external declarations
of vmemmap_p?d_populate functions and convert them to static functions.

Since vmemmap_populate_hugepages may fallback to vmemmap_populate-
_basepages, which differs from sparc's original implementation.
During the v1 discussion with Mike Rapoport, sparc uses base pages
in the kernel page tables, so it should be able to use them in
vmemmap as well. Consequently, no additional special handling is
required.

Remove unnecessary whitespace from sparc.

Changes in v5:
- remove [PATCH v4 3/3] sparc: Remove unnecessary whitespace

Changes in v4:
- Add commit message
- Add verification that pmd actually maps a large page in the
vmemmap_check_pmd function

Changes in v3:
- Allow sparc to fallback to vmemmap_populate_basepages
- Convert vmemmap_p?d_populate() to static functions
- Split the v1 patch

Changes in v2:
- Revert the whitespace deletions
- Change vmemmap_false_pmd to vmemmap_pte_fallback_allowed

Link to V4:
https://lore.kernel.org/all/20251219115812.65855-1-pilgrimtao@gmail.com/
Link to V3:
https://lore.kernel.org/all/20251218174749.45965-1-pilgrimtao@gmail.com/
Link to V2:
https://lore.kernel.org/all/20251218130957.36892-1-pilgrimtao@gmail.com/
Link to V1:
https://lore.kernel.org/all/20251217120858.18713-1-pilgrimtao@gmail.com/

Chengkaitao (2):
  sparc: Use vmemmap_populate_hugepages for vmemmap_populate
  mm: Convert vmemmap_p?d_populate() to static functions

 arch/sparc/mm/init_64.c | 47 ++++++++++++++---------------------------
 include/linux/mm.h      |  7 ------
 mm/sparse-vmemmap.c     | 10 ++++-----
 3 files changed, 21 insertions(+), 43 deletions(-)

-- 
2.50.1 (Apple Git-155)

