From: David Miller <davem@davemloft.net>
Date: Mon, 26 Oct 2015 11:45:56 +0000
Subject: Re: [PATCH 7/8] sparc/math-emu: Move sparc from math-emu-old to math-emu
Message-Id: <20151026.050228.1805118062504707338.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.2.10.1507021553390.29415@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.10.1507021553390.29415@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joseph@codesourcery.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, mpe@ellerman.id.au

From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 2 Jul 2015 15:54:34 +0000

> From: Joseph Myers <joseph@codesourcery.com>
> 
> This patch moves sparc from math-emu-old to math-emu, updating it for
> the API changes.
> 
> The following cleanup (that goes beyond mechanical conversion to new
> APIs) is included in this patch because of its close connection to the
> API changes:
> 
> * On SPARC, comparisons now use raw unpacking (this should not in fact
>   change how the emulation behaves, just make it more efficient).
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Acked-by: David S. Miller <davem@davemloft.net>
