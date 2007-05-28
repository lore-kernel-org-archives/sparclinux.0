From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 28 May 2007 00:07:46 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070528000746.GA21147@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 26, 2007 at 03:59:21PM -0700, David Miller wrote:
> Alternatively we can have a KCONFIG variable with reversed
> logic, like "EMULATED_CMPXCHG" which only the atomically
> challenged platforms need to set.

Like this idea, but if we're not going to build DRM I see no
point adding the cmpxchg emulation to sparc32. Maybe "NOARCH_CMPXCHG"
would be better?

-- 
Martin
