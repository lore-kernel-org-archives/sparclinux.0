From: David Miller <davem@davemloft.net>
Date: Wed, 16 May 2007 06:43:43 +0000
Subject: Re: slab hang on boot
Message-Id: <20070515.234343.74747977.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070515.173820.101498227.davem@davemloft.net>
	<Pine.LNX.4.64.0705151759420.4399@schroedinger.engr.sgi.com>
	<20070515.180316.41635662.davem@davemloft.net>
In-Reply-To: <20070515.180316.41635662.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2007 18:03:16 -0700 (PDT)

> From: Christoph Lameter <clameter@sgi.com>
> Date: Tue, 15 May 2007 18:00:23 -0700 (PDT)
> 
> > Slab allocators: Define common size limitations
> 
> Thanks for doing this work Christoph, I'll test this patch out on all
> my sparc64 boxes, with both SLAB and SLUB, later this evening.

SLAB works properly again on sparc64 with this patch, thanks
Christophe.

Signed-off-by: David S. Miller <davem@davemloft.net>
