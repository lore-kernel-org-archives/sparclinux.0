From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 Jan 2016 23:06:32 +0000
Subject: Re: [PATCH v7] Add sun4v_wdt watchdog driver
Message-Id: <56ABF078.1070807@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1454089178-29836-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1454089178-29836-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Coekaerts <wim.coekaerts@oracle.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

On 01/29/2016 09:39 AM, Wim Coekaerts wrote:
> This driver adds sparc hypervisor watchdog support. The default
> timeout is 60 seconds and the range is between 1 and
> 31536000 seconds. Both watchdog-resolution and
> watchdog-max-timeout MD properties settings are supported.
>
> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

