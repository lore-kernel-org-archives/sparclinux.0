Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF31299929;
	Tue,  2 Jun 2026 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375542; cv=none; b=Kww7U4HH2diiF4PJYFakhb1WpEAWrC8X4oe0+zFc0oJb9HmgUMUZ3QLyx6vUs204ssNHSu9iZmwEdE+eWCrbmZ3XLQIxoouKttaKzGAKxvLIu667uRDNXzJo8tYnlulvkdC/rLpRn6RxzWzCPROMJWIxu0JKeGXK4jTshh0M8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375542; c=relaxed/simple;
	bh=KQRZx6klhnDitUGYNJxW0ZAtlK/jCtxqgfZx4aT+ouA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGYbeDhAuN7Nvv6p26j68/GnGRP7wCsnS0inLXInOTKpHhKdOaswrQ2u0dFXbbdYny4qGNh3kFEi1otpuCKcpcr++2Wbb7TBesOmvU7GZuoO6NPrlz/godv/t/kwqDWjj/2wM+MMjTTWXja3apO7T8wsFny9s1b9RiP/uqyGzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+z0zlI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+z0zlI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB71F00893;
	Tue,  2 Jun 2026 04:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780375541;
	bh=RI1EMaQf2aC+jwKCogVgIAXfxFKnj7BpW+hiYAKrFZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m+z0zlI4cyMGOnMErPfrIMqf0iWtdk7EX1MfOrHUoTqiO7tPcBlCZpccxp8Un4k54
	 d2qBnpIBm2HfPas5jkKo+5CiqJTc0hHlU6AGKeMoGVU1Q7onXg6zaSw4wfyk+8qynC
	 fOpFEFW8m8wmylq4C3Q2V2uuIW7bdmjx3cp2g6nLNRMD5/JGUisgSZxJcEUNv0i5ei
	 bBOxMYGMiY2f/W7BXDrfjO7bVl/eWwFhDqSgdpRZjbfGCWHOr6ep2sW/mNsYJZ+kRn
	 AAgXzr10EYrOk7kJVfNJWscoQxhNKbyolztYkQYSqJyOsapQn/9pfNt4IyVsGxoWUr
	 ABHGwIkedbhLg==
Date: Tue, 2 Jun 2026 06:45:32 +0200
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
Subject: Re: [PATCH v3 4/5] loongarch/mm: drop vmemmap_check_pmd helper and
 use generic code
Message-ID: <ah5f7NlrmO0bw-pX@localhost.localdomain>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
 <20260601084845.3792171-5-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601084845.3792171-5-songmuchun@bytedance.com>

On Mon, Jun 01, 2026 at 04:48:43PM +0800, Muchun Song wrote:
> The generic implementations now suffice; remove the loongarch copies.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
