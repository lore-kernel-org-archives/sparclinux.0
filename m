From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 08:42:01 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080821.014201.244210889.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 11:16:58 +0300 (EEST)

> kobject: 'notes' (fffff8006cae2e58): kobject_add_internal: parent: 'sr_mod', set: '<NULL>'
> Driver 'sr' needs updating - please use bus_type methods
> kobject: 'sr' (fffff8006ca166d8): kobject_add_internal: parent: 'drivers', set: 'drivers'

If this were happing before userland starts up I would have asked you
to add "initcall_debug" to the kernel boot command line, but this is
from modules being loaded in userspace via udev so that won't help.

Too bad we don't have a module load init function tracer.

