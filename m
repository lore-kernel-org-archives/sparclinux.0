From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2007 03:36:41 +0000
Subject: Re: [PATCH] sparc64: pass correct addr in
Message-Id: <20071023.203641.39157190.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071023225038.GR3660@sequoia.sous-sol.org>
In-Reply-To: <20071023225038.GR3660@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Wright <chrisw@sous-sol.org>
Date: Tue, 23 Oct 2007 15:50:38 -0700

> Looks like the MAP_FIXED case is using the wrong address hint.  I'd expect
> the comment "don't mess with it" means pass the request straight on through,
> not change the address requested to -ENOMEM.  
> 
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
> BTW, just noticed by random code inspection, perhaps I've missed something.

Looks entirely like a correct fix to me, applied.

Thanks!
