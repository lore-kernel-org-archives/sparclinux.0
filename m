From: David Miller <davem@davemloft.net>
Date: Mon, 13 Aug 2007 01:18:28 +0000
Subject: Re: Ultra 1 hang on boot
Message-Id: <20070812.181828.56053517.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0706061524480.12237@math>
In-Reply-To: <Pine.SOC.4.64.0706061524480.12237@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Aug 2007 14:37:54 +0300 (EEST)

> I succeeded in compiling 2.6.23-rc2 and yesterdays post-rc2 git snapshot 
> with Debian .config and it booted fine. Changing only some configuration 
> options breaks the boot. I am currently confused about what options 
> break it, the results do not seem to be consistent but I will retest. 
> The inconsistency between config options and bootability is similar to 
> my problem with Ultra 5 where different slight changes have broken the 
> boot, but I will first do some more tests to see whether it's really so 
> arcane. Toolchain is Debian unstable: binutils 2.17.50.20070804 
> (2.17cvs20070804-1), gcc version 4.1.3 20070718 (prerelease) (Debian 
> 4.1.2-14).

These are good clues.  These are the most ugly bugs to pin down
because usually it is some subtlety of the layout of the .data or
.bss section that is creating the bug condition.

If you can get a simple config change that goes from "works" to
"broken", the post the "works" and "broken" kernel images (prestripped)
and System.map files, I can do some scanning of them to look for
clues.

Thanks.
