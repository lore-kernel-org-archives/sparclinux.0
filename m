From: Ben Collins <bcollins@debian.org>
Date: Fri, 30 Jan 2004 19:21:26 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040130192126.GB695@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2004 at 09:17:37PM +0200, Meelis Roos wrote:
> > Ok, your system isn't able to allocate the needed memory (must be an OBP
> > 2.x thing). One thing you might try is upgrading your OBP, but in the
> > mean time, give the attached second.b a try (put it in /boot/ and run
> > "silo -f").
> 
> OK, found out that the old RARP server can not come back any time soon
> and installed another netboot server.
> 
> Still Data Access Exception. This time PC(6760 and nPC(6764 but
> other regs are the same as before.

Damn, I just realised you are doing this on sparc32.

Anyway, I can't see what would be causing this problem. I didn't really
touch anything with sparc32.

Can you get the silo source and do some compiles for me? Would be easier
than me sending you loaders and waiting. I need you to check the address
image_base and ret_offset in the function bootmain() in the file
second/main.c. Just add some printf's.

Also, you can try commenting out the call to memory_release() at the
bottom of that same file/function.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
