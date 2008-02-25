From: David Miller <davem@davemloft.net>
Date: Mon, 25 Feb 2008 03:50:25 +0000
Subject: Re: [PATCH][SPARC64] fix section mismatch from kernel_map_range
Message-Id: <20080224.195025.227460637.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080222203331.GF7154@uranus.ravnborg.org>
In-Reply-To: <20080222203331.GF7154@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Feb 2008 21:33:31 +0100

> Fix following warnings:
> WARNING: vmlinux.o(.text+0x4f980): Section mismatch in reference from the function kernel_map_range() to the function .init.text:__alloc_bootmem()
> WARNING: vmlinux.o(.text+0x4f9cc): Section mismatch in reference from the function kernel_map_range() to the function .init.text:__alloc_bootmem()
> 
> alloc_bootmem() is only used during early init and for any subsequent
> call to kernel_map_range() the program logic avoid the call.
> So annotate kernel_map_range() with __ref to tell modpost to
> ignore the reference to a __init function.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: David S. Miller <davem@davemloft.net>

Applied, thanks Sam.
