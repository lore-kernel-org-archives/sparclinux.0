From: Ben Collins <bcollins@debian.org>
Date: Tue, 20 Jan 2004 23:46:50 +0000
Subject: Re: TLB miss handler code
Message-Id: <20040120234649.GB32269@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> My question is, where has __builtin_trap() been implemented?? Also is
> __builtin_trap() where the missing PTE is picked up from the page table and put in the
> TLB because that's exactly what I'm looking for??

All the __builtin_* functions are defined in gcc. This one happens to
turn into "ta 5". Basically forces an oops in the kernel. So no, it does
not cause anything like what you are looking for.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
