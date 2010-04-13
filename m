From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:48:52 +0000
Subject: [PATCH 0/3] sparc64 kmemleak support
Message-Id: <20100412.234852.91191574.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This three part patch set adds kmemleak support to sparc64 (trivial)
and fixes up two potential leak issues that this feature warns about.
