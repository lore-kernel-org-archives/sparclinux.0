From: Ben Collins <bcollins@debian.org>
Date: Fri, 30 Jan 2004 17:48:39 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040130174839.GH1788@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2004 at 07:46:07PM +0200, Meelis Roos wrote:
> > So 1.4.1 worked, and 1.4.3 didn't? Is the 1.4.3 compiled by you, or also
> > the debian package?
> 
> Debian package.
> 
> I'm 95% sure that I actually tested the 1.4.1 booting - I turned the
> computer on today and it booted and worked. I did dist-upgrade a day or
> two ago and I seem to remember it telling me about installing new SILO,
> and I remember seeing 1.4.1 being in upgrade list. So if it installed
> correctly, it should have been 1.4.1 package.

Actually I uploaded 1.4.0, 1.4.1, 1.4.2 and 1.4.3 all yesterday. So
there's no way possible you had 1.4.1...maybe it was 1.3.1 :)

Ok, next time you can, when you get the problem, type ".registers" at
the ok prompt, and send me the output please? Also do:

ok> cd /memory
ok> .properties
(send this output)

ok> cd /virtual-memory
ok> .properties
(send this aswell)

And also send me the output of "dump-itlb".


Thanks!

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
