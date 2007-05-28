From: David Miller <davem@davemloft.net>
Date: Mon, 28 May 2007 02:49:21 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070527.194921.74747463.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 28 May 2007 01:07:46 +0100

> On Sat, May 26, 2007 at 03:59:21PM -0700, David Miller wrote:
> > Alternatively we can have a KCONFIG variable with reversed
> > logic, like "EMULATED_CMPXCHG" which only the atomically
> > challenged platforms need to set.
> 
> Like this idea, but if we're not going to build DRM I see no
> point adding the cmpxchg emulation to sparc32. Maybe "NOARCH_CMPXCHG"
> would be better?

It is likely that we are going to have generic users of cmpxchg() in
the kernel in the future (I think the -rt patch set has some which are
hard to get rid of) at which point we'd probably put the emulated
cmpxchg() in there anyways.

