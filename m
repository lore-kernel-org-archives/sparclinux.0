From: David Miller <davem@davemloft.net>
Date: Thu, 23 Oct 2008 21:14:15 +0000
Subject: Re: [PATCH] rtc-m48t59: shift zero year to 1968 on sparc
Message-Id: <20081023.141415.60888475.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081023195123.c25069cd.krzysztof.h1@poczta.fm>
In-Reply-To: <20081023195123.c25069cd.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Thu, 23 Oct 2008 19:51:23 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Shift the first year to 1968 for Sun SPARC machines.
> 
> Move this logic from platform specific files to rtc driver
> as this fixes problems with correctly calculating a century
> bit.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

CONFIG_SPARC covers both 32-bit and 64-bit sparc builds.  So
you can simplify your ifdef tests.

So, please make this adjustment, add a "Tested-by: " line for
Alexander Beregalov and I'll apply this.

Dziekuje bardzo for fixing this bug!
