From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 22:06:49 +0000
Subject: Re: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219220649.GO4294@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141219151616.GB25248@oracle.com>
In-Reply-To: <20141219151616.GB25248@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (12/19/14 15:56), David Miller wrote:
> 
> That large_pool mechanism might help prevent the other pools from
> getting fragmented and thus lead to premature allocation failures.

I see. Looks like the scsi driver uses sun4v_pci to ask for 7-8
pages on occasion - I'll add the large_pool hooks in and test it 
with scsi, using some absurd check like (npages > 5) for the purpose
of testing the large_pool code. 

--Sowmini

