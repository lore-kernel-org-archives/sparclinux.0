From: David Miller <davem@davemloft.net>
Date: Mon, 08 Dec 2008 09:00:26 +0000
Subject: Re: [PATCH] use sparc64 version of prom/printf.c
Message-Id: <20081208.010026.106738925.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <493C1616.6080206@earthlink.net>
In-Reply-To: <493C1616.6080206@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sun, 07 Dec 2008 13:29:42 -0500

> Use sparc64 version of prom/printf.c.
> 
> The only differences for sparc32 is that prom_printf is no longer exported for modules which should be OK.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks Robert.
