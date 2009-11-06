From: David Miller <davem@davemloft.net>
Date: Fri, 06 Nov 2009 10:08:13 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091106.020813.234180336.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 06 Nov 2009 10:59:55 +0100

> Is it ok if I add sbus_sync_single_for_cpu/device which is a NOP if
> SPARC_LEON is not defined?

Sure.
