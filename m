From: Ben Collins <bcollins@debian.org>
Date: Fri, 30 Apr 2004 11:32:04 +0000
Subject: Re: Illegal instruction with silo 1.4.4 and ultra 1
Message-Id: <20040430113204.GP3647@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 29, 2004 at 09:32:26PM -0600, Jason Wever wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thu, 29 Apr 2004, Ben Collins wrote:
> 
> > When you say an Ultra 1, do you mean an UltraSPARC 1, or an
> > UltraSPARC-I?
> 
> It's an Ultra 1 Workstation (143 MHz).
>  
> > Also, shoot me the output of ".registers" after the illegal instruction.
> 
> ok .registers
>         Normal          Alternate       MMU               Vector
> 0:                 0                0                0                0
> 1:          40004000         fffdf6c0       4400001600              7f1
> 2:          40004000         f0000000               14         f0000000
> 3:            400000                0         fffe0000      10000000000
> 4:            3a5400                0 ffffffffffffffff             4000
> 5:  e00000003f002077                f         fffde000               f8
> 6:                 0       4400001601 800000003ff660b6                e
> 7:               1f8               10                2         f0055cec
> %PC  40004498 %nPC 4000449c 
> %TBA f0000000 %CCR 44 XCC:nZvc   ICC:nZvc

Doesn't look like a silo problem off-hand. This PC is in the start of
the kernel. What compiler are you compiling your kernels with?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
