From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Tue, 10 Aug 2004 00:06:10 +0000
Subject: Re: /dev/random lacks entropy on sparc64
Message-Id: <1092096370.7936.55.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <1092092360.7938.50.camel@duncow>
In-Reply-To: <1092092360.7938.50.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2004-08-10 at 00:20, David S. Miller wrote:
> On Mon, 09 Aug 2004 23:59:20 +0100
> Richard Mortimer <richm@oldelvet.org.uk> wrote:
> 
> > I suspect that the patch needs some more work (probably shouldn't use
> > assembly directly in drivers/char/random.c). I'm not sure whether we
> > should really be calling something like tick_ops->get_tick().
> 
> I think we should.
Fair enough.

>   Also, you forgot to shift down the
> high bits before xor'ing it into 'num'.
> 
I didn't think that I did :-)

+        __asm__ __volatile__("rd        %%tick, %0\n\t"
+                             "srlx      %0, 32, %1\n\t"
+                             "srl       %1, 1, %1"
+                             : "=r" (tmp), "=r" (high));

The srlx would have done the shift and srl clears out the npt bit.

That's all academic anyway. I tested your patch and it all works great.

> I would use this patch.
> 

Thanks

Richard

-- 
richm@oldelvet.org.uk

