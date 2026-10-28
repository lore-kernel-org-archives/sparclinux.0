Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179068;
	b=Um+do8IBGVe4vyFg3xpxQQAK4/X/OX8impadIsjNbYxYtGgcrlOUMFnuso3whrfvidyN
	 hbOsncMLUkMDT61CaMJhgswYreBlS/GM84sm0WCiwBFrVakimMEeix0QgAikEbQpJ6gS5
	 Ke7c6Dv5JZA2OtDzuwbv1U09o4iHHAOUbaq0xzaXss4wcCgiyTdgsJOlEFMhk6SEJJ2/4
	 7ROKBWinnpVvvNv+rd0srOuz1zdyDp3ed4aRrcHV3pNExB2IwA/ROCKqFlU+S0PYmnvSS
	 mWfoAMAbHMaVm9eOEdXNlSTRjsd6dKOU/ZSoY3VNfovQ59BcB3/iOSaefjofshKMbng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179068;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qJ1TYXbCKeNxi9hHVyccJEj3JOzfrMe3j2ahHPKeTPk=;
	b=xNH9/9t5GZtkD2CLAq0RL2knt2Ci06uwefJWG4fDCGgzla/5rW5tIWKjF9Tx1Chcy59V
	 KFP3qq1TfU4lx7u0Bf9i3xi03/1izISu6lN0VO1waq9YenTc/A7sZ4PNYzo5/SLcqmBO9
	 2c1w4PlNgBjH9Lg0zneNsTyikXT7/IoVBA3aYNc/zTozGRlgX4RiSsXeDvH6SofWZxoiJ
	 TSJsqEeT+b0Zk0Atq5Enq57MTVo/cvkpSAzm3wTQwIldS/OyPq2EBRZesQHIsb7nJUifT
	 EsujjJdP5DYY4etwRPrBlVfLm3k83x9nA51zc6CKLs1lNK7DaG8v422ufbQjaMqBsQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fO5uMrtc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DA606A31A;
	Wed, 28 Oct 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fO5uMrtc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FF21F01825;
	Wed, 28 Oct 2026 09:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793179067;
	bh=qJ1TYXbCKeNxi9hHVyccJEj3JOzfrMe3j2ahHPKeTPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fO5uMrtcIj11vj8Q7CN5JjGyl81WdLw89ZqifB+ey7GTJIaybnJK6Jtk5f5yPBg2G
	 PEXN0HY9CepPiXflll1WDK1nFxakKm+83x15zeJGIsiQT6iPKvZBYFbb0st8qqaHbx
	 tuUv4fupzJLUhk8azNAxFe9X6uFWZtc/lyWkR7S0wl+Kv/tvi73USzhGlmaxzML0Gp
	 mR4LkTqnUzhBOluy7VYLsiLyOLb5bXAd1nBwGIeFKpNZ47xMG/gUiUig46JsqIrDMb
	 AQ0kSmOO45bX0HKcS6V7C9e2bRA2iCParDCxl3s3QcfgEIuc0z0IPPKNOQZrZ++Mji
	 09h88neWQkXFg==
From: Imre Kaloz <kaloz@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
Date: Wed, 28 Oct 2026 10:16:29 +0100
Message-ID: <20261028091631.8072-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org> <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org> <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org> <20261027212610.6798-1-kaloz@kernel.org> <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org>
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

Hi David,

On 10/28/26 09:49, David Hildenbrand (Arm) wrote:
> But that's too complicated, requiring page table walks ....
> People running museum piece hardware and complaining about performance of mremap
> or memory reclaim should reconsider life choices.

I'm one of the museum folks myself, though more the kind who loves
running a modern kernel on old hardware than the kind who complains
about it :) A lot of these machines are still doing real work, and
these days not everyone can, or wants to, just buy a new computer.

Some of us spend our time keeping these platforms working, and I'm
not asking anyone else to carry that, which is why I tried to keep
all of it in sparc.

> So I'd say, make it as slow as you want while reducing core-MM complexity and
> not adding more arch complexity.

With C, move_pte() and __HAVE_ARCH_MOVE_PTE go away from
include/linux/pgtable.h and mm/mremap.c just like with A and B. The
walk lives in sparc's own flush_cache_range() and only runs on the
CPUs that need it.

B would be less sparc code, but every UltraSPARC I-IV machine would
pay 13-18% on reclaim for it, so I'd still lean towards C. If you feel
strongly about B, though, I'm happy to send that instead.


Best,
Imre
