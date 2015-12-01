From: Jiri Kosina <jikos@kernel.org>
Date: Tue, 01 Dec 2015 23:24:49 +0000
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <alpine.LNX.2.00.1512020022460.32500@pobox.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <201511271919.aEZuZKNe%fengguang.wu@intel.com>
 <20151127153804.GC2648@pathway.suse.cz>
In-Reply-To: <20151127153804.GC2648@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 27 Nov 2015, Petr Mladek wrote:

> MN10300 has its own implementation for entering and exiting NMI 
> handlers. It does not call nmi_enter() and nmi_exit(). Please, find 
> below an updated patch that adds printk_nmi_enter() and 
> printk_nmi_exit() to the custom entry points. Then we could add HAVE_NMI 
> to arch/mn10300/Kconfig and avoid the above warning.

Hmm, so what exactly would go wrong if MN10300 (whatever that architecture 
is) would call nmi_enter() and nmi_exit() at the places where it's 
starting and finishing NMI handler?

From a cursory look, it seems like most (if not all) of the things called 
from nmi_{enter,exit}() would be nops there anyway.

Thanks,

-- 
Jiri Kosina
SUSE Labs

