From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 04:38:36 +0000
Subject: Re: [RESEND][PATCH] sparc: use %s for unaligned panic
Message-Id: <20140721.213836.2235386730808030831.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140630203759.GA4764@www.outflux.net>
In-Reply-To: <20140630203759.GA4764@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: keescook@chromium.org
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Jun 2014 13:37:59 -0700

> Since unaligned_panic() takes a literal string, make sure it can never
> accidentally be used as a format string.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Unnecessary, but harmless, so applied to sparc-next, thanks.
