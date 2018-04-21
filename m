From: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 21 Apr 2018 09:04:49 +0000
Subject: Re: [PATCH v4 1/2] char: sparc64: Add privileged ADI driver
Message-Id: <20180421090449.GA8194@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420205221.488589-1-tom.hromatka@oracle.com>
 <20180420205221.488589-2-tom.hromatka@oracle.com>
In-Reply-To: <20180420205221.488589-2-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Apr 20, 2018 at 02:52:20PM -0600, Tom Hromatka wrote:
> --- /dev/null
> +++ b/drivers/char/adi.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0

Good, but:

> +MODULE_LICENSE("GPL");

That's the wrong line :(

Read include/linux/module.h for the correct string to put here for a
GPL version 2 only module.

thanks,

greg k-h
