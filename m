From: David Miller <davem@davemloft.net>
Date: Mon, 31 Jul 2006 04:57:41 +0000
Subject: Re: sparc32: git sun4d fs cache page and dma
Message-Id: <20060730.215741.25156755.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607301951200.10727-100000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607301951200.10727-100000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Sun, 30 Jul 2006 22:05:39 -0700 (PDT)

> Barring other suggestions I'll debug my way to a patch using the
> routines in iommu.c as models.
> 
> or are the needs of sun4m and sun4d enough alike at this point to
> merge more of the common code ? 

Such cleanups are secondary to getting things working.
Please just get sun4d working properly, then we can
talk about code consolidation.

Thanks for tracking this down.
