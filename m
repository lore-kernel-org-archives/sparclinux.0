From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 24 Nov 2016 12:59:10 +0000
Subject: Re: [PATCH v2] dbri: Fix compiler warning
Message-Id: <s5hfumh9gpt.wl-tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1479957315-2517-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1479957315-2517-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tushar Dave <tushar.n.dave@oracle.com>
Cc: alsa-devel@alsa-project.org, thomas.tai@oracle.com, perex@perex.cz, sparclinux@vger.kernel.org

On Thu, 24 Nov 2016 04:15:15 +0100,
Tushar Dave wrote:
> 
> @@ -2539,7 +2545,7 @@ static int snd_dbri_create(struct snd_card *card,
>  	if (!dbri->dma)
>  		return -ENOMEM;
>  
> -	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
> +	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08llx)\n",
>  		dbri->dma, dbri->dma_dvma);

Better to use %pad for dma_addr_t here.
If the config doesn't enable ATU, dma_addr_t would be still u32, and
your change will be buggy.


thanks,

Takashi
