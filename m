From: David Miller <davem@davemloft.net>
Date: Wed, 06 Jul 2011 15:02:14 +0000
Subject: Re: [PATCH] sparc32,leon: Added __init declaration to
Message-Id: <20110706.080214.2157316163045842370.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DCA7CCC.7050404@googlemail.com>
In-Reply-To: <4DCA7CCC.7050404@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
Date: Mon, 13 Jun 2011 19:04:05 +0200

> The function leon_flush_needed() is called only during bootup from another
> __init function. Therefore, we can also add __init to leon_flush_needed().
> 
> Signed-off-by: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
> Acked-by: Daniel Hellstrom <daniel@gaisler.com>

Applied.
