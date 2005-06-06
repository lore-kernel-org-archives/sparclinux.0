From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 06 Jun 2005 21:11:02 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32
Message-Id: <20050606211102.GC31508@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050605.143021.59473087.davem@davemloft.net>
In-Reply-To: <20050605.143021.59473087.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jun 05, 2005 at 02:30:21PM -0700, David S. Miller wrote:
> We fixed a similar problem in the past, by putting the
> "aligned to 8 bytes" check into __constant_memcpy().
> Let's just remove the __copy_1page() optimization altogether,
> it causes more trouble than it's worth.  Similarly for
> memset().
> In fact, most of this inline stuff can be removed entirely.
> In particular, we should just use a plain memcpy() symbol
> and let GCC output the inline builtin copy if it wants
> to automatically.

I've got something along these lines cooked up; does anyone who can
actively reproduce this bug care to take it for a spin?


-- wli
