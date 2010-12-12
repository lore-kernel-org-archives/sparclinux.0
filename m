From: David Miller <davem@davemloft.net>
Date: Sun, 12 Dec 2010 22:47:05 +0000
Subject: Re: [RFC 6/8] sparc: oplib: Remove prom_console_write_buf()
Message-Id: <20101212.144705.246542000.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BC4D.3020605@gmail.com>
In-Reply-To: <4CF9BC4D.3020605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 14:58:05 +1100

> Remove prom_console_write_buf() defs as they are not used anywhere
> within the kernel tree.
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Since we're not going to undo the console_{32,64}.c split in the
previous patch, this patch no longer makes any sense.
