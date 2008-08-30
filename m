From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 00:08:51 +0000
Subject: [PATCH 0/2]: Convert CP watchdog driver to pure OF driver.
Message-Id: <20080829.170851.62828611.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Another rework in order to get rid of EBUS device layer references.

And just like the RIO watchdog driver, we move it under drivers/watchdog/

