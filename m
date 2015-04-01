From: David Miller <davem@davemloft.net>
Date: Wed, 01 Apr 2015 16:18:10 +0000
Subject: Re: [PATCH v2 1/3] envctrl: Ignore orderly_poweroff return value
Message-Id: <20150401.121810.1558465635261397368.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1427871888-27331-1-git-send-email-joel@jms.id.au>
In-Reply-To: <1427871888-27331-1-git-send-email-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joel@jms.id.au
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, fabf@skynet.be, jk@ozlabs.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org

From: Joel Stanley <joel@jms.id.au>
Date: Wed,  1 Apr 2015 17:34:46 +1030

> orderly_poweroff() unconditionally returns 0, so remove the dead code
> that checks the return value.
> 
> A future patch will change the return type to void.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: David S. Miller <davem@davemloft.net>
