From: Christoph Lameter <clameter@sgi.com>
Date: Wed, 16 May 2007 00:51:13 +0000
Subject: Re: slab hang on boot
Message-Id: <Pine.LNX.4.64.0705151750450.4272@schroedinger.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070515163321.744e2388.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0705151642530.3886@schroedinger.engr.sgi.com>
 <20070515165636.5057456e.akpm@linux-foundation.org>
 <20070515.171447.83623268.davem@davemloft.net> <20070515172957.02d80d51.akpm@linux-foundation.org>
In-Reply-To: <20070515172957.02d80d51.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 May 2007, Andrew Morton wrote:

> > Try to define a compile-time array size with it smarty
> > pants :-)
> 
> confusedy pants, more like.
> 
> > That's what we did initially and it doesn't work.
> 
> This:
> 
> struct kmem_cache kmalloc_caches[KMALLOC_SHIFT_HIGH + 1] __cacheline_aligned;
> 
> is still there.

This works fine. Please have a look at the RFC that gets rid of the mess.

