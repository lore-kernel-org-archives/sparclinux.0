From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 10 Nov 2004 06:14:03 +0000
Subject: Re: PATCH for cg14 framebuffer
Message-Id: <20041109221403.4dfd9e4e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419180CC.3060708@mc.net>
In-Reply-To: <419180CC.3060708@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 10 Nov 2004 00:13:42 -0600
Bob Breuer <breuerr@mc.net> wrote:

> Well, it looks as if it can display 8, 16, or 24 bit modes (implied
> from the CG14_MCR_PIXMODE_* defines).  The __cg14_reset function
> drops it back into 8 bit mode.  Something to do with cg3 emulation
> maybe.

That's right, my bad.
