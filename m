From: Ben Collins <bcollins@debian.org>
Date: Sun, 05 Dec 2004 23:33:44 +0000
Subject: Re: [PATCH]: Fix for sparc64 SMP boot failures
Message-Id: <20041205233344.GD8814@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20041204201211.33b4b0f9.davem@davemloft.net>
In-Reply-To: <20041204201211.33b4b0f9.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 1) The kernel must be > 4MB in size.  You can check this via
>    looking at System.map for the kernel image and checking
>    if the final symbol "_end" is at an address >= 0x800000
> 
> 2) The object "p1275buf" must cross a PAGE_SIZE (8K) boundary.
> 
> If this is true, secondary cpus will not boot up and instead
> will hang in the kernel TLB miss handler.

Cool. This sounds like the bug that hit once during the bigkernel/silo
testing.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
