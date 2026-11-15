Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753619;
	b=RKnAvgHsYEeRLiMhneUIu5HmzYu2E9Kvgss4qFv/hxsF0NwlI8Pv5xOVjV5fUVZWkWir
	 gHgBWSR9+onfNErOGL/UP6K8CyEPTgqNHEf+DbYNXdMYpE+0Hbpe4/Wo4jKJ5z5cS50Xp
	 HrldGhANAwSoc0HXyIIFymBoEiO7Y/+vj5QDksYtLRl0ha/gNwkdolHd4QQhqMGv9N3qw
	 4hFXcnYiZ5UICjuN1K9VmbWZY0236XOCjHfyF/tQyUg/HDnLV4LL9Sl7UHAGNslJEBxtg
	 vlcgez+oNiX40unhA9rSp0vzgLEdh1KxBYkro6cC2dYDXyseaPZxW9yNF14rtXOXnXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753619;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rjawh58rti+jKBLk0/ppPYRHWbAG5yPpw6+MQJTga+8=;
	b=ZmomyvMeRkxTcSZ7adXz3bX6QeB7DDBMCNmG+RmwOk4aLFPzJpl7n9lsZz/Zx8u6Vi+o
	 Wh3dlRLI+qniUwDjdPUL6kwcIbqPzRRRBFyK0ABigG21S74CYaxhjydsDMI2mhBrNwzSe
	 XXyQorKGOqckQlPwLIOQSJo8cUreI+6Zb51bk4cI1KLQgw9IK19czo/CRdys56KeWnuHG
	 huxy2pm6nrCAy1bLI624VuTPeC+JYJL+iZnfjfaiey5JNYo2vCz189hZOM0+V+QBIJFHp
	 JLSNMbsvR6KZDD9g2Hn4QB9p0zerw07Prj2ClgaB+JS/6QXxfrZjEyYvsrlqpBFIlBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WI2YaRRX;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6580606A31A;
	Sun, 15 Nov 2026 14:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6580606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WI2YaRRX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081DB1476;
	Sun, 15 Nov 2026 06:40:15 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A3443F85F;
	Sun, 15 Nov 2026 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794753618; bh=NBPLKK4FA8uDkoZ+Aw6nSyKDd3zpjuVqz60XwsXS1Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WI2YaRRX/vEKLYZo0sH/ZvQ67Lxez/RMGHJZPvvcKO0IXlYiRqq6FXCB0FZGHFxzj
	 4J8oibQ4P5hRCHqRjYdaNmAL0QhMGVTU6XuO69HA0Ugliv7AZRToR2Z0fWhL9BYrw1
	 eRdCn5SJhsPNF3/z5oNe2xhseQJpfZqC9kFZ5g60=
From: Dev Jain <dev.jain@arm.com>
To: david@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	davem@davemloft.net,
	andreas@gaisler.com
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	baolin.wang@linux.alibaba.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	anshuman.khandual@arm.com,
	geert@linux-m68k.org,
	sparclinux@vger.kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v4 7/9] mm/memory: use set_softleaf_ptes for uffd-wp markers
Date: Sun, 15 Nov 2026 14:39:02 +0000
Message-ID: <20261115143905.3045084-8-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115143905.3045084-1-dev.jain@arm.com>
References: <20261115143905.3045084-1-dev.jain@arm.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use set_softleaf_ptes() to store multiple uffd-wp marker entries instead
of open coding the batched setting.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/memory.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5645f42c7152d..4a5537b02850b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1698,14 +1698,8 @@ bool cond_install_uffd_wp_ptes(struct vm_area_struct *vma,
 	if (likely(!arm_uffd_pte))
 		return false;
 
-	for (;;) {
-		set_pte_at(vma->vm_mm, addr, ptep,
-			   make_pte_marker(PTE_MARKER_UFFD_WP));
-		if (--nr_ptes == 0)
-			break;
-		ptep++;
-		addr += PAGE_SIZE;
-	}
+	set_softleaf_ptes(vma->vm_mm, addr, ptep,
+			  make_pte_marker(PTE_MARKER_UFFD_WP), nr_ptes);
 
 	return true;
 }
-- 
2.43.0

