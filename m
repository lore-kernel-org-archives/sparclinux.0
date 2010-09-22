From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 22 Sep 2010 23:12:19 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100922231219.GH19804@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTi=pJUKRUQhpcVV8XAJF+BO1440v1Py5Opr34DR1@mail.gmail.com>
 <20100922195349.GF19804@ZenIV.linux.org.uk>
 <20100922204323.GG19804@ZenIV.linux.org.uk>
 <20100922.141514.232744402.davem@davemloft.net>
In-Reply-To: <20100922.141514.232744402.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 22, 2010 at 02:15:14PM -0700, David Miller wrote:

> Alternatively, #2 could be implemented using a special ptrace getregs
> call created specifically to fetch the windowed registers.  And
> the regset implementation of that could be used for dumping them
> into core files as well, and this specifically I've been meaning to
> do at some point.
> 
> Again, let me think about this some more.

OK... sparc32 question: just what the !@#!@# happens if sun4c_rett_stackchk
find (%fp & 7) != 0?  We go to ret_trap_user_stack_is_bolixed, which
tries to page in the underlying page.  OK, suppose it's already there and
readable; we return without doing anything - and go to signal_p.  Which finds
itself with nothing to do, and %fp is *still* buggered.  Spin ad infinitum?
srmmu_rett_stackchk will do the same, BTW...
