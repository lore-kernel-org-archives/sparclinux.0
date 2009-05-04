From: David Miller <davem@davemloft.net>
Date: Mon, 04 May 2009 21:10:24 +0000
Subject: Re: [PATCH] p9100: use standard fields for framebuffer physical
Message-Id: <20090504.141024.206710584.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090504224257.00514552.krzysztof.h1@poczta.fm>
In-Reply-To: <20090504224257.00514552.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 4 May 2009 22:42:57 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
> for physical address and length of framebuffer.
> 
> This also fixes output of the 'fbset -i' command - address and length 
> of the framebuffer are displayed correctly.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

My objections to the cg3 patch apply here as well.
