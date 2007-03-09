From: David Miller <davem@davemloft.net>
Date: Fri, 09 Mar 2007 05:25:23 +0000
Subject: Re: [PATCH] Fix sparc TIF_USEDFPU flag atomicity
Message-Id: <20070308.212523.45514581.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070309031227.GC9462@Krystal>
In-Reply-To: <20070309031227.GC9462@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@polymtl.ca
Cc: akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Thu, 8 Mar 2007 22:12:27 -0500

> Fix sparc TIF_USEDFPU flag atomicity
> 
> Non atomic update of TIF can be very dangerous, except at thread structure
> creation time. Here I standardize the TIF_USEDFPU usage of the sparc arch.
> 
> Applies on 2.6.20.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Also applied, thanks a lot.
