From: David Miller <davem@davemloft.net>
Date: Fri, 19 Dec 2014 19:57:32 +0000
Subject: Re: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219.145732.1885898372505877024.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141219151616.GB25248@oracle.com>
In-Reply-To: <20141219151616.GB25248@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 13:31:33 -0500

> I could look into that, but would need help from other arch experts for
> help with extraction of the platform-dependant parts, implementation and 
> testing. Looks like pci-calgary_64.c also has an obvious copy of the
> powerpc algorithm, and there are other *iommu.c implementations as well,
> where the duplication may be there, but is not obvious (from cscope etc.).

I suspect that if we come up with something that should work for both
powerpc and sparc, we can just let linux-arch@vger.kernel.org know
about it to give a heads up for other platform maintainers so they
can do the conversions for their code too.

The core operation is the range allocation.  So if you just put the
powerpc alloc/free code (basically, the bulk of your patch) into
lib/iommu-common.c or similar, that ought to be a good starting point.

The patch set would look like:

1) move powerpc iommu range alloc/free into lib/iommu-common.c

2) make sparc64 use it
