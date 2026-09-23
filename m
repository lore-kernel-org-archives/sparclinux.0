Received: from mta1.migadu.com (out-122.mta1.migadu.com [95.215.58.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362847B438
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154796; cv=none; b=p3titXAWDrYwrjc0u6umOgWHPRuqJ1QTtrr0FGFODBxHcTUeUORPXr0XoX19th37nEQJp1oaQ4RM4tHVbeSkn/LwqlvBWOQY4ulWbQVSVdXLvIa0uBlWacNHLB45aU34ZTZSiWi66RorowIH/DFxmikixzsyVQCh52H0EA0pIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154796; c=relaxed/simple;
	bh=MqDx2uNPV3E/fiWMTSd/dV4UjPLeNNzFK2C1QLD5Gus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVaZBfgHXf74DoU9YpcGhNzVhJ2moNI5Jxdvn2wYpYwhCHEpjPqDpI06NJoyIyv45B2eHti+QDEliuHFF9IAGURTp4Zj8jo1rAfiySHojK1Utuhg8jsg4s2Bn6kkYO5bSEooFCQsWJXkkbbMGBim2qNUkpuK5Gy9knDmKcI5doM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OkT7FwLe; arc=none smtp.client-ip=95.215.58.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OkT7FwLe"
X-Envelope-To: sparclinux@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MqDx2uNPV3E/fiWMTSd/dV4UjPLeNNzFK2C1QLD5Gus=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790154792; v=1; x=1790759592;
 b=OkT7FwLecF5Vnko88HIGFAdbgD8UsyorsLInXEi+N4EjbPWU11yRf0++EDHrmR9KbS9/uhPz
 M1wgitW0mKUAExUQwc4F9NgSJXJ1tmSkKvMuCfWVBuddxYvQawmlPaPPWgv6GXYu8J51lfyxrsj
 T62EsGHBw15brw3pvxgu8s1U=
X-Envelope-To: sparclinux@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad223138143f3bbe;
	Wed, 23 Sep 2026 09:13:09 +0000
X-Mizu-Trace-ID: ad223138143f3bbe
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-coldfire
Date: Wed, 23 Sep 2026 17:13:03 +0800
Message-ID: <20260923091303.19671-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:38PM +0100, Lorenzo Stoakes (ARM) wrote:
>Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
>
>Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
>that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
>RCU.
>
>The page tables occupy a page each and have no odd semantics, so this
>change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
>m68k-coldfire, so do so.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Yep, ColdFire PTE freeing now goes through tlb_remove_ptdesc() :)

Feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>
