From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Aug 2007 11:37:54 +0000
Subject: Re: Ultra 1 hang on boot
Message-Id: <Pine.SOC.4.64.0708121431110.24332@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0706061524480.12237@math>
In-Reply-To: <Pine.SOC.4.64.0706061524480.12237@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Remapping the kernel... done.
> > 
> > Any other config option to try for debugging?
> > The only section warnings are promcon section warnings - may these 
> > result in this hang or do they kick in later?
> 
> I have a fix for those but they ought to be harmless.
> 
> Since it takes years for me to get my ultra1 up and build
> a kernel, can you figure out the most recent kernel that
> worked properly?

I have taken on this problem after some vacation. Meanwhile I have 
learned that Debian 2.6.22-1-sparc64 boots so it's probably a 
configureation problem.

I succeeded in compiling 2.6.23-rc2 and yesterdays post-rc2 git snapshot 
with Debian .config and it booted fine. Changing only some configuration 
options breaks the boot. I am currently confused about what options 
break it, the results do not seem to be consistent but I will retest. 
The inconsistency between config options and bootability is similar to 
my problem with Ultra 5 where different slight changes have broken the 
boot, but I will first do some more tests to see whether it's really so 
arcane. Toolchain is Debian unstable: binutils 2.17.50.20070804 
(2.17cvs20070804-1), gcc version 4.1.3 20070718 (prerelease) (Debian 
4.1.2-14).

The good news is that 2.6.23-rc2 seems to boot and work fine on 
SBus-only (no UPA) Ultra 1 so far. Only one cosmetic bug in ESP driver 
that I will report in another mail.

-- 
Meelis Roos (mroos@linux.ee)
