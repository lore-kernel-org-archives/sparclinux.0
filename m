From: David Miller <davem@davemloft.net>
Date: Wed, 26 Oct 2016 21:02:45 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <20161026.170245.2102810454336764114.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 26 Oct 2016 21:05:36 +0100

> Thanks for this, it's now compiling. I'll let you know if it works
> within the next 24 hours.

Thanks.

> Before I forget, what do you think about the following patch? I know
> Debian used to use the 64-bit kernel for a 32-bit sparc userland, and so
> "Architecture: sparc" was correct, but obviously sparc64 also exists. It
> seems more sane to make sparc64 default to "Architecture: sparc64", with
> sparc users needing to override this with KBUILD_DEBARCH if they want
> to, rather than providing a setup that's broken out of the box for
> sparc64 users.
> 
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Wed, 26 Oct 2016 20:17:10 +0100
> Subject: [PATCH] builddeb: Add support for sparc64
> 
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>

I don't know.

I still personally use a 32-bit userland on my sparc64 systems because
that is what performs the best and is what I will be using for as long
as I possibly can.

I've actually never used this target, is this for build the kernel or
userland components?
