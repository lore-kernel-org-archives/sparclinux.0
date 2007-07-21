From: David Miller <davem@davemloft.net>
Date: Sat, 21 Jul 2007 00:21:13 +0000
Subject: Re: [PATCH 7/7] sparc64: fix section mismatch warning in mdesc.c
Message-Id: <20070720.172113.122620107.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070720213455.GH25064@uranus.ravnborg.org>
In-Reply-To: <20070720213455.GH25064@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2007 23:34:55 +0200

> Fix following warning:
> WARNING: vmlinux.o(.text+0x35264): Section mismatch: reference to .init.text:__alloc_bootmem (between 'mdesc_bootmem_alloc' and 'mdesc_bootmem_free')
> 
> Rename mdesc_mem_ops to *_ops so modpost ignores __init references
> and declare mdesc_bootmem_alloc __init since it is only used
> during __init context.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Also applied, thanks Sam.
