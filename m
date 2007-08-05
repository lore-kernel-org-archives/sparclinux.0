From: David Miller <davem@davemloft.net>
Date: Sun, 05 Aug 2007 03:23:26 +0000
Subject: Re: [PATCH] sparc: fix fallout from O_CLOEXEC changes
Message-Id: <20070804.202326.39158668.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070804203005.GA7668@martell.zuzino.mipt.ru>
In-Reply-To: <20070804203005.GA7668@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adobriyan@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sun, 5 Aug 2007 00:30:05 +0400

> Just "#define O_CLOEXEC" is OK, because asm-generic/fcntl.h will check if it's
> already defined.
> 
> Loads of "struct flock inside parameter list" warnings and
> "O_WRONLY undefined" errors.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Mark F. already posted a fix to sparclinux@vger.kernel.org for
this, but thanks.
