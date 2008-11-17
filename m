From: David Miller <davem@davemloft.net>
Date: Mon, 17 Nov 2008 04:02:24 +0000
Subject: Re: [PATCH 1/8] sparc,sparc64: unify Kconfig files
Message-Id: <20081116.200224.134330245.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1226866704-6485-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226866704-6485-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 21:18:17 +0100

> Merge all of sparc64 Kconfig to sparc Kconfig.
> The merge was checked by:
> - visual inspection in menuconfig
> - result of allnoconfig, allmodconfig, allyesconfig was checked before and after
> - result of a number of randconfig was checked before and after
> 
> scripts/diffconfig was used to check if the config differed before and after
> 
> The validity of the test was checked by on purpose introducing
> a few bugs - and they were all caught by first run.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I applied this, but again I had to fix an intended change.

I preserved the 32-bit default of NR_CPUS to "32".  You had
changed it to "2" for some reason.
