From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 10 Nov 2004 04:57:02 +0000
Subject: Re: PATCH for cg14 framebuffer
Message-Id: <20041109205702.0d082af6.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419180CC.3060708@mc.net>
In-Reply-To: <419180CC.3060708@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 09 Nov 2004 20:45:32 -0600
Bob Breuer <breuerr@mc.net> wrote:

> This patch fixes the cg14 framebuffer.  Fixed the initialization with
> a NULL sbus_dev and also the colormap setup.  Tested with 2.6.9 and
> both the linux logo and console text are displayed without problems.
> 
> Looks like the other sbus framebuffers are also missing the fb_set_cmap call.

Doesn't the cg14 come up in 24-bit color mode?  That's why I used
"24" and TRUECOLOR.  And that's also what the 2.4.x driver uses.
