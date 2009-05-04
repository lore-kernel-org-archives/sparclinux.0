From: David Miller <davem@davemloft.net>
Date: Mon, 04 May 2009 21:09:08 +0000
Subject: Re: [PATCH] tcx: use standard fields for framebuffer physical
Message-Id: <20090504.140908.73022354.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090504224520.791f559d.krzysztof.h1@poczta.fm>
In-Reply-To: <20090504224520.791f559d.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzysztof.h1@poczta.fm
Cc: sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 4 May 2009 22:45:20 +0200

> Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
> for physical address and length of framebuffer.
> 
> This also fixes output of the 'fbset -i' command - address and length 
> of the framebuffer are displayed correctly.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

My objections to the cg3 patch apply here as well.
