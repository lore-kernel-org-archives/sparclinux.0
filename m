From: David Miller <davem@davemloft.net>
Date: Fri, 26 Dec 2008 23:33:19 +0000
Subject: Re: [PATCH] sparc: fix hardirq.h removal fallout
Message-Id: <20081226.153319.239016341.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081221204559.GB18284@uranus.ravnborg.org>
In-Reply-To: <20081221204559.GB18284@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Dec 2008 21:45:59 +0100

> When hardirq.h are removed from asm-generic/local.h a few
> bits fails to build.  Fix these upfront.
> Reported by Alexey.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied to sparc-next-2.6, thanks Sam.
