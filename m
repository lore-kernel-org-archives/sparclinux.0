From: David Miller <davem@davemloft.net>
Date: Mon, 23 May 2011 06:46:20 +0000
Subject: Re: [PATCH 4/4] sparc: iounmap() and *_free_coherent() - Use
Message-Id: <20110523.024620.245701157448889932.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1306006756-32009-1-git-send-email-geert@linux-m68k.org>
	<1306006756-32009-5-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306006756-32009-5-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-m68k@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2011 21:39:16 +0200

> Replace a custom implementation (which doesn't lock the resource tree) by a
> call to lookup_resource()
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: David S. Miller <davem@davemloft.net>
