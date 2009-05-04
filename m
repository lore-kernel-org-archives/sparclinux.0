From: David Miller <davem@davemloft.net>
Date: Mon, 04 May 2009 21:09:22 +0000
Subject: Re: bw2: use standard fields for framebuffer physical address and
Message-Id: <20090504.140922.52991414.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090504223536.fa9ee920.krzysztof.h1@poczta.fm>
In-Reply-To: <20090504223536.fa9ee920.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 4 May 2009 22:35:36 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
> for physical address and length of framebuffer.
> 
> This also fixes output of the 'fbset -i' command - address and length 
> of the framebuffer is displayed correctly.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

My objections to the cg3 patch apply here as well.
