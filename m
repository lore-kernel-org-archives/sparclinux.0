From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 07 Feb 2018 11:59:56 +0000
Subject: Re: [PATCH net-next] sun: Add SPDX license tags to Sun network drivers
Message-Id: <CAGRGNgXc+GLXmTBVcj-PiZ2MRtUF3HvaZ7a4zgQux0yzEqpLdw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1517945663-3214-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1517945663-3214-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shannon Nelson <shannon.nelson@oracle.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

Hi Shannon,

On Wed, Feb 7, 2018 at 6:34 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> Add the appropriate SPDX license tags to the Sun network drivers
> as outlined in Documentation/process/license-rules.rst.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/sun/Kconfig          | 1 +
>  drivers/net/ethernet/sun/cassini.c        | 1 +
>  drivers/net/ethernet/sun/cassini.h        | 1 +
>  drivers/net/ethernet/sun/ldmvsw.c         | 1 +
>  drivers/net/ethernet/sun/niu.c            | 1 +
>  drivers/net/ethernet/sun/sunbmac.c        | 1 +
>  drivers/net/ethernet/sun/sungem.c         | 1 +
>  drivers/net/ethernet/sun/sunhme.c         | 1 +
>  drivers/net/ethernet/sun/sunqe.c          | 1 +
>  drivers/net/ethernet/sun/sunvnet.c        | 1 +
>  drivers/net/ethernet/sun/sunvnet_common.c | 1 +
>  11 files changed, 11 insertions(+)
>
> diff --git a/drivers/net/ethernet/sun/Kconfig b/drivers/net/ethernet/sun/Kconfig
> index b2caf51..7b982e0 100644
> --- a/drivers/net/ethernet/sun/Kconfig
> +++ b/drivers/net/ethernet/sun/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  #
>  # Sun network device configuration
>  #

I'm not sure that Kconfig files count as source, right?

> diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
> index 113bd57..9020b08 100644
> --- a/drivers/net/ethernet/sun/cassini.c
> +++ b/drivers/net/ethernet/sun/cassini.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /* cassini.c: Sun Microsystems Cassini(+) ethernet driver.
>   *
>   * Copyright (C) 2004 Sun Microsystems Inc.

I understand that this is the specified way to do this, but it's
exceptionally ugly.

Also, shouldn't the SPDX line _replace_ the usual "this program is
free software" license paragraphs? My understanding is that the SPDX
line is functionally equivalent to having the terms spelled out.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
