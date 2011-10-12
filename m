From: David Miller <davem@davemloft.net>
Date: Wed, 12 Oct 2011 23:42:28 +0000
Subject: Re: longjmp question
Message-Id: <20111012.194228.1134598667227819099.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 13 Oct 2011 00:21:28 +0100

> On Wed, Oct 12, 2011 at 07:06:17PM -0400, David Miller wrote:
>> 
>> Jurij, how do I setup this testcase?
>> 
>> I checked out Ruby from SVN and built it, but I can't find this
>> miniruby thing so that I can run the command line in that Ruby bug
>> report.
>> 
>> Thanks.
> 
> Thanks for looking at it! Attached is a script which I use to set up 
> the environment and start gdb for the binary (you probably will need 
> directory names adjusted, if you are building from directly from svn 
> and not from Debian package). I'm still in the process of trying to 
> understand what's Ruby is trying to do with all the machine state 
> saves and restores, so I was not able to make a lot of progress so 
> far.

Thanks for the script.

Ruby is too clever for it's own good.  Right before it calls setjmp()
it copies the stack frame down to the current bottom of the stack
into a save area.

Later, right before it longjmp()'s, it copies back to the stack from
the save area.

Look at the "workaround" for x86-86 in cont_restore_1(), and all of
the special case code they need in order to get IA64 right.

What a mess.

This is only going to get worse when GCC's support for shrink-wrapping
and other interesting features propagates.  There is no guarentee that
the stack won't expand further downward between when Ruby saves the
stack frames and when it does it's setjmp() call, and it very much
relies upon that such a stack expansion not happening.

Anyways I'll see if there is some way to salvage this and make it
work.  I suspect that Solaris doesn't have the restore loop
optimization we do in longjmp, and that's why Ruby works there with
the same compilers on sparc.

