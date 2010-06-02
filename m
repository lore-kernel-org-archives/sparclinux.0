From: David Miller <davem@davemloft.net>
Date: Wed, 02 Jun 2010 09:08:36 +0000
Subject: Re: [2.6.35-rc1 regression] sysfs: cannot create duplicate
Message-Id: <20100602.020836.25148560.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <19461.26166.427857.612983@pilspetsen.it.uu.se>
	<20100601.153105.90813554.davem@davemloft.net>
	<20100602030925.GA3402@canonical.com>
In-Reply-To: <20100602030925.GA3402@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: achiang@canonical.com
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Alex Chiang <achiang@canonical.com>
Date: Tue, 1 Jun 2010 21:09:25 -0600

> Does sparc64 load any PCI hotplug drivers?

Never.  And everything and all PCI controllers and devices are probed
and registered at boot time.
