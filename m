From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:55:47 +0000
Subject: [PATCH 0/3]: sun4m timer rework, try 2
Message-Id: <20080910.235547.243605729.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Ok, let's try this again.

The first two patches work to let us use the OF device driver
layer facilities much earlier in the boot process.

And then the third is the sun4m timers patch, with no changes
from last time.

Robert, let me know how it works out.

Thanks!
