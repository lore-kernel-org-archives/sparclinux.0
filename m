From: David Miller <davem@davemloft.net>
Date: Thu, 24 Dec 2015 16:39:54 +0000
Subject: Re: [PATCH] sparc64: Don't set %pil in rtrap_nmi too early
Message-Id: <20151224.113954.344304849907731213.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450759683-1080-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450759683-1080-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 21 Dec 2015 21:48:03 -0700

> Commit 28a1f53 delays setting %pil to avoid potential
> hardirq stack overflow in the common rtrap_irq path.
> Setting %pil also needs to be delayed in the rtrap_nmi
> path for the same reason.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>

Applied.
