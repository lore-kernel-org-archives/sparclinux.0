From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 08 Oct 2018 14:26:37 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20181008142637.GA13671@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181007.234832.1963273306260975472.davem@davemloft.net>
In-Reply-To: <20181007.234832.1963273306260975472.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 11:48:32PM -0700, David Miller wrote:
> 
> I've been moving so haven't had access to my Sparc boxes during this
> time.  That's been resolved, and now I can get the patches flowing
> again.
> 
> 1) Minor fallthru comment tweaks from Gustavo A. R. Silva.
> 
> 2) VLA removal from Kees Cook.
> 
> 3) Make sparc vdso Makefile match x86, from Masahiro Yamada.
> 
> 4) Fix clock divider programming in mach64 driver, from Mikulas
>    Patocka.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit c1d84a1b42ef70d8ae601df9cadedc7ed4f1beb1:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-06 02:11:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

Now merged, thanks.

greg k-h
