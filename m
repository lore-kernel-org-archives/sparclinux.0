From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 04:38:18 +0000
Subject: Re: [PATCH] drivers/sbus/char: Micro-optimization in display7seg.c
Message-Id: <20140721.213818.1578856121778935701.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1403181112-12018-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1403181112-12018-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@rasmusvillemoes.dk
Cc: paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 19 Jun 2014 14:31:52 +0200

> Flipping a bit doesn't need four lines of code; and gcc seems to
> actually generate two branches.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to sparc-next
