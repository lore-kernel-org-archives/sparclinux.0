From: Ben Collins <bcollins@debian.org>
Date: Fri, 14 May 2004 19:43:16 +0000
Subject: Re: initrd testing
Message-Id: <20040514194316.GP1098@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> loaded kernel version 2.4.26
> Loading initial ramdisk ( 1477684 bytes at 0x01x phys, 0x60800000 virt)

Crap, silo's printf doesn't support lx or llx. I need to fix that,
because I really need that info.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
