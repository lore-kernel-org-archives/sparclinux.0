From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 19:35:37 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150323.153537.1167433221134028872.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322.221906.1670737065885267482.davem@davemloft.net>
	<20150323.122530.812870422534676208.davem@davemloft.net>
	<55104EAA.4060607@oracle.com>
In-Reply-To: <55104EAA.4060607@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

From: David Ahern <david.ahern@oracle.com>
Date: Mon, 23 Mar 2015 11:34:34 -0600

> seems like a formality at this point, but this resolves the panic on
> the M7-based ldom and baremetal. The T5-8 failed to boot, but it could
> be a different problem.

Specifically, does the T5-8 boot without my patch applied?
