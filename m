Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179386;
	b=H8AqYuyHhHHha5dD39ewEz5j/Zeyk0jK1stBICXlF3W4LmDHpSysAHnV9A2cKa2ICnj6
	 R4vU3jY5H8Pv76lAZIz5brnqT30nHiPVx93JDdM2+n3s4gVkeP1k04T1s7iSFGVd4mAwN
	 LOGH/w30RrinY2RsZCcT4tFFFyIgnAfXBDQdDtKPIVGpZ+6ypkzavdOXYV2/eqvVHNmw8
	 BsQALuPltXYlGRC14jcUg7IauKKBqzvH/2kOmjenpoTVY8fDtxmIkZgdic7VGBxBm8QPF
	 WOM4O57I+GYuSrhdU7aWNwLw+dc9MuazTAToJIwa1OzkSXuJx41/cXUUK2SVvgzGn/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179386;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9UoZu4LOCR+P05LgNRjZiBqAG2n8MlC20pukDWQyPU0=;
	b=CvT0Ha9dxZVMUhm2jxm55L8KkkG61PE9Ey8ARF7CI4/6Bv750JG3vOkuLkNpQoHIUOQb
	 O8jK2IGhKb/K6ihSFlRwlJo2dBoKs1krJ7jSxuQM+ny/4b0f7WrChS5G1Vc3sZRqUgoQv
	 sG5ZcMV3bcH+zc/C9jx8sc40v8uhpXtTeSqTScU348H+mqvQU4tYVfqF/1M2DZoNc3Sjd
	 3sun53UFdZod02KeddadNZ3nN//3zYWV3k9Xr/iJidKGPF1NUZC++IyEI8o68QmnpX1o0
	 xOjjiTcHfD9h4rjnmhJ55L3j4qQPGeRrjwJvE3q71zWNdSGuqqQOpfLqV1/+ytQ7uRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAXWT2+g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1F606A31A;
	Wed, 28 Oct 2026 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAXWT2+g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91C71F01825;
	Wed, 28 Oct 2026 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793179385;
	bh=9UoZu4LOCR+P05LgNRjZiBqAG2n8MlC20pukDWQyPU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cAXWT2+gQZ82YrnQOeJbjSRGKbLs4lfRW7FFfRDFxaAIOAcI4PS6NZOiYSiQh2wc9
	 ITBa/gneOaJViW5esoOnJCwEcBKOfo1xiqPXthg+nrjWIGQK76SW6iRT2OED/Ur+Hr
	 YO1v0tBq4zVTyMrYanGNSo9ygjAxbsg8ys+lkbNQJ0sMWk/2B1cd/TxH9kJXmuYczB
	 fHeT+XC3xNAsG9jOxXmBISGFZ8/MI/c1HSnRE6QaXrU0mkggDtJZOjhA45fS2YuYCW
	 /GaiUfORHM8nA7PDRof6B1mGieA1UXqwMLFNKtwKia2QqGujtPi5qqFZ/09HjIz+So
	 4+3VTWZH2D/1g==
Message-ID: <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org>
Date: Wed, 28 Oct 2026 10:22:58 +0100
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
To: Imre Kaloz <kaloz@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Magnus Lindholm <linmag7@gmail.com>
References: <cover.1792609488.git.kaloz@kernel.org>
 <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
 <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
 <20261027212610.6798-1-kaloz@kernel.org>
 <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org>
 <20261028091631.8072-1-kaloz@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261028091631.8072-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 10:16, Imre Kaloz wrote:
> Hi David,
> 
> On 10/28/26 09:49, David Hildenbrand (Arm) wrote:
>> But that's too complicated, requiring page table walks ....
>> People running museum piece hardware and complaining about performance of mremap
>> or memory reclaim should reconsider life choices.
> 
> I'm one of the museum folks myself, though more the kind who loves
> running a modern kernel on old hardware than the kind who complains
> about it :) A lot of these machines are still doing real work, and
> these days not everyone can, or wants to, just buy a new computer.
> 
> Some of us spend our time keeping these platforms working, and I'm
> not asking anyone else to carry that, which is why I tried to keep
> all of it in sparc.

Okay, so mremap() and reclaim memory performance concerns make you sleep bad at
night? :)

Don't get me wrong, I know that running new kernels on old HW is fun.

Last week a got upstream Linux running on a 32bit x86 notebook from 2007 with
the snap of a finger. Everything just works (using Alpine).

I couldn't care less about performance. Nobody should.

The biggest problem all of us with supporting old hardware is the maintanance
cost. Not just core-mm, but also things like ad-hoc page table walkers you are
adding we (from core-mm) might have to touch at some point.

If there is no good reason for the complexity, out it goes.

Because otherwise people will push more and more for removing legacy support
completely, and that's not what you want, right?

> 
>> So I'd say, make it as slow as you want while reducing core-MM complexity and
>> not adding more arch complexity.
> 
> With C, move_pte() and __HAVE_ARCH_MOVE_PTE go away from
> include/linux/pgtable.h and mm/mremap.c just like with A and B. The
> walk lives in sparc's own flush_cache_range() and only runs on the
> CPUs that need it.
> 
> B would be less sparc code, but every UltraSPARC I-IV machine would
> pay 13-18% on reclaim for it, so I'd still lean towards C. If you feel
> strongly about B, though, I'm happy to send that instead.

You know my answer :)

-- 
Cheers,

David
