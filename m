From: Christoph Hellwig <hch@lst.de>
Date: Sat, 14 Jul 2007 17:42:39 +0000
Subject: Re: [PATCH] pluto: use wait_for_completion_timeout
Message-Id: <20070714174239.GA15672@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20070513154901.GA9218@lst.de>
In-Reply-To: <20070513154901.GA9218@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

ping?

On Sun, May 13, 2007 at 05:49:01PM +0200, Christoph Hellwig wrote:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/drivers/scsi/pluto.c
> =================================> --- linux-2.6.orig/drivers/scsi/pluto.c	2007-05-13 16:43:25.000000000 +0200
> +++ linux-2.6/drivers/scsi/pluto.c	2007-05-13 16:46:31.000000000 +0200
> @@ -4,6 +4,7 @@
>   *
>   */
>  
> +#include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/types.h>
> @@ -50,16 +51,10 @@ static struct ctrl_inquiry {
>  } *fcs __initdata;
>  static int fcscount __initdata = 0;
>  static atomic_t fcss __initdata = ATOMIC_INIT(0);
> -DECLARE_MUTEX_LOCKED(fc_sem);
> +static DECLARE_COMPLETION(fc_detect_complete);
>  
>  static int pluto_encode_addr(Scsi_Cmnd *SCpnt, u16 *addr, fc_channel *fc, fcp_cmnd *fcmd);
>  
> -static void __init pluto_detect_timeout(unsigned long data)
> -{
> -	PLND(("Timeout\n"))
> -	up(&fc_sem);
> -}
> -
>  static void __init pluto_detect_done(Scsi_Cmnd *SCpnt)
>  {
>  	/* Do nothing */
> @@ -69,7 +64,7 @@ static void __init pluto_detect_scsi_don
>  {
>  	PLND(("Detect done %08lx\n", (long)SCpnt))
>  	if (atomic_dec_and_test (&fcss))
> -		up(&fc_sem);
> +		complete(&fc_detect_complete);
>  }
>  
>  int pluto_slave_configure(struct scsi_device *device)
> @@ -96,7 +91,6 @@ int __init pluto_detect(struct scsi_host
>  	int i, retry, nplutos;
>  	fc_channel *fc;
>  	struct scsi_device dev;
> -	DEFINE_TIMER(fc_timer, pluto_detect_timeout, 0, 0);
>  
>  	tpnt->proc_name = "pluto";
>  	fcscount = 0;
> @@ -187,15 +181,11 @@ int __init pluto_detect(struct scsi_host
>  			}
>  		}
>  	    
> -		fc_timer.expires = jiffies + 10 * HZ;
> -		add_timer(&fc_timer);
> -		
> -		down(&fc_sem);
> +		wait_for_completion_timeout(&fc_detect_complete, 10 * HZ);
>  		PLND(("Woken up\n"))
>  		if (!atomic_read(&fcss))
>  			break; /* All fc channels have answered us */
>  	}
> -	del_timer_sync(&fc_timer);
>  
>  	PLND(("Finished search\n"))
>  	for (i = 0, nplutos = 0; i < fcscount; i++) {
---end quoted text---
