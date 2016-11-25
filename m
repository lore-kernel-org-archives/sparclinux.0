From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 25 Nov 2016 13:57:39 +0000
Subject: Re: [patch] sparc64: enable IRQs on error paths
Message-Id: <20161125135739.GC7578@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125111054.GE5938@mwanda>
In-Reply-To: <20161125111054.GE5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On (11/25/16 16:46), Dan Carpenter wrote:
> > In that case why dont you just do the local_irq_restore
> > once at the iommu_map_fail label?
> 
> I thought this way was easier to read.  It doesn't really matter?

I suppose.

--Sowmini

