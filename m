From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 16:41:54 +0000
Subject: Re: [PATCH 4/5] sparc: use asm-generic version of types.h
Message-Id: <20130331.124154.942101473234910009.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Mar 2013 09:48:46 +0200

> In sparc headers we use the following pattern:
 ...
> In types.h this pattern was not followed and here
> we only checked for __sparc__ for no good reason.
> It was a left-over from long time ago.
> 
> I checked other architectures - and most of them
> do not have any such checks. And all the recently
> merged versions uses the asm-generic version
> 
> So independent on the build error reported by Fengguang Wu
> and independent on my broken cross gcc this patch is fine.

Please resubmit this patch with the more accurate description
you've provided above.  Thanks!
