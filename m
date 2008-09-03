From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 22:42:09 +0000
Subject: Re: [PATCH 1/2] rtc-m48t59: allow externally mapped ioaddr
Message-Id: <20080903.154209.168842327.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903183245.fe3a08eb.krzysztof.h1@wp.pl>
In-Reply-To: <20080903183245.fe3a08eb.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 3 Sep 2008 18:32:45 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Add support for externally mapped ioaddr.
> This is required on sparc32 as the ioaddr
> must be mapped with of_ioremap().
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Applied to sparc-next-2.6
