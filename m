Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AE2FC00D;
	Sun,  4 Oct 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118235; cv=none; b=A1gqI5ClLscQBSmw1o5g9ooXOsGXFF8VZgEd6SfVbjIhu+8/+3BaEIZ9z6iLqr/4eUwxU4pG5ZylPnT11BNMlEGAH+doBnKZxeZTfIyHzeOlwqK83fb/0a/wSZSPg/cYG5dHiLl3XqA7jpGG/JX5XbdYtzVLNlpZ/5nGC1pDN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118235; c=relaxed/simple;
	bh=gvg/uEuunYBpFGP+kj5DUE33VrET+PTZAyQnN4cLGr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFTNZqGJQosvX0WS9mmXNhAb/qSUAQtXDepqy6dlANgH+HwdnhadjmWT0ffYijvvEvQLYFUNJsvd5JQEF0zRK9H0REIbO8tTeXYYvYazwYVVKqwuiMs8KHaJYw2djGxpSQXKN4Q5RF8JuPZOVNkesKmrt/v3umzW6misBtx0z7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ttKVHQ8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ttKVHQ8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4981F000FF;
	Sun,  4 Oct 2026 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791118233;
	bh=3ZtGmx15jwharaXgISQPu3qx8gouZaTHhMJZp2J8OuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ttKVHQ8MJkCTUhjQ5o1HgalBMsSny5703FqddDwf7MgN2RrsHP6OWR1RKpunrSu4S
	 dbQvGT3bydCcrYlgq3oEXw/x2jIQn85+RusouQIxth+NwADkbLdvu+Zvg08H9Asbrf
	 cZ/1jFdwhbU/PxuLOeuXtgiry66IStfglcI1oWTQ=
Date: Sun, 4 Oct 2026 14:50:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 7/7] hvc: add an M3000 firmware console backend
Message-ID: <2026100415-impromptu-sultry-ce6b@gregkh>
References: <20261002161515.932316-1-linmag7@gmail.com>
 <20261002161515.932316-8-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002161515.932316-8-linmag7@gmail.com>

On Fri, Oct 02, 2026 at 06:14:29PM +0200, Magnus Lindholm wrote:
> Provide hvc0 through the IKKAKU Open Firmware pseudo-console, validating
> model and console properties before matching. Serialize firmware calls,
> keep the bounce buffer in locked mappings and poll input each open tick.
> 
> Keep output buffers const and bound no-progress retries because HVC
> retries EAGAIN indefinitely. A stalled firmware call remains unbounded.
> Use the existing SPARC p1275 interface and HVC output contract.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  MAINTAINERS                 |   6 ++
>  drivers/tty/hvc/Kconfig     |  10 +++
>  drivers/tty/hvc/Makefile    |   2 +
>  drivers/tty/hvc/hvc_m3000.c | 167 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 185 insertions(+)
>  create mode 100644 drivers/tty/hvc/hvc_m3000.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..5bc9b1cabd0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10728,6 +10728,12 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/fujitsu-laptop.c
>  
> +FUJITSU M3000 FIRMWARE CONSOLE
> +M:	Magnus Lindholm <linmag7@gmail.com>
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +F:	drivers/tty/hvc/hvc_m3000.c
> +
>  FUJITSU TABLET EXTRAS
>  M:	Robert Gerlach <khnz@gmx.de>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 5866195de26a..0feb7ec98f4f 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -134,3 +134,13 @@ config HVCS
>  	  will depend on arch specific APIs exported from hvcserver.ko
>  	  which will also be compiled when this driver is built as a
>  	  module.
> +
> +config HVC_M3000
> +	bool "M3000 firmware pseudo-console"
> +	depends on SPARC64_VII
> +	select HVC_DRIVER
> +	help
> +	  Provide hvc0 using Open Firmware stdin/stdout on IKKAKU only.
> +	  Input is polled; no native UART registers are accessed.
> +	  Firmware calls are serialized and use a locked-image bounce buffer.
> +	  Say Y to use the M3000 firmware pseudo-console as hvc0.
> diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
> index 98880e357941..5b0277deb7c9 100644
> --- a/drivers/tty/hvc/Makefile
> +++ b/drivers/tty/hvc/Makefile
> @@ -11,3 +11,5 @@ obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
>  obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
>  obj-$(CONFIG_HVC_RISCV_SBI)	+= hvc_riscv_sbi.o
>  obj-$(CONFIG_HVCS)		+= hvcs.o
> +
> +obj-$(CONFIG_HVC_M3000) += hvc_m3000.o

No need for a blank line, right?  And why no tab used here?

> diff --git a/drivers/tty/hvc/hvc_m3000.c b/drivers/tty/hvc/hvc_m3000.c
> new file mode 100644
> index 000000000000..0ef4c888a6a2
> --- /dev/null
> +++ b/drivers/tty/hvc/hvc_m3000.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Experimental M3000 Open Firmware pseudo-console backend. */

What will make it not "experimental"?

And no copyright?



> +#include <linux/console.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/irqflags.h>
> +#include <linux/string.h>
> +#include <linux/spinlock.h>
> +#include <linux/timer.h>
> +#include <asm/oplib.h>
> +#include <asm/spitfire.h>
> +#include "hvc_console.h"
> +
> +#define M3000_WRITE_ATTEMPTS 8

why 8?

> +
> +static int m3000_stdin;
> +static bool m3000_ready;
> +/* Keep firmware buffers within the locked kernel image mappings. */
> +static u8 m3000_buffer[256];
> +static DEFINE_RAW_SPINLOCK(m3000_buffer_lock);
> +static struct timer_list m3000_poll_timer;
> +static bool m3000_poll_active;

Shouldn't these be in a structure attached to the console somewhere?
Otherwise you have limited yourself to just one of these.

> +
> +/*
> + * HVC's idle backoff can exceed the firmware input FIFO's capacity.
> + * Wake its worker each tick while open; keep PROM calls out of the timer.
> + */
> +static void m3000_poll_tick(struct timer_list *timer)
> +{
> +	if (!READ_ONCE(m3000_poll_active))
> +		return;

Why are you accessing m3000_poll_active like this in an attempt to not
use a real lock?  Are you _sure_ a bool will work this way properly?

> +	hvc_kick();
> +	mod_timer(&m3000_poll_timer, jiffies + 1);
> +}
> +
> +static int m3000_open(struct hvc_struct *hp, int data)
> +{
> +	WRITE_ONCE(m3000_poll_active, true);
> +	mod_timer(&m3000_poll_timer, jiffies + 1);
> +	return 0;
> +}
> +
> +static void m3000_close(struct hvc_struct *hp, int data)
> +{
> +	WRITE_ONCE(m3000_poll_active, false);
> +	timer_delete_sync(&m3000_poll_timer);
> +}
> +
> +static ssize_t m3000_io(u8 *in, const u8 *out, size_t count)
> +{
> +	unsigned long args[7], flags;
> +	bool input = in != NULL;
> +	int ret;
> +
> +	if (!count)
> +		return 0;
> +	count = min_t(size_t, count, input ? 1 : sizeof(m3000_buffer));

No need for min_t(), why not just min()?

> +	/* Serialize the bounce buffer; p1275 separately serializes firmware. */
> +	raw_spin_lock_irqsave(&m3000_buffer_lock, flags);

why is this a "raw" spinlock?

> +	if (!input)
> +		memcpy(m3000_buffer, out, count);
> +	args[0] = (unsigned long)(input ? "read" : "write");

A string being cast to an unsigned long?  Are you _sure_?

> +	args[1] = 3;
> +	args[2] = 1;
> +	args[3] = (unsigned int)(input ? m3000_stdin : prom_stdout);
> +	args[4] = (unsigned long)m3000_buffer;
> +	args[5] = count;
> +	args[6] = (unsigned long)-1;
> +	p1275_cmd_direct(args);
> +	ret = (int)args[6];
> +	if (ret > 0 && ret <= count && input)
> +		memcpy(in, m3000_buffer, ret);
> +	raw_spin_unlock_irqrestore(&m3000_buffer_lock, flags);
> +	if (ret == -2 || ret == 0)
> +		return input ? 0 : -EAGAIN;
> +	if (ret < 0 || ret > count)
> +		return -EIO;
> +	return ret;
> +}
> +
> +static ssize_t m3000_get(u32 termno, u8 *buf, size_t count)
> +{
> +	return m3000_io(buf, NULL, count);
> +}
> +
> +static ssize_t m3000_put(u32 termno, const u8 *buf, size_t count)
> +{
> +	ssize_t ret;
> +	int attempt;
> +
> +	/*
> +	 * HVC retries -EAGAIN forever, so drop this chunk without logging when
> +	 * the no-progress budget expires. This cannot bound a stalled firmware
> +	 * call or lock acquisition.
> +	 */
> +	for (attempt = 0; attempt < M3000_WRITE_ATTEMPTS; attempt++) {
> +		ret = m3000_io(NULL, buf, count);
> +		if (ret != -EAGAIN)
> +			return ret;
> +		cpu_relax();
> +	}
> +	return -EIO;
> +}
> +
> +static const struct hv_ops m3000_ops = {
> +	.get_chars = m3000_get,
> +	.put_chars = m3000_put,
> +	.notifier_add = m3000_open,
> +	.notifier_del = m3000_close,
> +	.notifier_hangup = m3000_close,
> +};
> +
> +static bool __init m3000_property_matches(phandle node, const char *prop,
> +					 const char *expected)
> +{
> +	char value[64];
> +	int len;
> +
> +	len = prom_getproperty(node, prop, value, sizeof(value) - 1);
> +	if (len <= 0)
> +		return false;
> +	value[len] = '\0';
> +	return !strcmp(value, expected);
> +}
> +
> +static int __init m3000_console_init(void)
> +{
> +	phandle node;
> +	int ret;
> +
> +	if (tlb_type != sparc64_vii)
> +		return -ENODEV;
> +	if (!m3000_property_matches(prom_finddevice("/"), "model", "IKKAKU"))
> +		return -ENODEV;
> +	m3000_stdin = prom_getint(prom_chosen_node, "stdin");
> +	if (!m3000_stdin || m3000_stdin == -1 || !prom_stdout || prom_stdout == -1)
> +		return -ENODEV;
> +	node = prom_inst2pkg(prom_stdout);
> +	if (!m3000_property_matches(node, "name", "pseudo-console"))
> +		return -ENODEV;
> +	node = prom_inst2pkg(m3000_stdin);
> +	if (!m3000_property_matches(node, "name", "pseudo-console"))
> +		return -ENODEV;
> +	ret = hvc_instantiate(0, 0, &m3000_ops);
> +	if (ret < 0)
> +		return ret;
> +	m3000_ready = true;
> +	return 0;
> +}
> +console_initcall(m3000_console_init);
> +
> +static int __init m3000_tty_init(void)
> +{
> +	struct hvc_struct *hp;
> +
> +	if (!m3000_ready)
> +		return -ENODEV;
> +	timer_setup(&m3000_poll_timer, m3000_poll_tick, 0);
> +	hp = hvc_alloc(0, 0, &m3000_ops, sizeof(m3000_buffer));
> +	if (IS_ERR(hp))
> +		return PTR_ERR(hp);
> +	hp->ws.ws_row = 24;
> +	hp->ws.ws_col = 80;
> +	pr_info("M3000: firmware-backed hvc0 tty ready (serialized, polled input)\n");

When drivers work properly, they are quiet.

thanks,

greg k-h
