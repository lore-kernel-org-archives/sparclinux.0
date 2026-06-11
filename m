Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848893C199A;
	Thu, 11 Jun 2026 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178661; cv=none; b=grO2024Xf0+Y/RsJKRLbzSgh/3R+NwKcgbznc6b2wq1Xa7eBCZtMEI9jomQGWSqFkvX8YHQ2KrYWkcKDVJSL8DVjvdMdAgoIhu92KDcEnp8UkVMRo6YsqV1SMeyoutufbzoh1C3irpurCgBBygQ8UTNVx2xMRvCAU4WUc5Llt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178661; c=relaxed/simple;
	bh=n6/IkrP1pE6U3ORyD82yPt8m5GGzvvI8qXmiWzaTI40=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o45xgr+AXUq+/6tnzkESPZXII1uMYs1sZYgQGr2YtjI/Ik6Mk7I88mFZtlzvQWJQGdT0u3Tj28RZeEUxESKFu65Y27GtA2/M3NGj+pGAeT79uDRuD7aBVqnhl7FNUIcBGMAKDwsRjZSaJP6xCxrKjPfQofHnhjN5odoSgZhs8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtGIR5+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtGIR5+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58731F00899;
	Thu, 11 Jun 2026 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178660;
	bh=vCLT3MldI+CnLiU5868dQt6KO3qRHng7qPiO+N2n7OE=;
	h=From:Subject:Date:To:Cc;
	b=HtGIR5+GL916gH/Y7pQUGNkTbN8MuH3ekBiP39HWzBoSkEgMaLAkgnPbnhm/I1L1j
	 X4Iqlnzjk019288Y3jDIkS31lfpOc547SmVUX+8LMufuQINzh6ToOVGHaxsumaqyCY
	 QDj3r3WCdeyX8H1HWFPf0LWkeF/ni0rvSpxonwZm8w7zsIJThgeooc6qUHyh+8O3+Q
	 fdJmR/+S8LilJayClGIGaRBQQ7bTdH+uW/ItfRA+PzKDyabxOb/IhhVw2ickuvSA9o
	 vTs29BkfrR9t08hpDblYLpE4GXht/DHCQCCJ0aaFduvRTKKrHJuI0EId4Vaf8RvyII
	 zBhFcdgUpcoCQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/3] mm: cleanup clear_not_present_full_ptes()
Date: Thu, 11 Jun 2026 13:50:46 +0200
Message-Id: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABahKmoC/x3MUQqDMBBF0a3IfBuIkap0K0VCal50IETJpEUQ9
 97QzwOXe5EgM4SezUUZXxbeU0XXNrRsLq1Q7KvJaDPoodNqiXDZpr3YI0OQig2fGO1RIMqH3jy
 mtwsjPNVDLQKf//trvu8fziCL020AAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

While doing some review, I stumbled over clear_not_present_full_ptes()
and concluded that it needs some love.

Let's remove pte_clear_not_present_full() and cleanup
clear_not_present_full_ptes(), renaming it to clear_non_present_ptes().

Heavily build-tested, runtime tested only on x86-64.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (3):
      sparc/mm: drop custom pte_clear_not_present_full()
      mm: drop pte_clear_not_present_full()
      mm: cleanup clear_not_present_full_ptes() and rename to clear_non_present_ptes()

 arch/sparc/include/asm/pgtable_64.h |  4 ----
 include/linux/pgtable.h             | 31 +++++--------------------------
 mm/madvise.c                        |  6 +++---
 mm/memory.c                         |  2 +-
 4 files changed, 9 insertions(+), 34 deletions(-)

---

base-commit: be18cf77e1e749c6469ff44df00eb026f7c0a365

change-id: 20260610-clear_not_present_full_ptes-df3258baf7ed

--

Cheers,

David

