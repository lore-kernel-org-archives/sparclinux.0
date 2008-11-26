From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2008 08:51:53 +0000
Subject: Re: [PATCH] sparc: combine unistd_{32,64}.h
Message-Id: <20081126.005153.220468804.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081114141050.3c2f5828.sfr@canb.auug.org.au>
In-Reply-To: <20081114141050.3c2f5828.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 24 Nov 2008 17:45:04 +1100

> This is complicated a little because compat_audit.c wants to see only
> the 32bit syscall numbers, but is being built in a 64bit compile.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
 ...
> OK, so this one survives a sparc64 allmodconfig (with pcmcia :-)).  I
> missed the Kbuild update.  Sorry about that.

Applied, thanks Stephen.
