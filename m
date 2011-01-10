From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jan 2011 22:13:42 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110110.141342.176644790.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


In order to attack this better, can you possibly get the
".properties" output from the framebuffer device node?

Something like:

ok cd /pci@1f,0/SUNW,m64B@13
ok .properties

at the firmware prompt right after reset should do the trick.

Thanks!
