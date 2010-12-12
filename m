From: David Miller <davem@davemloft.net>
Date: Sun, 12 Dec 2010 22:51:49 +0000
Subject: Re: [RFC 2/8] sparc: prom: Use the return value from
Message-Id: <20101212.145149.179929840.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BBD9.2090403@gmail.com>
In-Reply-To: <4CF9BBD9.2090403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 14:56:09 +1100

> As prom_nbputchar() now returns 1 when it succeeds, use it instead
> of decrementing len or incrementing buf - as this matches the
> behaviour of prom_console_write_buf() in console_64.c
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Since we're not doing patch #5 this change no longer makes
any sense.
