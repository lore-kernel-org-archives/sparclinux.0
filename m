From: David Miller <davem@davemloft.net>
Date: Sat, 21 Sep 2013 05:15:46 +0000
Subject: [PATCH 0/6] Make PAGE_OFFSET variable.
Message-Id: <20130921.011546.399976981566163964.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Basically the first 5 patches deconstruct the whole situation,
then the final patch throws the switch and makes PAGE_OFFSET
variable based upon cpu type.

I tested this patch series lightly on a T4.  This obviously
isn't enough to fully support 47-bit physical addresses yet,
and I'll be looking into the page table issues next to take
care of that.

Signed-off-by: David S. Miller <davem@davemloft.net>
