From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2007 20:59:31 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070529.135931.74737381.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 29 May 2007 21:30:45 +0100

> On Tue, May 29, 2007 at 01:12:33AM -0700, David Miller wrote:
> > From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> > Date: Tue, 29 May 2007 00:37:01 +0100
> > 
> > > Good to see someone has a crystal ball handy. So a patch like like this
> > > to solve the DRM issue? With it DRM can no longer be selected.
> > > 
> > > ---
> > > The DRM code depends on an atomic version of cmpxchg(), which is not
> > > available on sparc32. Since other platforms besides sparc32 have
> > > this issue a KCONFIG option is added for it.
> > > 
> > > Martin
> > > 
> > > 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
> > 
> > This looks great, I've applied Kyle's original patch and this
> > one, thanks a lot!
> 
> Ehh, Kyle's original patch did not build. See my initial reply to that
> one, which has a version that does build cleanly.

I fixed his version to build and more match the types of the
parisc code when I chekced it in.
