Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E832BF43
	for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145510; cv=none; b=I7aqvBINak2Jrz7o3bK3tY/a7v/u7A/PtOsmh4XUKKoKn7wo0O58/cTTVMkCH+5PbVNw3fWBqB7CRpX8D8WahJp5614ngDv93gV7VnEEkfKVNm5WGzzFlx1bvQPuRe+PIduovWc+8qt7XvbbMYSjEL+BlQplKxk06AcIhYCzVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145510; c=relaxed/simple;
	bh=6h4/cg/hBitAahRBHySYeWkoinWztbgolq8rszgHKQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoRjtcNk1dYFvf5+fHHXyaOMqPHhy8ad9/ln+M+BAY86GEFNohG3TQXXH3Ktm7VhUAeVcpoXH04C9PI4pGf7BQ0tgxrO2GwQnlsWec89NkbBFrzwhdUWR+nuTlOKf1D/f9n6L2l6zj9L/xeUln1MYLKxm7+crkcQ8p2Tmwwcbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X52R/YgC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X52R/YgC"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1858574b3a.1
        for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766145508; x=1766750308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M982etOTK0HIgjHmN9suIouTW3J7DDmDwah1Juiharc=;
        b=X52R/YgCWfxQlVs9+K9OsojJ3zbxwAp6PlfY5WLuYVUct0yhQU7FX7qkn1xtaE1BQn
         BYLy8AZOinVWpUzjcAwgjX9DGN/DP9FrFSQXikvUxhPQ66U2m9XW2iNFXRxSm9SDaYGF
         vLgDMKG8pROaZVytM4BqXhGn6gbL2/906US/tXDZj2lb+nr09xspkK68DChT1PqhFx05
         g9iTiVsdVpEa+tF53KN0lDF6YIJQZGfuJwLMZ328Pd1FVk9EFLdBst0tCBl/1Tn4DtqC
         AUiPyaoXE2FeD5/zFUqwINqL7UH7VxKzjjmYmNoYPznWEKiSJxaIKFtLlPWdLgSrN+IV
         J5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766145508; x=1766750308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M982etOTK0HIgjHmN9suIouTW3J7DDmDwah1Juiharc=;
        b=laJFkl+jE/biqii7FLyjRuyit+LkqoPMw4sqxkCzS9kZB96NYSdcJBJCLM6mnHCLo6
         AgOwGxyoEJI3VRok2d6Ni/eImxg2Ir/ID3i8Ia5OoO4PMogkMBFZajmxFqT6uLx3XyG2
         m0CCQ6uXgKvYxFDVlpK3x0NYmgYGdjVseJzgGkemWGQMJ6FP6Xpsu7swIl04malgamPz
         sYFqRn/OFcfMV+EiIY547xcKra8X+0QB2Ho28t9AtUBliGCj31SeuMCbJseJzVBcDRBg
         2nax3/j+3gIkho8NvbzzRdYV4KYYoJSxHZhC6k+GYoXfvf0fo5/dLO8eWesA/wGvN80g
         N6aw==
X-Forwarded-Encrypted: i=1; AJvYcCVYtnfiU1nWMm1HkrLyTSBNI5pSXIKBypsEUnuuYaEE7SOJY2LGMRMd8dkbi8lak3BpXdLgBcSDtKVT@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzGH2rz2uTAW9XlJUW236on1VZCFKp9rcpAbzcGx3iM4yYEjf
	JngGAuPk3bGzkKTqyUDHAnEogbZYNV5PH0P85O/0WJKjNg3yBIZq58WW
X-Gm-Gg: AY/fxX4isVjuMSYFgGAhAR5nIYwobpK1oM1lzr8bJTR1QJQ3x6v+mzZr6fU8D+7gMjA
	fBe3M9XygA2cEjm41ZfRV0w/aCDetHCv3CxgI01PFFw9nhEcgFlfkFu8CyCwSy5dM+YLNF0e8mq
	SOycbGYbjtoz/Rf27l4BTWUNhBVuhA9M/O+lj0Q2MwZsBIcfyEyBbk3HwIw8fuRDWgNZSgFkXik
	z9F3qohVBqGX36SVxe2Xl2y/aImb53sXpSXNnUiK7FWqMqiQFRubJWBOFsJH3VwWDi0sCaAaSE4
	w0YNIUtn0/eYFN5nh+Upy6JyexnDXw9nQRbNp6+cFpKKhuwck9ORpxGiSi5DM1CkDwP4vt4dh7Y
	AatxSP+e+G+mS81IzjkvOe+FkZ7/9meJGablaMLPDBR5wSFu+tPfVNcqLb+ubkmu0jCy/fd7z0w
	Bvmg6jc+CvqHGIC8L6KYf+7QlKdSL8c3h6FNsdgVxN1g==
X-Google-Smtp-Source: AGHT+IEgMBfun3xWsqk3fBKYqgWJUFSdZSnFF+VmVblUrbz1oZvITOpgUCt5kp+9ojxYz1Jr4XV3Nw==
X-Received: by 2002:a05:6a00:4295:b0:781:17fb:d3ca with SMTP id d2e1a72fcca58-7ff648e71c8mr2512389b3a.15.1766145508304;
        Fri, 19 Dec 2025 03:58:28 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm2258560b3a.21.2025.12.19.03.58.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 03:58:27 -0800 (PST)
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
Subject: [PATCH v4 0/3] Generalize vmemmap_populate_hugepages to sparc
Date: Fri, 19 Dec 2025 19:58:09 +0800
Message-ID: <20251219115812.65855-1-pilgrimtao@gmail.com>
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

Link to V3:
https://lore.kernel.org/all/20251218174749.45965-1-pilgrimtao@gmail.com/
Link to V2:
https://lore.kernel.org/all/20251218130957.36892-1-pilgrimtao@gmail.com/
Link to V1:
https://lore.kernel.org/all/20251217120858.18713-1-pilgrimtao@gmail.com/

Chengkaitao (3):
  sparc: Use vmemmap_populate_hugepages for vmemmap_populate
  mm: Convert vmemmap_p?d_populate() to static functions
  sparc: Remove unnecessary whitespace

 arch/sparc/mm/fault_64.c   |  4 +--
 arch/sparc/mm/hypersparc.S |  4 +--
 arch/sparc/mm/init_64.c    | 53 ++++++++++++++------------------------
 arch/sparc/mm/io-unit.c    | 12 ++++-----
 arch/sparc/mm/iommu.c      |  2 +-
 arch/sparc/mm/swift.S      |  2 +-
 arch/sparc/mm/ultra.S      |  4 +--
 include/linux/mm.h         |  7 -----
 mm/sparse-vmemmap.c        | 10 +++----
 9 files changed, 38 insertions(+), 60 deletions(-)

-- 
2.50.1 (Apple Git-155)

