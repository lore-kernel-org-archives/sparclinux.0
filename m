From: David Miller <davem@davemloft.net>
Date: Mon, 23 May 2011 06:45:58 +0000
Subject: Re: [PATCH 1/4] sparc: _sparc_find_resource() should check for
Message-Id: <20110523.024558.1625882862305082516.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1306006756-32009-1-git-send-email-geert@linux-m68k.org>
	<1306006756-32009-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306006756-32009-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-m68k@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2011 21:39:13 +0200

> The address that's passed to _sparc_find_resource() should always be the
> start address of a resource:
>   - iounmap() passes a page-aligned virtual address, while the original
>     address was created by adding the in-page offset to the resource's
>     start address,
>   - sbus_free_coherent() and pci32_free_coherent() should be passed an
>     address obtained from sbus_alloc_coherent() resp. pci32_alloc_coherent(),
>     which is always a resource's start address.
> 
> Hence replace the range check by a check for an exact match.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: David S. Miller <davem@davemloft.net>
