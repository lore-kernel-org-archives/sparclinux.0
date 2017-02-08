From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 08 Feb 2017 15:59:47 +0000
Subject: Re: [PATCH v2 net-next 6/9] sunvnet: straighten up message event handling logic
Message-Id: <20170208155947.GE30741@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1486505582-76823-1-git-send-email-shannon.nelson@oracle.com>
 <1486505582-76823-7-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1486505582-76823-7-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shannon Nelson <shannon.nelson@oracle.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On (02/07/17 14:12), Shannon Nelson wrote:
> +
> +	/* we don't expect any other bits */
> +	BUG_ON(port->rx_event & ~(LDC_EVENT_DATA_READY |
> +				  LDC_EVENT_RESET |
> +				  LDC_EVENT_UP));
> +
> +	/* RESET takes precedent over any other event */
> +	if (port->rx_event & LDC_EVENT_RESET) { 
                  :
>  		port->rx_event = 0;
>  		return 0;
>  	}
> +	if (port->rx_event & LDC_EVENT_UP) {
> +		vio_link_state_change(vio, LDC_EVENT_UP);
> +		port->rx_event = 0;
> +		return 0;
> +	}
>  
>  	err = 0;
>  	tx_wakeup = 0;

IIRC there were timing-related situations where you can get woken up with
both UP and DATA_READY, and if my reading of your patch is 
correct, we would ignore the DATA_READY, and return, right?

--Sowmini


