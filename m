From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jun 2008 18:48:59 +0000
Subject: Re: [RFC] unify exported sparc header files?
Message-Id: <20080605.114859.167041089.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080601072044.GA16220@uranus.ravnborg.org>
In-Reply-To: <20080601072044.GA16220@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 1 Jun 2008 09:20:45 +0200

> For all sparc32 specific files:
>  - nothing
> 
> For all the sparc64 specific files:
>  - copy file to asm-sparc
>  - wrap the copied file in
>    #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
>       ... file content ...
>    #endif
>  - straight include from asm-sparc64 of the asm-sparc file
> - Or I could just drop the wrapping?
> 
> For the non-unified files:
> - Add content to asm-sparc file and wrap it into:
>    #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
> 	... sparc64 file content
>    #else
> 	... sparc32 file content
>    #endif

This sounds fine to me.
