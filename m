From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 14 Mar 2005 01:56:57 +0000
Subject: Re: [BUG?] Signedness of __kernel_nlink_t on Sparc?
Message-Id: <20050313175657.44cb932b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <bbcd3873d9324ce185dc9eaf146ef741@mac.com>
In-Reply-To: <bbcd3873d9324ce185dc9eaf146ef741@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com

On Sun, 13 Mar 2005 19:21:09 -0500
Kyle Moffett <mrmacman_g4@mac.com> wrote:

> In include/asm-sparc/types.h, __kernel_nlink_t is signed, whereas on 
> all the
> other architectures it is unsigned.  Is this intentional, or a bug?

Intentional, in order to match SunOS.  Unfortunately this is pretty
much unchangable.
