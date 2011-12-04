From: David Miller <davem@davemloft.net>
Date: Sun, 04 Dec 2011 19:00:39 +0000
Subject: Re: [PATCH] sbus: convert drivers/sbus/char/* to use
Message-Id: <20111204.140039.171261237123447589.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1322370265.2522.5.camel@phoenix>
In-Reply-To: <1322370265.2522.5.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: axel.lin@gmail.com
Cc: linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, akpm@linux-foundation.org, sparclinux@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 27 Nov 2011 13:04:25 +0800

> This patch converts the drivers in drivers/sbus/char/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.
