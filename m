From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 21 Dec 2011 21:34:29 +0000
Subject: Re: "BUG: Bad page map in process Xorg" with 3.1 kernel
Message-Id: <20111221213428.GA4599@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111220230040.GA4192@wooyd.org>
In-Reply-To: <20111220230040.GA4192@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 21, 2011 at 03:58:38PM -0500, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Tue, 20 Dec 2011 23:00:40 +0000
> 
> > Today I've tried running Xorg on my SunBlade 1000 with a rather old 
> > ATI Mach64 graphics card. When I launch Xorg, messages like these get 
> > logged a few times:
> 
> Can you see if reverting this fixes things?
> 
> --------------------
> commit 3e37fd3153ac95088a74f5e7c569f7567e9f993a
> Author: David S. Miller <davem@davemloft.net>
> Date:   Thu Nov 17 18:17:59 2011 -0800
> 
>     sparc: Kill custom io_remap_pfn_range().
>     
>     To handle the large physical addresses, just make a simple wrapper
>     around remap_pfn_range() like MIPS does.
>     
>     Signed-off-by: David S. Miller <davem@davemloft.net>

It does not look like this change made it into 3.1 (where I see these 
errors).

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
