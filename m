From: David Miller <davem@davemloft.net>
Date: Wed, 29 Oct 2008 22:35:37 +0000
Subject: Re: [PATCH] rtc-m48t59: shift zero year to 1968 on sparc (rev 2)
Message-Id: <20081029.153537.246937032.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081023195123.c25069cd.krzysztof.h1@poczta.fm>
In-Reply-To: <20081023195123.c25069cd.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Fri, 24 Oct 2008 22:46:15 +0200

> Shift the first year to 1968 for Sun SPARC machines.
> 
> Move this logic from platform specific files to rtc driver
> as this fixes problems with calculating a century bit.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Tested-by: Alexander Beregalov

Applied, thanks a lot.
