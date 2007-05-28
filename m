From: Kyle McMartin <kyle@parisc-linux.org>
Date: Mon, 28 May 2007 03:11:14 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070528031114.GA23560@fattire.cabal.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 27, 2007 at 07:49:21PM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Mon, 28 May 2007 01:07:46 +0100
> 
> > On Sat, May 26, 2007 at 03:59:21PM -0700, David Miller wrote:
> > > Alternatively we can have a KCONFIG variable with reversed
> > > logic, like "EMULATED_CMPXCHG" which only the atomically
> > > challenged platforms need to set.
> > 
> > Like this idea, but if we're not going to build DRM I see no
> > point adding the cmpxchg emulation to sparc32. Maybe "NOARCH_CMPXCHG"
> > would be better?
> 
> It is likely that we are going to have generic users of cmpxchg() in
> the kernel in the future (I think the -rt patch set has some which are
> hard to get rid of) at which point we'd probably put the emulated
> cmpxchg() in there anyways.
> 

Yeah, David Howells wanted to use cmpxchg in his work struct patch, but
had to not because not everyone implements it.

From what I can tell, very few arches actually have CAS, and others
emulate it with LL/SC type implementations.

Cheers,
	Kyle
