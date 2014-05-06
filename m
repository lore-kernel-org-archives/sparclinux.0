From: Meelis Roos <mroos@ut.ee>
Date: Tue, 06 May 2014 15:13:58 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <alpine.SOC.1.00.1405061624210.3891@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> This is the final series I am submitting to Linus and intend to
> submit to -stable, thanks for all of the feedback and reviews.  I
> was a bit delayed because I kept triggering crashes caused by a
> bug recently introduced in SLAB in 3.15-rc1 which just got fixed
> fully tonight.

OK, I compiled todays git (includes 2 slab patches) and your 11 patches, 
on U2, X1, V100 and V480. Threw some more work on them:

while true; do git clone /home/mroos/linux/; rm -rf linux; done

V480 seems to churn along with no problem so far (maybe 8G RAM is enough 
to lessen the load on mm).

Netra X1 got
*** Error in `git': munmap_chunk(): invalid pointer: 0x00724a78 ***
and dmesg has
[ 7495.796759] git[2230]: segfault at 1c30d42c ip 00000000000890a8 (rpc 000000000008928c) sp 00000000ffafaea8 error 30001 i]
(line end may be truncated by minicom). Next git hangs the machine.

Ultra 2 hangs with nothing on console during first git clone checkout.
I also got similar end result for U2 from the previous 10-patch series 
after first surviving some apt-get updates and then running aptitude.

V100 had trouble compiling the new kernel with my 3.14 (frequent hangs 
and reboots like before), compiling under Debian 3.13 seems to be more 
stable so something in my V100 conf is probably the factor.
Now that it finished compiling, I test it and it hangs on first git 
clone while checking out files.

How should I continue debugging it - find the conf differences with 
Debian kernel?

Or do you want my .config for U2, X1, V100?


-- 
Meelis Roos (mroos@linux.ee)
