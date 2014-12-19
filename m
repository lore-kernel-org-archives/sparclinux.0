From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 18:31:33 +0000
Subject: Re: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219183133.GH4294@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141219151616.GB25248@oracle.com>
In-Reply-To: <20141219151616.GB25248@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (12/19/14 12:26), David Miller wrote:
> 
> If this is such a better and more scalable algorithm for IOMMU
> arena DMA region allocation, then instead of one platform after
> another putting a private implementation under arch/, the generic
> IOMMU code should be adjusted instead.
> 
> Right?

Then again, I just realized that you are talking about factorizing
common code across multiple architectures, instead of multiple drivers
within sparc.

yes, that would be even better. 

I could look into that, but would need help from other arch experts for
help with extraction of the platform-dependant parts, implementation and 
testing. Looks like pci-calgary_64.c also has an obvious copy of the
powerpc algorithm, and there are other *iommu.c implementations as well,
where the duplication may be there, but is not obvious (from cscope etc.).

--Sowmini



