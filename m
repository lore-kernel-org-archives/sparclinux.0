From: David Miller <davem@davemloft.net>
Date: Wed, 27 Jun 2012 08:35:02 +0000
Subject: Re: [PATCH 2/2] sparc32: Remove superfluous extern declarations for prom_*() functions
Message-Id: <20120627.013502.1720347414481981219.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1340211487-24534-1-git-send-email-geert@linux-m68k.org>
	<1340211487-24534-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1340211487-24534-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Jun 2012 18:58:07 +0200

> prom_meminit() and prom_ranges_init() are declared in <asm/oplib_32.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied.
