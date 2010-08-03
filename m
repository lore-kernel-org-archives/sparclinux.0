From: David Miller <davem@davemloft.net>
Date: Tue, 03 Aug 2010 07:35:08 +0000
Subject: kgdb/sunhv patch
Message-Id: <20100803.003508.35833306.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This change makes no sense.

The hypervisor console is never hooked up to a real "UART" where
a kgdb client could be sitting at the other end.

Rather, it's always just a path for characters to and from the
hypervisor console device which is a virtual device in the guest
system.
