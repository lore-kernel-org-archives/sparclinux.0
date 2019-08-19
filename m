From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 19 Aug 2019 05:10:55 +0000
Subject: Re: sparc64: hang from BUG: Bad page state, on older CPU & compiler
Message-Id: <20190819051055.GA32118@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
In-Reply-To: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 18, 2019 at 12:39:43PM -0700, David Miller wrote:
> From: Christoph Hellwig <hch@infradead.org>
> Date: Sun, 18 Aug 2019 00:01:37 -0700
> 
> > I think for now we'll simply have to disable HAVE_FAST_GUP for sparc,
> > until someone who really knows low-level sparc page table handling
> > finds some time to audit the generic fast gup code and arch hooks.
> 
> It's a regression, we don't disable features in those circumstances
> usually right?

Well, it isn't exactly a feature we lost, but an optimization that makes
operations go faster vs not allowing them.  Them other option would be
to revert the whole stack of patches, which is the groundwork for
fixing the get_user_pages vs truncate and co races, so I'm not very
eager to do that for sparc64.

But in the end Linus will have to decice.
