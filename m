Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12F3B3C05;
	Mon, 29 Jun 2026 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767340; cv=none; b=d+FDTohmXGYUH6H+9AYDCVmD3vpXGLq5CcnNjVfRYnXqX9cEV6ARCWsSQNCEDaA3+bNUOM3x9Z8QtiV8iMUSeo9tokVo6PGC8QfcZRK3t/rKKfL4XwOc8s01/j3+tiPBkgGc47HyPEUsR+FfCB5OGQ+Bp5iw3kEOwRVMYpSl8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767340; c=relaxed/simple;
	bh=CpQxhn1X1KGgUW8KpCRdSQQ1xxzUaIIcAgcZHsE3ICs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NXVig2Kwgh2XMEDqA8oh68zta4VqF9FkHfvm2X/D6G7tNSS03yDs0vcgG+F3d85ZzL0N+M5VVwcLuYAfou7ydBXwMVO+i/joNlU6fz46EokUu8HjYEssBNfMSq4woxuo4aove5Z1G1TTbmxeqmCqnZmY/aVqe1KcwaoAARcfD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nd31O+T4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nd31O+T4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D73A1F000E9;
	Mon, 29 Jun 2026 21:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782767336;
	bh=Qg0jkovDHOQp4wjev5J5mR8Y9cw9SpdhVKuP5+MzNkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nd31O+T4SwPacQvW01Y4halbn4fnaEYGVGkOPWbyakLXiuuOyznSyd1J4OXuTSTEW
	 nc4LWPrEZl+CrzggOcBD8dnto3D45scDybFn+sPq91x+LvE/sQxZPCJONY14Dh2TNm
	 chJh92007puaNUQwyI8du3eTxwY5wQS5lrgW1Qmg=
Date: Mon, 29 Jun 2026 14:08:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jann Horn <jannh@google.com>, Peter Zijlstra
 <peterz@infradead.org>, "Oscar Salvador (SUSE)" <osalvador@kernel.org>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm: drop pte_clear_not_present_full()
Message-Id: <20260629140855.584366abb95888a2ecbf4a8b@linux-foundation.org>
In-Reply-To: <fd1b4199-ebbc-420b-afe4-3bea4b9149fc@kernel.org>
References: <20260629-clear_not_present_full_ptes-v2-0-96089871a1e7@kernel.org>
	<20260629-clear_not_present_full_ptes-v2-2-96089871a1e7@kernel.org>
	<20260629102215.09605f0e9ef66c5f58fe0932@linux-foundation.org>
	<fd1b4199-ebbc-420b-afe4-3bea4b9149fc@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 19:43:53 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> > So... what's happening here?
> 
> "nr_pages" are not modified in the function, so the compile does not complain.
> See below.
> 
> 
> A private build bot barked at me after v1 for
> 
> 	arm-linux-gnueabi-gcc
> 	openrisc-allnoconfig
> 	um-allmodconfig
> 
> For example:
> 
> https://lore.kernel.org/all/202606121420.Wke8Ipgx-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/kasan.h:38,
>                     from include/linux/slab.h:264,
>                     from lib/test_bitops.c:12:
>    include/linux/pgtable.h: In function 'clear_not_present_full_ptes':
> >> include/linux/pgtable.h:974:31: error: parameter 'addr' set but not used
> [-Werror=unused-but-set-parameter=]
>      974 |                 unsigned long addr, pte_t *ptep, unsigned int nr, int
> full)
>          |                 ~~~~~~~~~~~~~~^~~~
>    cc1: all warnings being treated as errors
> 
> 
> The problem is that addr is updated (written) in the function but never read.

Oh, OK, thanks.  I altered the changelog to read

"To prevent the compiler complaining on some configs about "set but not
used" addr parameter, silence that here."

