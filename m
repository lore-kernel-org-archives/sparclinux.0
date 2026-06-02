Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6032DB79F;
	Tue,  2 Jun 2026 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375494; cv=none; b=rEFi1IXzv+MZub5f8TlXY6upXsb0pbVoNfIybEhFANwEf911GPobD39cwesIaVtcEohTj3/PpDYWV9a0Kda+tOMUDLzfw9mnB1fwXLjq4+sRXd4erVy1qh3bFRFCYA/hxV0z8dm1665xsyt8mbADRZcJxQAtH7yKZ/fR86NilEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375494; c=relaxed/simple;
	bh=9GKpn4Ku6E8ngEz/wA9Q9guU6n1ycVedbMdCM25yelE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY0b3CbK15VAmAH/SlGi7rQFq7uX2O/wEbQzUnB45AV10SZT+lvC/eK2jMAu3Kejd+/26tXsX6E22WN2lsfg9ucPaJmXRVzh4UHsSTKF5RjKRflq44xhHfnFBJnrxXXOrNQxn0QVaX8VRJJhDUEGoCnreLEyPoVfMHbJ3QMpR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dscgPlEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dscgPlEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F821F00893;
	Tue,  2 Jun 2026 04:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780375492;
	bh=HBcSho0hyTBOiz46tMOdOloLT1LDWsfZliq97z/1xao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dscgPlENCGbnky2yH/Uf26BENDpdZmCNYagwcRFJUhTkMydO+/0JasfnOfb6k/Pz8
	 5Kzg5CgZ3DbhA3mk2MbFQw+6FBTCNen++P5Ul6oWqo4nLZ0F8LX+Or0ibTfPSHM5q7
	 VfxD+jIYyPQaIgwUc0Qq+IGRrA8unrZIUZ/goWhu4AnrDEtaHvsU8DR4APQe89ehJI
	 Ef7lCvRcfISQj6222jsW7gGQ3StuP09wXeRJcybPZyOM3plqWfZQkRzqMEQsgXqOBp
	 lYD3IJ9ivvNM271iJK88fZ/7GtgwWeYa7TKfKYoD+b1skZ4AZdek6Gtue2J4+n5NIg
	 jja0YigGJim0Q==
Date: Tue, 2 Jun 2026 06:44:42 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>, WANG Xuerui <kernel@xen0n.name>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 3/5] riscv/mm: drop vmemmap_pmd helpers and use
 generic code
Message-ID: <ah5fusGeBmwsZuIm@localhost.localdomain>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
 <20260601084845.3792171-4-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601084845.3792171-4-songmuchun@bytedance.com>

On Mon, Jun 01, 2026 at 04:48:42PM +0800, Muchun Song wrote:
> The generic implementations now suffice; remove the riscv copies.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
