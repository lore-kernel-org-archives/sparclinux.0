From: David Miller <davem@davemloft.net>
Date: Mon, 09 Jul 2012 21:15:51 +0000
Subject: Re: [PATCH] sparc64: remove unused function straddles_64bit_va_hole()
Message-Id: <20120709.141551.1185650718482606670.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <262801341843731@web29e.yandex.ru>
In-Reply-To: <262801341843731@web29e.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 09 Jul 2012 18:22:11 +0400

> Nobody uses straddles_64bit_va_hole(). Remove it
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Well, that's a bug, because we have to keep applications from
being to mmap() things into this virtual address range.

I'll look into the GIT history to see how it has erroneously
become unused.
