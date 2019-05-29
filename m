From: David Miller <davem@davemloft.net>
Date: Wed, 29 May 2019 20:23:40 +0000
Subject: Re: [bisected] DEBUG_PAGEALLOC hangs on sparc64
Message-Id: <20190529.132340.1951054150778994386.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
In-Reply-To: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 29 May 2019 22:08:26 +0300

> Bisecting led me to 4.9 merge window and this patch that broke it:
> 
> a74ad5e660a9ee1d071665e7e8ad822784a2dc7f is the first bad commit
> commit a74ad5e660a9ee1d071665e7e8ad822784a2dc7f
> Author: David S. Miller <davem@davemloft.net>
> Date:   Thu Oct 27 09:04:54 2016 -0700
> 
>     sparc64: Handle extremely large kernel TLB range flushes more
>     gracefully.

Thank you, I will take a close look at this ASAP.
