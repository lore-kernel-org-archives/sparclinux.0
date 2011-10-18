From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 18 Oct 2011 20:46:20 +0000
Subject: Re: longjmp question
Message-Id: <20111018204619.GA4458@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Oct 16, 2011 at 08:56:52PM -0400, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sun, 16 Oct 2011 18:07:38 +0100
> 
> > Assuming that the analysis is correct, and memcpy does receive correct 
> > arguments, it might be a bug in __memcpy_ultra3 (which would be very 
> > exciting :-). If you are using an UltraSparc III machine as well, and 
> > could try it on a different architecture, I would be a very interested 
> > in the result.
> 
> I reproduced your crash last week on a Niagara3 system, therefore I
> don't think it is dependent upon the memcpy implementation.
> 
> If you are still convinced it is some memcpy issue :-) I can only
> suggest that you check those buffer pointers passed to memcpy, if
> (given the size) they overlap at all, that would be a bug.  You can't
> use memcpy() for overlapping buffers, one must use memmove() instead.

Ok, I'm now convinced that memcpy() is not broken :-). However, it 
took a while to explain the behaviour I see. Here's what happens:

1. We flush the windows before performing the memcpy. This should 
flush all register windows to memory, except the current one in use 
(this is a crucial observation). So, for the current window we have 
valid values in registers, but junk in memory, pointed to by sp.

2. The source address happen to differ from the current sp only by 4 
bytes:

(gdb) info reg sp
sp             0xffffc970       0xffffc970
(gdb) print cont->machine_stack_src
$3 = (VALUE *) 0xffffc96c
(gdb) 

I guess that the expectation is that all register windows (including 
the current one!) are correctly represented in memory after flushw. 
But for the current register window this is not true, because flushw 
is not supposed to flush it (according to Sparc Architecture Manual, 
3.2.7).

3. We perform the memcpy(), copying the junk we believe to be valid
register values (sp to sp + 16 words) to cont->machine_stack. 
Restoring it later causes a crash.

That explains why 'ta 0x03' works - when it is executed, it actually 
does save, which increments register window, then flushw, making sure 
that the register window corresponding to cont_capture state is 
getting flushed as well, and then restores/returns. As a result, we 
end up with correct register content for the current window in memory 
before memcpy.

Finally, the "failing" memcpy is also easy to explain now: when we 
invoke the memcpy, we do it with the correct arguments, but we really 
do have incorrect memory contents in the source buffer, which end up 
in the destination. However, as soon as gdb breaks, it flushes *all* 
register windows of the interrupted process, including the current 
one, altering the memory contents of the source buffer, and making it 
appear like memcpy failed to synchronize the source and the 
destination.

Best regards, 
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
