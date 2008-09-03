From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 23:00:22 +0000
Subject: [PATCH 0/3]: Mostek post-mortum
Message-Id: <20080903.160022.126078558.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


After Krzysztof's changes, we can delete a lot of things
which are unnecessary now.  This includes the SBUS RTC
driver, all includes of asm/mostek.h and that header itself.
