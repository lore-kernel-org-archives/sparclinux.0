From: Bob Breuer <breuerr@mc.net>
Date: Wed, 09 Mar 2011 06:16:50 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <4D771B52.7070104@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Marcel van Nies wrote:
> Hi,
> 
> git bisect came up with this:
> 
> 4d14a459857bd151ecbd14bcd37b4628da00792b is the first bad commit
> commit 4d14a459857bd151ecbd14bcd37b4628da00792b
> Author: David S. Miller <davem@davemloft.net>
> Date:   Thu Dec 10 23:32:10 2009 -0800
> 
>     sparc: Stop trying to be so fancy and use __builtin_{memcpy,memset}()
> 
>     This mirrors commit ff60fab71bb3b4fdbf8caf57ff3739ffd0887396
>     (x86: Use __builtin_memset and __builtin_memcpy for memset/memcpy)
> 
>     Signed-off-by: David S. Miller <davem@davemloft.net>


My guess is that we're no longer using the special hyperSparc block copy
and fill from mm/hypersparc.S and are now leaving some data in the cache
that wasn't there before.

Unfortunately, my hyperSparc is failing from a completely different commit:
commit b6a2fea39318e43fee84fa7b0b90d68bed92d2ba
Author: Ollie Wild <aaw@google.com>
Date:   Thu Jul 19 01:48:16 2007 -0700

    mm: variable length argument support


The result I have is that the argv array for new commands looks
completely empty leading to this strange output when booting:

Freeing unused kernel memory: 144k freed
modprobe: FATAL: Module  not found.

INIT: version 2.86 booting
: : No such file or directory
INIT: Entering runlevel: 3
: : No such file or directory


There must be a missing cache flush somewhere in there that's needed for
the argv array...

Bob
