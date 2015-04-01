From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 01 Apr 2015 22:27:48 +0000
Subject: Re: [PATCH v2 2/3] kernel/reboot.c: Add orderly_reboot for graceful reboot
Message-Id: <CAGRGNgUBy0gRZADXmbFzmcAGEf-en=D-rD4Cjoh67Y=iF8puvA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427871888-27331-1-git-send-email-joel@jms.id.au>
 <1427871888-27331-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1427871888-27331-2-git-send-email-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joel Stanley <joel@jms.id.au>
Cc: rusty@rustcorp.com.au, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>, jk@ozlabs.org, sparclinux <sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

Hi Joel,

On Wed, Apr 1, 2015 at 6:04 PM, Joel Stanley <joel@jms.id.au> wrote:
> The kernel has orderly_poweroff which allows the kernel to initiate a
> graceful shutdown of userspace, by running /sbin/poweroff. This adds
> orderly_reboot that will cause userspace to shut itself down by calling
> /sbin/reboot.
>
> This will be used for shutdown initiated by a system controller on
> platforms that do not use ACPI.
>
> orderly_reboot() should be used when the system wants to allow userspace
> to gracefully shut itself down. For cases where the system may
> imminently catch on fire, the existing emergency_restart() provides an
> immediate reboot without involving userspace.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> V2:
>  - remove unused return value from orderly_*
>  - use correct command in orderly_poweroff
>  - the reboot command will not have a proc knob to control it, so
>    it can be made const and static
>
>  include/linux/reboot.h |  3 ++-
>  kernel/reboot.c        | 53 +++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 48bf152..dc5e3bd 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -67,7 +67,8 @@ void ctrl_alt_del(void);
>  #define POWEROFF_CMD_PATH_LEN  256
>  extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
>
> -extern int orderly_poweroff(bool force);
> +extern void orderly_poweroff(bool force);

Should making orderly_poweroff() void be in a separate patch?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
