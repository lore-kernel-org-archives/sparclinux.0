From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 12 May 2006 19:55:20 +0000
Subject: Re: [PATCH] sparc: fix warning on prom_getproperty in openprom.c
Message-Id: <20060512.125520.61856824.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060507152450.GA3426@palantir8>
In-Reply-To: <20060507152450.GA3426@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 9 May 2006 22:05:26 +0100

> Seems like a hypothetical case to me, since the code just did a prom_getproplen()
> a few lines before. It makes the patch a bit bigger.

Better to do it correctly though :-)

> Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Applied, thanks a lot.
