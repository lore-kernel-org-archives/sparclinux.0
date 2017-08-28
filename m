From: David Miller <davem@davemloft.net>
Date: Mon, 28 Aug 2017 22:40:07 +0000
Subject: Re: [PATCH sparc-next] sparc64: vcc: Check for IS_ERR() instead of NULL
Message-Id: <20170828.154007.242468999799942558.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170826061205.nkfvekwgzpfgfuhh@mwanda>
In-Reply-To: <20170826061205.nkfvekwgzpfgfuhh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 26 Aug 2017 09:12:05 +0300

> The tty_alloc_driver() function never returns NULL, it returns error
> pointers on error.
> 
> Fixes: ce808b746325 ("sparc64: vcc: TTY driver initialization and cleanup")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks Dan.
