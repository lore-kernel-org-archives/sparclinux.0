From: David Miller <davem@davemloft.net>
Date: Wed, 22 Sep 2010 21:15:14 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100922.141514.232744402.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTi=pJUKRUQhpcVV8XAJF+BO1440v1Py5Opr34DR1@mail.gmail.com>
	<20100922195349.GF19804@ZenIV.linux.org.uk>
	<20100922204323.GG19804@ZenIV.linux.org.uk>
In-Reply-To: <20100922204323.GG19804@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 22 Sep 2010 21:43:24 +0100

> 	Actually, I wonder why don't we do the following:
> 1) check wsaved first, do fault_in_user_windows() if needed (and probably do
> Something Cruel(tm) if we fail copy_to_user() in there)
> 2) in a loop check if we need to reschedule / if we need to handle signals
> 3) don't bother with wsaved checks in setup_frame() variants at all -
> wsaved can't grow back at that point; we also can use flush_user_windows()
> instead of full synchronize_user_stack() in there.
> 
> It's definitely a separate patch, but it looks like it might be worth
> doing...  Comments?

Ok, let me think about this.

I think there are two things:

1) I think I originally intended to allow the signal dispatch to
   succeed even if we had windows we couldn't fault in.

   The idea is that the wsaved windows would be put into the signal
   frame.

   This never was implemented, however...

2) It would be nice to, in this case, still be able to let the debugger
   have a look.

   And part of "having a look" would mean letting it see the registers
   from the windows we couldn't save onto the stack.

   Otherwise GDB is just going to try and access the stack pages we
   were unable to.

Making #2 work could be done with an implementation of #1, since GDB
would need to be able to fetch the values easily from somewhere and
the signal frame storage we create for #1 would be as good as any.

I can't see much utility for a user signal handler for #1, however,
other than getting an accurate stack backtrace to emit a crash log
message or similar.

Alternatively, #2 could be implemented using a special ptrace getregs
call created specifically to fetch the windowed registers.  And
the regset implementation of that could be used for dumping them
into core files as well, and this specifically I've been meaning to
do at some point.

Again, let me think about this some more.
