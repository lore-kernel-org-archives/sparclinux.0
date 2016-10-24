From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 17:45:43 +0000
Subject: Re: [PATCH 1/6] sparc64: Add FORCE_MAX_ZONEORDER and default to 13
Message-Id: <20161024.134543.843902561898603557.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
        <1476123127-24314-2-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1476123127-24314-2-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tushar.n.dave@oracle.com
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, rkuo@codeaurora.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Mon, 10 Oct 2016 11:12:02 -0700

> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> This change allows ATU (new IOMMU) in SPARC systems to request
> large (32M) contiguous memory during boot for creating IOTSB backing
> store.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>

If you need 32MB allocations, wouldn't a max zone order of 12 be
sufficient?  (8K << 12 = 32MB)
