From: David Miller <davem@davemloft.net>
Date: Wed, 21 Jul 2010 03:31:00 +0000
Subject: Re: [patch 1/6] sparc: remove dependency on __GFP_NOFAIL
Message-Id: <20100720.203100.254885062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.2.00.1007201936210.8728@chino.kir.corp.google.com>
	<alpine.DEB.2.00.1007201938100.8728@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1007201938100.8728@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rientjes@google.com
Cc: akpm@linux-foundation.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

From: David Rientjes <rientjes@google.com>
Date: Tue, 20 Jul 2010 19:44:53 -0700 (PDT)

> The kmalloc() in mdesc_kmalloc() is failable, so remove __GFP_NOFAIL from
> its mask.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: David Rientjes <rientjes@google.com>

The __GFP_NOFAIL is there intentionally.

The code above this, in the cases where the machine description is
dynamically updated by the hypervisor at run time, long after boot,
has no failure handling.

We absolutely must accept the machine descriptor update and fetch it
from the hypervisor into a new buffer.

Please don't remove this.
