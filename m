From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 08 Mar 2011 06:00:39 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq
Message-Id: <20110308060039.GA23819@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Marcel.

Added davem...
We see strange SEGV faults in userspace and fail to read from ext2..
All on some (but not all) sparc32 boxes.

On Tue, Mar 08, 2011 at 02:10:03AM +0100, Marcel van Nies wrote:
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
> 
> Marcel

Great work!

Did you try a clean revert on said commit on top of sparc-next?
Just to confirm that this indeed the commit causing the bug -
and that reverting it fixes the bug.
Maybe you already planned to do so...

Looking at the commit I can see that it will require same hand-editing
to revert it. Obviously you can skip the parts that touches
sparc64 files.
On the way out of the door - so I cannot produce a patch
for you right away.

	Sam
