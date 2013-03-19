From: David Miller <davem@davemloft.net>
Date: Tue, 19 Mar 2013 16:33:06 +0000
Subject: Re: [PATCH] sparc: remove unused "config BITS"
Message-Id: <20130319.123306.1709006318806942163.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1363708727.1390.16.camel@x61.thuisdomein>
In-Reply-To: <1363708727.1390.16.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pebolle@tiscali.nl
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 19 Mar 2013 16:58:47 +0100

> sparc's asm/module.h got removed in commit
> 786d35d45cc40b2a51a18f73e14e135d47fdced7 ("Make most arch asm/module.h
> files use asm-generic/module.h"). That removed the only two uses of this
> Kconfig symbol. So we can remove its entry too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Eyeball tested.

We use this in the Makefile fragments, you cannot remove it.
