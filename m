From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 15 May 2007 23:33:21 +0000
Subject: Re: slab hang on boot
Message-Id: <20070515163321.744e2388.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705142133190.17204@math>
	<20070514.151148.45744375.davem@davemloft.net>
	<Pine.LNX.4.64.0705141642350.13606@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0705141642350.13606@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Lameter <clameter@sgi.com>
Cc: mroos@linux.ee, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 14 May 2007 16:46:17 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> @@ -86,6 +87,9 @@ static inline int kmalloc_index(int size
>  	 */
>  	WARN_ON_ONCE(size = 0);
>  
> +	if (size >= (1UL << KMALLOC_SHIFT_HIGH))
> +		return -1;
> +

I don't quite understand why we did this.  The subsequent logic in
kmalloc_index() should return -1 for this `size' anyway.  If it doesn't,
it's bust, isn't it?

Also, afaict kmalloc_slab() will totally mishandle the -1 return value and
will return a garbage kmem_cache*, via

        return &kmalloc_caches[index];


Could you double-check it all please?
