From: David Miller <davem@davemloft.net>
Date: Tue, 06 Nov 2012 01:25:01 +0000
Subject: Re: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32 architecture
Message-Id: <20121105.202501.1246122770431623794.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-16-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-16-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Michel Lespinasse <walken@google.com>
Date: Mon,  5 Nov 2012 14:47:12 -0800

> Update the sparc32 arch_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

Hmmm...

> -	if (flags & MAP_SHARED)
> -		addr = COLOUR_ALIGN(addr);
> -	else
> -		addr = PAGE_ALIGN(addr);

What part of vm_unmapped_area() is going to duplicate this special
aligning logic we need on sparc?
