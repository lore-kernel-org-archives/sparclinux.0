From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Tue, 22 Feb 2005 15:46:29 +0000
Subject: Re: Who restores %g6 for trap/irq handlers?
Message-Id: <BAY12-F36BF22214D872C1F342ECCFF620@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
In-Reply-To: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>It branches to "trap_setup" which is what sets
>up %g6 via the LOAD_CURRENT() macro we discussed
>earlier.

Thanks, I found the bug: PS flag was always equal to S, so %g6 was assumed 
OK. Now we reach the userland:

RAMDISK: Loading 64KiB [1 disk] into ram disk... done.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 376k freed
Hello World!

Nontrivial executables still die after a few system calls.

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.com/

