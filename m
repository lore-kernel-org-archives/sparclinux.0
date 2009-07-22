From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jul 2009 04:29:43 +0000
Subject: SUN4D RTC patch...
Message-Id: <20090721.212943.179689253.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Please use a test of of_find_property() to see if the
"address" property exists, rather than your hand-crafted
loop (which is buggy and doesn't properly lock the property
list, as well as duplicating code for which a standard
implementation and interface already exists).

THanks.
