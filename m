From: David Miller <davem@davemloft.net>
Date: Mon, 11 Mar 2019 18:23:32 +0000
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
Message-Id: <20190311.112332.2212718467104899802.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190311153857.563743-1-arnd@arndb.de>
In-Reply-To: <20190311153857.563743-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de
Cc: deepa.kernel@gmail.com, willemb@google.com, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, labbott@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Mar 2019 16:38:17 +0100

> Referencing the __kernel_long_t type caused some user space applications
> to stop compiling when they had not already included linux/posix_types.h,
> e.g.
> 
> s/multicast.c -o ext/sockets/multicast.lo
> In file included from /builddir/build/BUILD/php-7.3.3/main/php.h:468,
>                  from /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:27:
> /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c: In function 'zm_startup_sockets':
> /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:776:40: error: '__kernel_long_t' undeclared (first use in this function)
>   776 |  REGISTER_LONG_CONSTANT("SO_SNDTIMEO", SO_SNDTIMEO, CONST_CS | CONST_PERSISTENT);
> 
> It is safe to include that header here, since it only contains kernel
> internal types that do not conflict with other user space types.
> 
> It's still possible that some related build failures remain, but those
> are likely to be for code that is not already y2038 safe.
> 
> Reported-by: Laura Abbott <labbott@redhat.com>
> Fixes: a9beb86ae6e5 ("sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
