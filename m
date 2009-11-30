From: Patrick Finnegan <pat@computer-refuge.org>
Date: Mon, 30 Nov 2009 21:02:14 +0000
Subject: Re: Boot problems on a V880
Message-Id: <200911301602.14992.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 27 November 2009, Patrick Finnegan wrote:
> I'll try pulling the RSC later tonight or tomorrow.  Booting with the
> args you specified provide this (and it hangs after the
> init_per_zone_wmark_min call):

It doesn't seem that the RSC is the problem, but I have two bad slots on 
the CPU backplane (as verified by booting this on my other V880).  That 
V880 is installed with "2.6.26-1-sparc64" from Debian/Lenny, which 
booted ok on this one when I cloned the disk (and pulled the CPU modules 
from the bottom two slots).  It looks like this 2.6.32-rc3 will boot, 
but I can't get the onboard (sungem) ethernet to work (on either 
2.6.26-1-sparc64 or 2.6.32-rc3).

Pat

-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
