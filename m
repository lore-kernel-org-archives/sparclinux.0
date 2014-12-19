From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 17:29:28 +0000
Subject: Re: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219172928.GG4294@oracle.com>
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
> 

Yes, it should.. that would be the eventual goal. But I wanted
to do this incrementally (IOW, I was scared to boil the ocean just yet :-)
I see pci, schizo, ldc using this as well. Even if I managed to 
convert all of them successfully, the patch-set would be pretty massive)

So I wanted to get some feedback on this first

--Sowmini

