From: David Miller <davem@davemloft.net>
Date: Mon, 12 Dec 2016 02:18:50 +0000
Subject: Re: [patch] sparc: leon: Fix a retry loop in leon_init_timers()
Message-Id: <20161211.211850.1804813212925215809.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125112554.GG5938@mwanda>
In-Reply-To: <20161125112554.GG5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 14:25:54 +0300

> The original code causes a static checker warning because it has a
> continue inside a do { } while (0); loop.  In that context, a continue
> and a break are equivalent.  The intent was to go back to the start of
> the loop so the continue was a bug.
> 
> I've added a retry label at the start and changed the continue to a goto
> retry.  Then I removed the do { } while (0) loop and pulled the code in
> one indent level.
> 
> Fixes: 2791c1a43900 ("SPARC/LEON: added support for selecting Timer Core and Timer within core")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
