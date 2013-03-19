From: David Miller <davem@davemloft.net>
Date: Tue, 19 Mar 2013 20:16:31 +0000
Subject: Re: [PATCH] sparc: delete "if !ULTRA_HAS_POPULATION_COUNT"
Message-Id: <20130319.161631.1063411526469621480.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1363120519.3137.148.camel@x61.thuisdomein>
In-Reply-To: <1363120519.3137.148.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pebolle@tiscali.nl
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 12 Mar 2013 21:35:19 +0100

> Commit 2d78d4beb64eb07d50665432867971c481192ebf ("[PATCH] bitops:
> sparc64: use generic bitops") made the default of GENERIC_HWEIGHT depend
> on !ULTRA_HAS_POPULATION_COUNT. But since there's no Kconfig symbol with
> that name, this always evaluates to true. Delete this dependency.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied, thanks Paul.
