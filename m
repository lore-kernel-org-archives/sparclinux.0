From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 23:31:53 +0000
Subject: Re: [PATCH v2] sparc: use asm-generic version of types.h
Message-Id: <20130331.193153.825486423300538228.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130331170147.GA5049@merkur.ravnborg.org>
In-Reply-To: <20130331170147.GA5049@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Mar 2013 19:01:47 +0200

> From: Sam Ravnborg <sam@ravnborg.org>
> Subject: [PATCH v2] sparc: use asm-generic version of types.h
> 
> In sparc headers we use the following pattern:
> 
>     #if defined(__sparc__) && defined(__arch64__)
> 
>     sparc64 specific stuff
> 
>     #else
> 
>     sparc32 specific stuff
> 
>     #endif
> 
> In types.h this pattern was not followed and here
> we only checked for __sparc__ for no good reason.
> It was a left-over from long time ago.
> 
> I checked other architectures - and most of them
> do not have any such checks. And all the recently
> merged versions uses the asm-generic version.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
