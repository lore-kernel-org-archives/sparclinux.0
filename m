From: David Miller <davem@davemloft.net>
Date: Wed, 16 May 2007 00:38:20 +0000
Subject: Re: slab hang on boot
Message-Id: <20070515.173820.101498227.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070515165636.5057456e.akpm@linux-foundation.org>
	<20070515.171447.83623268.davem@davemloft.net>
	<20070515172957.02d80d51.akpm@linux-foundation.org>
In-Reply-To: <20070515172957.02d80d51.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: clameter@sgi.com, mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 15 May 2007 17:29:57 -0700

> This:
> 
> struct kmem_cache kmalloc_caches[KMALLOC_SHIFT_HIGH + 1] __cacheline_aligned;
> 
> is still there.

My bad, we tried using min_t() and that's what caused the problems,
that's why we open-coded the macro like it is now :-)
