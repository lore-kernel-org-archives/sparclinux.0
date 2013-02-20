From: David Rientjes <rientjes@google.com>
Date: Wed, 20 Feb 2013 07:01:17 +0000
Subject: Re: [PATCH 1/3] sparc64: Fix gfp_flags setting in tsb_grow().
Message-Id: <alpine.DEB.2.02.1302192301040.27407@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130220.014152.1773146557292897449.davem@davemloft.net>
In-Reply-To: <20130220.014152.1773146557292897449.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@ut.ee, linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, hannes@cmpxchg.org

On Wed, 20 Feb 2013, David Miller wrote:

> 
> We should "|= more_flags" rather than "= more_flags".
> 
> Reported-by: David Rientjes <rientjes@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: David Rientjes <rientjes@google.com>
