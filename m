From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Date: Sun, 01 Dec 2013 21:37:57 +0000
Subject: Re: SPARC: 3.13-rc1 and newer: kernel size issue with tftpboot.img
Message-Id: <529BAC35.4030605@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20131201190220.GC30823@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20131201190220.GC30823@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Aaro Koskinen wrote:

> Sun Ultra 5/10 (OpenBoot 3.25) seems to have 10 MB limitation for the
> tftpboot.img. With larger images "boot net" will fail with "Fast Data
> Access MMU Miss":

Latest patchdiag.xref [0] shows that the last OBP for U5/10 was:
OBP_3.31.0,POST_3.1.0,OBDIAG_P2.9 (106121-18) [1]

But I didn't see any bug fix related to that limit.


[0] https://getupdates.oracle.com/reports/patchdiag.xref
[1] https://updates.oracle.com/readme/106121-18
