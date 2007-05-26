From: David Miller <davem@davemloft.net>
Date: Sat, 26 May 2007 22:59:21 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070526.155921.39177055.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 26 May 2007 20:39:09 +0100

> LOL, that was my initial approach until I saw Kyle's code.
> Here's the patch I was preparing for that:

Even better would be to test if the platform has a real CMPXCHG
instruction since sparc32 is not the only platform with this issue.

We can add a KCONFIG variable for that, and not set it on
sparc32 et al.

Alternatively we can have a KCONFIG variable with reversed
logic, like "EMULATED_CMPXCHG" which only the atomically
challenged platforms need to set.
