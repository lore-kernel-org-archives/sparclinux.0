Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA092FFDC4;
	Tue,  9 Sep 2025 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396456; cv=none; b=tzmY8raIUR2wSvdMekSExXclOPLKjHBRiFEFuAaAoT8W4e/pZBifdmr5foVitrR3AQeJQfDtXS2fsKrupBTNdkprsBnvJHvPEMt+6BdoBbKAN2dWNsFKOFrk5W4StqGSz2JjJi06ihDu8wQxrOubuTNSOk0HYrY1lB4GUodguIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396456; c=relaxed/simple;
	bh=fLT6sZq3hOuocdqB+Er3MIxGIa7A226lDCyWybWeKb0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fiZs4K3uKTibOqCIaYCvlpK3BAXdRcalUf3VshhVZb96C2UfrvNLcO/m5m4eAaPLZC9LW2rEocqKgTE+YorIpSiTblQi2bJpd+0PzU6Kn4Ya81xnKXHnn0qJSLbsYsZDXzr1AASFOSSKKXqy7QXe51qeile8pHwGxqyLc/ylf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ac3AtU0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ac3AtU0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0D0C4CEF4;
	Tue,  9 Sep 2025 05:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757396455;
	bh=fLT6sZq3hOuocdqB+Er3MIxGIa7A226lDCyWybWeKb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ac3AtU0MqGUoC9Eky+9KyLtx9biLH0jbhomUAhOb9ruR7c2j0fSSNnyF7J5pqgv3k
	 foKu3tqX/cVrmmALEDgQok2HJxXlYlCuqYu52g6qJkaq/U2HxlfxN2JIs/wIPe9xj/
	 lJgOpn+VQzJMFZkYputFzcFbXsTrbwF4GLqtj+KE=
Date: Mon, 8 Sep 2025 22:40:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Alexander Gordeev
 <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
 <mingo@redhat.com>, Jann Horn <jannh@google.com>, Juergen Gross
 <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Will
 Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 2/7] mm: introduce local state for lazy_mmu sections
Message-Id: <20250908224054.0a1969b493d8a837addd782e@linux-foundation.org>
In-Reply-To: <20250908073931.4159362-3-kevin.brodsky@arm.com>
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
	<20250908073931.4159362-3-kevin.brodsky@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 08:39:26 +0100 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> arch_{enter,leave}_lazy_mmu_mode() currently have a stateless API
> (taking and returning no value). This is proving problematic in
> situations where leave() needs to restore some context back to its
> original state (before enter() was called). In particular, this
> makes it difficult to support the nesting of lazy_mmu sections -
> leave() does not know whether the matching enter() call occurred
> while lazy_mmu was already enabled, and whether to disable it or
> not.
> 
> This patch gives all architectures the chance to store local state
> while inside a lazy_mmu section by making enter() return some value,
> storing it in a local variable, and having leave() take that value.
> That value is typed lazy_mmu_state_t - each architecture defining
> __HAVE_ARCH_ENTER_LAZY_MMU_MODE is free to define it as it sees fit.
> For now we define it as int everywhere, which is sufficient to
> support nesting.
> 
> The diff is unfortunately rather large as all the API changes need
> to be done atomically. Main parts:

This has a build error:

  CC      arch/x86/kernel/asm-offsets.s
In file included from ./arch/x86/include/asm/irqflags.h:102,
                 from ./include/linux/irqflags.h:18,
                 from ./include/linux/spinlock.h:59,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from ./include/linux/crypto.h:15,
                 from arch/x86/kernel/asm-offsets.c:9:
./arch/x86/include/asm/paravirt.h: In function 'arch_enter_lazy_mmu_mode':
./arch/x86/include/asm/paravirt.h:534:16: error: 'LAZY_MMU_DEFAULT' undeclared (first use in this function)
  534 |         return LAZY_MMU_DEFAULT;
      |                ^~~~~~~~~~~~~~~~
./arch/x86/include/asm/paravirt.h:534:16: note: each undeclared identifier is re

which gets fixed up later in the series.
