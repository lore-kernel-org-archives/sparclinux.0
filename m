From: David Miller <davem@davemloft.net>
Date: Mon, 02 Mar 2015 05:46:12 +0000
Subject: Re: [PATCH] sunvdc: don't dereference port->disk before disk probe finishes
Message-Id: <20150302.004612.409094040042578991.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1422381112-21571-1-git-send-email-dwight.engen@oracle.com>
In-Reply-To: <1422381112-21571-1-git-send-email-dwight.engen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dwight Engen <dwight.engen@oracle.com>
Date: Tue, 27 Jan 2015 12:51:52 -0500

> If the backing file for a vdisk is not present in the service domain an
> ldc reset can occur during the initial port/disk probing. The ldc reset
> logic was dereferencing port->disk, which may not have been setup yet.
> Guard against this case.
> 
> Orabug: 20362258
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
 ...
> @@ -938,6 +938,8 @@ err_out_free_tx_ring:
>  	vdc_free_tx_ring(port);
>  
>  err_out_free_ldc:
> +	flush_work(&port->ldc_reset_work);
> +	del_timer_sync(&port->ldc_reset_timer);
>  	vio_ldc_free(&port->vio);

This hunk has absolutely nothing to do with the bug you claim
to be fixing in your commit message, and needs to be split out
into a separate fix where you explain why these two calls are
necessary and exactly what the change is fixing.

Thanks.
