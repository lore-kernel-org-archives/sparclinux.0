From: David Miller <davem@davemloft.net>
Date: Sat, 25 May 2019 16:55:00 +0000
Subject: Re: [PATCH 5/6] sparc64: use the generic get_user_pages_fast code
Message-Id: <20190525.095500.1447810293414838145.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de>
        <20190525133203.25853-6-hch@lst.de>
In-Reply-To: <20190525133203.25853-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: torvalds@linux-foundation.org, paul.burton@mips.com, jhogan@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, npiggin@gmail.com, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 25 May 2019 15:32:02 +0200

> The sparc64 code is mostly equivalent to the generic one, minus various
> bugfixes and two arch overrides that this patch adds to pgtable.h.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
