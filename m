From: David Miller <davem@davemloft.net>
Date: Thu, 04 Dec 2008 05:11:52 +0000
Subject: Re: [PATCH linux-next] sparc: Add missing of_node_put
Message-Id: <20081203.211152.263373582.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812021130.06197.npalix@diku.dk>
In-Reply-To: <200812021130.06197.npalix@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: npalix@diku.dk
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, julia@diku.dk

From: Nicolas Palix <npalix@diku.dk>
Date: Tue, 2 Dec 2008 11:30:06 +0100

> 
> of_node_put is needed before discarding a value received from
> of_find_node_by_name, eg in error handling code or when the device
> node is no longer used.

Applied to sparc-next-2.6, thanks.

I'm not going to add this to sparc-2.6 or stable, it doesn't
fix any real bugs on sparc (no hot plugged OF nodes, ever)
and adding it to sparc-2.6 would potentitally create some
difficult conflicts in sparc-next-2.6 since we're just finishing
a full merge of arch/sparc64 into arch/sparc there.
