From: Ben Collins <bcollins@debian.org>
Date: Sun, 22 Feb 2004 23:57:12 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222235712.GA2615@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ben Collins and I may have messed up net booting when we added SILO+kernel
> support for larger images, but it could also be this STACK phdr thing too.

My big kernel testing worked with net booting, but I didn't use
elftoaout, I booted the elf image directly.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
