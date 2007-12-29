From: David Miller <davem@davemloft.net>
Date: Sat, 29 Dec 2007 08:54:08 +0000
Subject: Re: 2.6.24-rc6-mm1: some section mismatches on sparc64
Message-Id: <20071229.005408.76652528.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071228232255.GB9105@does.not.exist>
	<20071229.001411.210630819.davem@davemloft.net>
	<20071229084846.GA27360@does.not.exist>
In-Reply-To: <20071229084846.GA27360@does.not.exist>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@kernel.org
Cc: errandir_news@mph.eclipse.co.uk, m.kozlowski@tuxland.pl, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Sat, 29 Dec 2007 10:48:46 +0200

> On Sat, Dec 29, 2007 at 12:14:11AM -0800, David Miller wrote:
> > That's why I'm not worried about this issue and it's not critical at
> > all.
> 
> If a module calls sunserial_console_match() that's an Oops.

That's true.

I'm trying to figure out a way to fix this.
