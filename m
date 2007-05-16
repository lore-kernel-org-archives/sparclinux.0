From: David Miller <davem@davemloft.net>
Date: Wed, 16 May 2007 00:14:47 +0000
Subject: Re: slab hang on boot
Message-Id: <20070515.171447.83623268.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070515163321.744e2388.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0705151642530.3886@schroedinger.engr.sgi.com>
	<20070515165636.5057456e.akpm@linux-foundation.org>
In-Reply-To: <20070515165636.5057456e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: clameter@sgi.com, mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 15 May 2007 16:56:36 -0700

> On Tue, 15 May 2007 16:45:22 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > KMALLOC_SHIFT_HIGH is not a constant but may be less than 25.
> 
> It darn well better be a compile-time constant.

Try to define a compile-time array size with it smarty
pants :-)

That's what we did initially and it doesn't work.

