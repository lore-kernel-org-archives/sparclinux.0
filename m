From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 17 Jan 2006 23:36:15 +0000
Subject: Re: [Patch] change if() BUG(); to BUG_ON in iommu.c
Message-Id: <20060117.153615.29941328.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1137445626.2675.2.camel@localhost>
In-Reply-To: <1137445626.2675.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
Date: Mon, 16 Jan 2006 22:07:06 +0100

> this patch changes if() BUG(); constructs
> in iommu.c to BUG_ON(); so it gets save
> to define BUG() and BUG_ON() to nullstatements.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Applied, thanks Eric.
