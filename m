From: Ben Collins <bcollins@debian.org>
Date: Thu, 29 Jan 2004 20:37:40 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040129203740.GO532@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > SILO version 1.4.2
> > boot: linux2.6.2-rc2
> > Allocated 8 megs of memory at 0x40000000 for kernel
> > Uncompressing image ...
> > Loaded kernel version 2.6.2 ...
> > Remapping the kernel ... done

Wait, I know what the issue is here. Dave pulled a change from me that
set the HdrS ver to 0x300, which is what SILO keys off of to see if the
kernel supports being loaded to high memory. Problem is, it doesn't
actually.

So avoid -rc2 with current SILO. Wait for -rc3 (or 2.6.2 final), or use
-rc1.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
