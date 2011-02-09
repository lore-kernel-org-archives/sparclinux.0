From: David Miller <davem@davemloft.net>
Date: Wed, 09 Feb 2011 06:53:05 +0000
Subject: Re: [PATCH] sparc: use bitmap_set()
Message-Id: <20110208.225305.226762490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1297177190-1423-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1297177190-1423-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue,  8 Feb 2011 23:59:49 +0900

> Use bitmap_set() instead of calling __set_bit() each bit.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Applied.
