From: David Miller <davem@davemloft.net>
Date: Wed, 03 Nov 2010 12:20:18 +0000
Subject: Re: [PATCH] fix openpromfs compile
Message-Id: <20101103.052018.226784548.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1011031134290.17199@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1011031134290.17199@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 3 Nov 2010 11:37:59 +0200 (EET)

> Fix openpromfs compilation by adding a missing semicolon in 
> fs/openpromfs/inode.c openprom_mount().
> 
> Signed-off-by: Meelis Roos <mroos@linux.ee>

I already asked Al Viro (who added this bug and you didn't
CC:) to fix this problem.

Thanks.
