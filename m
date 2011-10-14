From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 14 Oct 2011 23:06:53 +0000
Subject: Re: longjmp question
Message-Id: <20111014230653.GA14179@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Oct 13, 2011 at 06:35:18PM -0400, David Miller wrote:
> Something you might want to try, compile cont.c into an assembler
> file cont.s, then insert the following around the flushw
> 
> 	mov	%fp, %g1
> 	flushw
> 	mov	%fp, %g2
> 
> Then compile that into an object and link up ruby.
> 
> In the debugger, breakpoint right after that "mov %fp, %g2" and
> print out from GDB the values of %g1 and %g2.  This might give
> some hints as to what's going on exactly.
> 
> Another test, go into Ruby's defines.h and get rid of the:
> 
> # if defined(__sparc_v9__) || defined(__sparcv9) || defined(__arch64__)
>         ("flushw")
> # else
> 
> and make it always use "ta 0x03" instead of "flushw".  This might
> explain why the Ruby developers can't reproduce this on Solaris.  That
> could happen if for some reason their Solaris build isn't setting the
> defines that guard the flushw instruction usage.
> 
> If using "ta 0x03" instead of "flushw" makes a difference that would
> be a huge clue.

Replacing "flushw" with "ta 0x03" makes the problem go away. What is 
the difference between the two? I would naively think that the effect 
of both should be saving register windows on the stack, allocating a
new stack frame for each of them, so fp would get adjusted in either 
case. Then I would expect that the correct fix would be to indicate to 
the compiler that flushw is clobbering fp/sp registers, so it cannot 
rely on their contents afterwards. The fact that using "ta 0x03" fixes 
it makes me feel lost again :-).

Unfortunately, I was unable to do a conclusive second test (copying fp 
to some registers before and after flushw) so far, as inserting a 
break even after flushw but before memcpy() call makes the problem go 
away as well. I can break after memcpy, but it might clobber the 
registers, so the saving part would need to be a bit more elaborate.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
