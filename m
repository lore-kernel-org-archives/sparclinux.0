From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 27 Apr 2016 09:34:38 +0000
Subject: Re: [PATCH v5 2/4] printk/nmi: warn when some message has been lost in NMI context
Message-Id: <20160427093438.GK19428@n2100.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-3-git-send-email-pmladek@suse.com>
In-Reply-To: <1461239325-22779-3-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 21, 2016 at 01:48:43PM +0200, Petr Mladek wrote:
> @@ -64,8 +65,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
>  again:
>  	len = atomic_read(&s->len);
>  
> -	if (len >= sizeof(s->buffer))
> +	if (len >= sizeof(s->buffer)) {
> +		atomic_inc(&nmi_message_lost);

This should be fine - I think its reasonable to expect that no one is
using a spinlock implementation for their atomic ops for this...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
