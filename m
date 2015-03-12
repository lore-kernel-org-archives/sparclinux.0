From: David Miller <davem@davemloft.net>
Date: Thu, 12 Mar 2015 03:16:23 +0000
Subject: Re: [PATCH v3 RFC 2/3] sparc: Make sparc64 use scalable lib/iommu-common.c functions
Message-Id: <20150311.231623.1943646339519808369.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <6a5fd00b661cbedb250c54d7143c818e8ca1a195.1426021520.git.sowmini.varadhan@oracle.com>
In-Reply-To: <6a5fd00b661cbedb250c54d7143c818e8ca1a195.1426021520.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 10 Mar 2015 18:27:04 -0400

> @@ -142,7 +142,12 @@ struct pci_pbm_info {
>  	struct strbuf			stc;
>  
>  	/* IOMMU state, potentially shared by both PBM segments. */
> -	struct iommu			*iommu;
> +#ifdef notyet
> +	struct iommu_sparc			*iommu;
> +#else
> +	/* change only pci_sun4v and DMA to use new iommu_table for now */
> +	void					*iommu;
> +#endif
>  
>  	/* Now things for the actual PCI bus probes. */
>  	unsigned int			pci_first_busno;

Since you converted everything, this shouldn't be necessary right?
