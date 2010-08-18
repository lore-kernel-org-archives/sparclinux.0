From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 22:08:49 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <Pine.LNX.4.64.1008181759290.32606@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 18 Aug 2010, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 18 Aug 2010 14:03:37 -0400 (EDT)
> 
> > Simple microoptimizations for sparc64 atomic functions:
> > Save one instruction by using a delay slot.
> > Use %g1 instead of %g7, because %g1 is written earlier.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> Does it really make things faster?  What timings have you
> done on these code sequences?

I don't think such microoptimizations can be measured. It may save an 
I-cacheline --- but who knows if exactly this cacheline makes some effect 
or not? The point is that making microoptimizations is *much* easier than 
measuring them, so I usually do them and never ask if they help. If you do 
100 microoptimizations, it may have some effect in code size reduction, 
but you never pinpoint it to a single optimization.

Mikulas
