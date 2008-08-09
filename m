From: David Miller <davem@davemloft.net>
Date: Sat, 09 Aug 2008 07:30:08 +0000
Subject: Re: [15/17] sparc64: use bcd2bin/bin2bcd
Message-Id: <20080809.003008.114527043.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080808163458.GV14495@cs181140183.pp.htv.fi>
In-Reply-To: <20080808163458.GV14495@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, david-b@pacbell.net

From: Adrian Bunk <bunk@kernel.org>
Date: Fri, 8 Aug 2008 19:34:58 +0300

> This patch changes sparc64 to use the new bcd2bin/bin2bcd functions 
> instead of the obsolete BCD_TO_BIN/BIN_TO_BCD macros.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
