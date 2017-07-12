From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jul 2017 15:13:20 +0000
Subject: Re: [sparc-next] SPARC64: Fix sun4v DMA panic
Message-Id: <20170712.081320.21515285122907934.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1499808887-31483-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1499808887-31483-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tushar.n.dave@oracle.com
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, egtvedt@samfundet.no, dan.carpenter@oracle.com, krzk@kernel.org, bart.vanassche@sandisk.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, mroos@linux.ee

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Tue, 11 Jul 2017 14:34:47 -0700

> 64bit DMA only supported on sun4v equipped with ATU IOMMU HW.
> 'Commit b02c2b0bfd7ae ("sparc: remove arch specific dma_supported
> implementations")' introduced a code that incorrectly allow
> dma_supported() to succeed for 64bit dma mask even if system doesn't
> have ATU IOMMU. This results into panic.
> 
> Fix it.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>

Applied to the 'sparc' tree, thanks.
