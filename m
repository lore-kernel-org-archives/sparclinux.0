From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 25 Nov 2016 09:30:48 +0000
Subject: Re: [PATCH v3] dbri: Fix compiler warning
Message-Id: <s5ha8cn9a9j.wl-tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1480019716-14225-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1480019716-14225-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tushar Dave <tushar.n.dave@oracle.com>
Cc: alsa-devel@alsa-project.org, thomas.tai@oracle.com, perex@perex.cz, sparclinux@vger.kernel.org

On Thu, 24 Nov 2016 21:35:16 +0100,
Tushar Dave wrote:
> 
> dbri uses 'u32' for dma handle while invoking kernel DMA APIs,
> instead of using dma_addr_t. This hasn't caused any 'incompatible
> pointer type' warning on SPARC because until now dma_addr_t is of
> type u32. However, recent changes in SPARC ATU (iommu) enabled 64bit
> DMA and therefore dma_addr_t became of type u64. This makes
> 'incompatible pointer type' warnings inevitable.
> 
> e.g.
> sound/sparc/dbri.c: In function ‘snd_dbri_create’:
> sound/sparc/dbri.c:2538: warning: passing argument 3 of ‘dma_zalloc_coherent’ from incompatible pointer type
> ./include/linux/dma-mapping.h:608: note: expected ‘dma_addr_t *’ but argument is of type ‘u32 *’
> 
> For the record, dbri(sbus) driver never executes on sun4v. Therefore
> even though 64bit DMA is enabled on SPARC, dbri continues to use
> legacy iommu that guarantees DMA address is always in 32bit range.
> 
> This patch resolves above compiler warning.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> Reviewed-by: thomas tai <thomas.tai@oracle.com>
> ---
> v2->v3:
> - Use %pad to print dma_addr_t. Comment by Takashi Iwai.

Applied now.  Thanks!


Takashi
