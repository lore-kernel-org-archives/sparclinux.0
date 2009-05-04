From: David Miller <davem@davemloft.net>
Date: Mon, 04 May 2009 21:08:39 +0000
Subject: Re: [PATCH] cg6: use standard fields for framebuffer physical
Message-Id: <20090504.140839.27739907.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090504223945.88de6e37.krzysztof.h1@poczta.fm>
In-Reply-To: <20090504223945.88de6e37.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzysztof.h1@poczta.fm
Cc: sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 4 May 2009 22:39:45 +0200

> Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
> for physical address and length of framebuffer.
> 
> This also fixes output of the 'fbset -i' command - address and length 
> of the framebuffer are displayed correctly.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

My objections for the cg3 patch apply here too.
