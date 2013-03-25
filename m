From: David Miller <davem@davemloft.net>
Date: Mon, 25 Mar 2013 17:49:19 +0000
Subject: Re: [PATCH 1/3] sparc: clear bitmap correctly in bit_map_init()
Message-Id: <20130325.134919.516718631486598896.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364115306-17716-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364115306-17716-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 24 Mar 2013 17:55:04 +0900

> In bit_map_init(), it attempts to clear all bits in the bitmap by memset(),
> but if the size of bitmap is not a multiple of the sizeof(long), it can't
> clear the trailing edge of bitmap properly on big-endian architecture.
> So it should use bitmap_clear() instead of memset().
> 
> There are only two users of bit_map_init(), and both of them don't cause
> the issue described above.  But it would be better to fix it now for
> future changes.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

I'd rather not spend time fixing non-bugs.

Sorry, I'm not applying this.
