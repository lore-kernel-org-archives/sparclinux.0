From: Ben Collins <bcollins@debian.org>
Date: Tue, 01 Jun 2004 00:17:23 +0000
Subject: Re: RFC: defining sbus dma direction bits in terms of enum dma_data_direction?
Message-Id: <20040601001723.GD11678@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531124455.GA16822@lst.de>
In-Reply-To: <20040531124455.GA16822@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> @@ -231,7 +227,7 @@
>  		case FC_STATUS_ERR_OFFLINE:
>  			fc->state = FC_STATE_OFFLINE;
>  			dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi),
> -					  FC_DMA_BIDIRECTIONAL);
> +					  _DMA_BIDIRECTIONAL);
>  			printk ("%s: FC is offline\n", fc->name);
>  			if (atomic_dec_and_test (&l->todo))
>  				up(&l->sem);

Typo? s/_DMA_BIDIRECTIONAL/DMA_BIDIRECTIONAL/

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
