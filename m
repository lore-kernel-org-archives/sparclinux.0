Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5212C0F68;
	Wed, 17 Dec 2025 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765944845; cv=none; b=dLRyNzE/+AR6VKS+Q4b90EfCCTwFcgFejRuNY/FEv1DjY8PNt1hpVvYBzGtdIyiPdT+Sxt0VGMYyCYR4Ji2Xu7sfK2NzaFOIbwmq0KVjzV1XUi4VCVRp5JKysWgPGbGgX/VggnzLdqjst3Iy0+CXAKKpNSda62f+7+kuX7NqC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765944845; c=relaxed/simple;
	bh=xU2trvapXnk7g5CtACkCj5ikoDQ/txcQUif1mO1cIY8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jDnw8AyEa5Q3S4QEHSQX9mVMw5sE2CVAzuaNncx3G+8fBMNJsarUhSF3gpWxfhGqhtazFV5J+koZOtFNC1Mlte0kovwbrBTAY0edEQy2i/J2aw+wbP3QwF3qVSXY1F0x+0Nxmot6wTZx7AjLhWS1lFT+E1goh9TV333a3IrlD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mObMGKaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mObMGKaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB41EC4CEFB;
	Wed, 17 Dec 2025 04:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1765944844;
	bh=xU2trvapXnk7g5CtACkCj5ikoDQ/txcQUif1mO1cIY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mObMGKaHzs+oIi98uFJNPKFjcIbwG14MyPdinNriP9aRfBOmrP9YgUR0U5RY50Jcg
	 MRZ/eN62bquBtMDDTcWo7ge5Ui+mwLmddzDbSz+GfDkXxY71DhMOB9iezvOgCfm+sh
	 F57lldv0D0XP5sN73LEmpLArzoS8Y23dHH7bFz7M=
Date: Tue, 16 Dec 2025 20:14:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Alexander Gordeev
 <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, Anshuman
 Khandual <anshuman.khandual@arm.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, Catalin
 Marinas <catalin.marinas@arm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn
 <jannh@google.com>, Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, Venkat Rao
 Bagalkote <venkat88@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Will
 Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v6 14/14] mm: Add basic tests for lazy_mmu
Message-Id: <20251216201403.4647a4f9861d3122ee9e90d7@linux-foundation.org>
In-Reply-To: <20251215150323.2218608-15-kevin.brodsky@arm.com>
References: <20251215150323.2218608-1-kevin.brodsky@arm.com>
	<20251215150323.2218608-15-kevin.brodsky@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 15:03:23 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> Add basic KUnit tests for the generic aspects of the lazy MMU mode:
> ensure that it appears active when it should, depending on how
> enable/disable and pause/resume pairs are nested.

I needed this for powerpc allmodconfig;

--- a/arch/powerpc/mm/book3s64/hash_tlb.c~mm-add-basic-tests-for-lazy_mmu-fix
+++ a/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -30,6 +30,7 @@
 #include <trace/events/thp.h>
 
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
+EXPORT_SYMBOL_GPL(ppc64_tlb_batch);
 
 /*
  * A linux PTE was changed and the corresponding hash table entry
@@ -154,6 +155,7 @@ void __flush_tlb_pending(struct ppc64_tl
 		flush_hash_range(i, local);
 	batch->index = 0;
 }
+EXPORT_SYMBOL_GPL(__flush_tlb_pending);
 
 void hash__tlb_flush(struct mmu_gather *tlb)
 {
_

