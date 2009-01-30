From: David Miller <davem@davemloft.net>
Date: Fri, 30 Jan 2009 08:25:49 +0000
Subject: [PATCH 0/3]: NMI watchdog support for sparc64
Message-Id: <20090130.002549.12348127.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


As promised here is the patch set.

Most of the changes involve moving the existing perf
counter NMI bits out of the oprofile code and into
a shared area.

Then we build the NMI watchdog support on top of it.
