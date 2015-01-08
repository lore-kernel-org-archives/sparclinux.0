From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 08 Jan 2015 19:43:27 +0000
Subject: Re: [PATCH 0/2] IOMMU pools for better scalability
Message-Id: <20150108194327.GA29528@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141222224308.GH29674@oracle.com>
In-Reply-To: <20141222224308.GH29674@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (12/22/14 17:43), Sowmini Varadhan wrote:
> 
> This patch series follows up on the suggestion in
>   http://www.spinics.net/lists/sparclinux/msg13230.html
> 
> Patch 1 of the series adds the infra-structure functions
> for range alloc/free into (new file) lib/iomm-common.c
> 
> Patch 2 of the series makes sparc64 use this via changes
> to pci_sun4v.c

Hello,

Any preliminary comments on this patch? Do I need to improve/supply
something else?

--Sowmini
