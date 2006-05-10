From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 10 May 2006 20:29:34 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060510.132934.100052401.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 10 May 2006 00:15:08 -0700 (PDT)

> --- a/drivers/scsi/esp.c
> +++ b/drivers/scsi/esp.c
> @@ -2068,14 +2068,12 @@ static int esp_reset(struct scsi_cmnd *S
>   {
>   	struct esp *esp = (struct esp *) SCptr->device->host->hostdata;
> 
> +	spin_lock_irq(esp->ehost->host_lock);
>   	(void) esp_do_resetbus(esp);
> -
>   	spin_unlock_irq(esp->ehost->host_lock);
> 
>   	wait_event(esp->reset_queue, (esp->resetting_bus = 0));
> 
> -	spin_lock_irq(esp->ehost->host_lock);
> -
>   	return SUCCESS;
>   }
> 
> I have not nearly enough knowledge to tell whether that is correct, but 
> the fact that in the previous version the function is left with the lock 
> held and in the new one - without it, struck me as suspicious.

I don't know where you got that weird patch from, the current function
looks like this:

static int esp_reset(struct scsi_cmnd *SCptr)
{
	struct esp *esp = (struct esp *) SCptr->device->host->hostdata;

	spin_lock_irq(esp->ehost->host_lock);
	(void) esp_do_resetbus(esp);
	spin_unlock_irq(esp->ehost->host_lock);

	wait_event(esp->reset_queue, (esp->resetting_bus = 0));

	return SUCCESS;
}

The caller from the EH subsystem in drivers/scsi/scsi_error.c does not
hold the host lock, so we need to acquire it around the critical
section, which in this case is esp_do_resetbus(), then we drop
the lock in order to wait on the reset queue which is a blocking
operation and thus cannot hold any spinlocks.
