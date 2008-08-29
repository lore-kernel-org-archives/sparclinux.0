From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 22:45:07 +0000
Subject: [PATCH 0/3]: RIO watchdog conversion to pure OF driver
Message-Id: <20080829.154507.146804638.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This gets rid of the usage of the EBUS bus layer, and also moves
the driver where it belongs under drivers/watchdog, the Kconfig
bits were at that location already.

I also tidied things up, this driver hasn't been touched in
years. :-)

I'll hit the CP watchdog driver next.
