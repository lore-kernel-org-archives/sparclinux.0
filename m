From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2008 04:29:12 +0000
Subject: Re: [PATCH] sparc64: do not export pus_fs_struct
Message-Id: <20081211.202912.158094157.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081211211707.GA27223@uranus.ravnborg.org>
In-Reply-To: <20081211211707.GA27223@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 11 Dec 2008 22:17:07 +0100

> Al asked: BTW, why does sparc64 export put_fs_struct?
> Grepping the kernel tree did not show any users of
> an exported put_fs_struct - so drop the export.
> 
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks a lot Sam.
