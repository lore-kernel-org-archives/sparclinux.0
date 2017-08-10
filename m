From: David Miller <davem@davemloft.net>
Date: Thu, 10 Aug 2017 21:53:21 +0000
Subject: Re: [PATCH] sparc64: update comments in U3memcpy
Message-Id: <20170810.145321.879508864998521076.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170804180624.GA11525@ravnborg.org>
In-Reply-To: <20170804180624.GA11525@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 4 Aug 2017 20:06:24 +0200

> From 07e5777f2de5a121273a7b4b8a933223f3dd813a Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 4 Aug 2017 19:59:39 +0200
> Subject: [PATCH] sparc64: update comments in U3memcpy
> 
> Update comments about the range the different
> parts of the code copies, the original comments were wrong.
> 
> Introduce a few descriptive labels too.
> 
> No functional changes.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> No code fixes, so this is -next material.
> And this is anyway code that is seldomly touched.
> 
> I had added the comments while trying to understand
> the bug where the return value was wrong.
> So let next reader benefits from these.

Applied, thanks.
