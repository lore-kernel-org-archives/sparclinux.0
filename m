From: Meelis Roos <mroos@linux.ee>
Date: Mon, 16 Jun 2014 09:21:08 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1406161117270.23638@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Back to an old dragon that seems to have more heads than thought. 
Background is that I got RED state exceptions from recursive faults on 
sparc64 during reboot via PROM, from running PROM code where PROM has 
all the cobtrol over the machine. In Sun Ultra 5 and Sun Blade 100 it 
resulted in RED state exception that looped and hung the machine. This 
is still a problem in current kernels.

Now while debugging a different issue on Sun Fire V100, I noticed a 
different crash dump on reboot, showing also recursive fault from PROM 
space. The messages are different (because of newer PROM generation?) 
but the problem seems same, except no hang happens - that's why I had 
not noticed it before.

Since V100 has LOM (remote lights-out management), I could test it more 
easily and decided to bisect it.

> > but it came out clearly finally
> > (each bad commit was clearly bad, each good commit was tested for 3
> > reboots without a problem). Bisect resulted in his commit being at
> > fault:
> > 
> > 8cb06c983822103da1cfe57b9901e60a00e61f67 is the first bad commit
> > commit 8cb06c983822103da1cfe57b9901e60a00e61f67
> > Author: Peter Hurley<peter@hurleysoftware.com>
> > Date:   Sat Jun 15 10:21:18 2013 -0400
> > 
> >      n_tty: Remove alias ptrs in __receive_buf()
> > 
> >      The char and flag buffer local alias pointers, p and f, are
> >      unnecessary; remove them.
> > 
> >      Signed-off-by: Peter Hurley<peter@hurleysoftware.com>
> >      Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> > 
> > :040000 040000 ddc901fe810f43bc06a64397735b469b11e403e8
> > 96d92e4e242c4b2ff11b25c005bccd093865b350 M  drivers

And it was the same commit [8cb06c983822103da1cfe57b9901e60a00e61f67] 
there. So something seems to trigger with this commit.

ttyS0 is sunsu conole on V100. Ultra 5 had sunsab. So the serial driver 
seems to be at least different.

David, can you suggest a way to dump the whole state of sparc64 MMU to 
see if we leave some state different than before on reboot PROM call?

-- 
Meelis Roos (mroos@linux.ee)
