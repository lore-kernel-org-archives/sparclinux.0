From: David Miller <davem@davemloft.net>
Date: Fri, 26 Feb 2016 17:21:12 +0000
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc
Message-Id: <20160226.122112.1169840448330570848.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
	<1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
	<56D02FB8.90803@ti.com>
In-Reply-To: <56D02FB8.90803@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 12:58:00 +0200

> While doing this, did you just go forward removing the module support,
> or did you check if it would be trivial to make the driver build as a
> module? I wouldn't be surprised if in some cases all that would need to
> be done is change the Kconfig's bool to tristate.

I think what he is doing is reasonable, and none of these sparc drivers
have any reason to be built modular.  You need them to have any bootup
console whatsoever, so they have to be built in statically to be
usable at all.

I plan to apply this patch series to my sparc tree as-is.
