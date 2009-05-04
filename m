From: David Miller <davem@davemloft.net>
Date: Mon, 04 May 2009 21:08:15 +0000
Subject: Re: [PATCH] cg3: use standard fields for framebuffer physical
Message-Id: <20090504.140815.256208666.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090504223746.c204fb8c.krzysztof.h1@poczta.fm>
In-Reply-To: <20090504223746.c204fb8c.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 4 May 2009 22:37:46 +0200

> Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
> for physical address and length of framebuffer.
> 
> This also fixes output of the 'fbset -i' command - address and length 
> of the framebuffer is displayed correctly.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

I think this is not appropriate.

The "physical address" of these framebuffers is composed of
two values, the 32-bit physical offset and the "which_io"
value.  The full physical I/O address is 36 bits.

Considering either seperately makes no sense.  And adjustments
of one make no sense without consideration of the other.
