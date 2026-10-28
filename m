Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182352;
	b=pNXlYl+iC3WeVccCaXzWltH2+X19sDPGkhpjN6AC2MtWJDZXB3eA3jDP95Anf3m+2cbJ
	 rWrxjl2TLD7aI8gFIG8oL7v6We5n08E4qmduz5s2Yw12DH6hwiEIE6ToRO4SuOPktzLsg
	 1NVvJ3eeZoAZWc4Z8d0S4Pjpi7E88eDkaQ0oBDyMBwhJDUwENVMIQsZCzWKIWA90wnhhY
	 Lg/cjO/IymSPOSp7zacX9eVT1fGiBuHaHFKNqCl3XJL+W2tzfWj+UrNfPPV4xHTXLpx39
	 qy7gXDTvyeTuWhOkrnw8iAkmNKcy3S2PK7teZIshsdtBX36in7DdeAJmO6xMn/fpTRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182352;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CLByMb/sD+ZAvsSTekY9MbsiY0HI8hmQnYsiCGgVbF8=;
	b=jz3s/oGTRlsYW4V4ZiDj4hyWkIibNf2A8r1oVVDLMupYXxGVY0y3udpzdJPoh6G8B/Cd
	 7D7vSUypi3h7ucR4I37kK9c3vSgnjh9O1uoS3kTBwgQhVhfMxYZ9pTZ4SGutrMzLCGz0+
	 lBK2E5c2x7bN+rpvhhr0SHgZWyL9Qv/anyFYfo6BCGQx79vAU8hjm6Gnb2bIcMDkdNvfp
	 6BkCUE8DtFjxAQz2V0i7Ekhk2OZUhTvtedpqUeQoydfpLd+CKcApg6mPhhGfvL+HrnCTs
	 +oWrmTiqmc5F2a6P3D592sn5NADI23klnFV5Vm3JMUsr2t6IDgQjwnoSVW7SHDAJaYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuBqUzh1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48BF606A31A;
	Wed, 28 Oct 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuBqUzh1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD541F01825;
	Wed, 28 Oct 2026 10:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182351;
	bh=CLByMb/sD+ZAvsSTekY9MbsiY0HI8hmQnYsiCGgVbF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YuBqUzh1l2HE0YDAwpzIJkTNkJHZvsBgVQoXuvebJcvMlK2CX3Qlpb2XrbN9DeQDo
	 JpplHxGpqlnKavhwLga6sy6Q1KnNbnmZ62d51braPNx3KY7zIwhPOMiYz3yJWygjqd
	 jpZz2BEZFPytQxTVeVNOXTowXrcgLAo0Dn6W8LG5SvQtSeTRmemfNSruWtZohfT+x2
	 wgpjsApsEfTr9+2mJ4A5L5Osk6aBEUd1Ku2RFMscCQy7DiT9aLenhF3ZmgzPajDVfD
	 sfxUf1lOGJA4omOJGn+9LZ3kA7suK2pDT1BRy1FyaW77ilM1apyS6jR2LtUoF4GdSv
	 g2wIDe/oD+4ZA==
Date: Wed, 28 Oct 2026 10:12:25 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
Message-ID: <auHI2vYFjpKk_0wJ@gremlin>
References: <cover.1792609488.git.kaloz@kernel.org>
 <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
 <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
 <20261027212610.6798-1-kaloz@kernel.org>
 <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org>
 <20261028091631.8072-1-kaloz@kernel.org>
 <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org>
 <8d4993cb2f2e5c3300514f1e2616e4a101488883.camel@physik.fu-berlin.de>
 <5dac5fd3-c2a6-4e1a-98fa-0fe1936b269d@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dac5fd3-c2a6-4e1a-98fa-0fe1936b269d@kernel.org>

On Wed, Oct 28, 2026 at 11:02:17AM +0100, David Hildenbrand (Arm) wrote:
> On 10/28/26 10:58, John Paul Adrian Glaubitz wrote:
> > I don't think it's fair to make the kernel exclusive to very recent hardware only.

Nobody's making the kernel 'exclusive' to 'recent' hardware.

It's about overburdened maintainers having to deal with museum-piece hardware at
the cost of literally _everybody else_ who uses linux.

Use an older or downstream kernel - problem solved ;)

>
> "Very recent" find the mistake.

Exactly...

>
> (sorry, I'm unusually grumpy today)

Justifiable ;)

--
Cheers, Lorenzo
