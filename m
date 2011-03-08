From: David Miller <davem@davemloft.net>
Date: Tue, 08 Mar 2011 07:01:20 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110307.230120.226776255.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 8 Mar 2011 07:00:39 +0100

> Added davem...
> We see strange SEGV faults in userspace and fail to read from ext2..
> All on some (but not all) sparc32 boxes.

I saw the original report.

But reverting this commit is the wrong thing to do from what I can
tell.

Either we have:

1) A compiler code gen bug.

2) Some piece of code which is sparc32 specific is invoking memset
   or memcpy in a way which makes assumptions which are in fact not
   valid

3) The code change is merely making cache offsets change, masking the
   true problem

Especially in cases #2 and #3 we're just hiding a heisen-bug and
not fixing the real problem.
