From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 29 Jan 2016 15:12:43 +0000
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
Message-Id: <56AB816B.6030900@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Coekaerts <wim.coekaerts@oracle.com>, wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org



On 01/29/2016 12:46 AM, Wim Coekaerts wrote:
<cut>
> +static const struct watchdog_info sun4v_wdt_ident = {
> +	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +	.identity =	"sun4v hypervisor watchdog",
> +	.firmware_version = 0,
> +};

In accordance to watchdog_ioctl() in drivers/watchdog/watchdog_dev.c 
WDIOF_KEEPALIVEPING may be needed here as to enable the support of 
WDIOC_KEEPALIVE ioctl.

Correct? So maybe add it then?

Thanks.
