From: Ben Collins <bcollins@debian.org>
Date: Tue, 27 Jul 2004 13:39:47 +0000
Subject: Re: slab corruption and stuck CPU under 2.6.8rc2
Message-Id: <20040727133947.GA12350@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Jul 27 09:18:44 scratchmonkey kernel: read_lock(00000000006fde40) CPU#0 stuck at 0045ae18, writer PC(00451808):CPU(2)
> Jul 27 09:18:44 scratchmonkey kernel: read_lock(00000000006fde40) CPU#0 stuck at 0045ae18, writer PC(00451808):CPU(2)

Try looking up the 0x006fde40, 0x0045ae18 and 0x00451808 addresses in the
System.map for your kernel. See if we can find out where this is
occuring.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
