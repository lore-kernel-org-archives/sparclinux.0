From: Ben Collins <bcollins@debian.org>
Date: Mon, 14 Feb 2005 11:32:20 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <20050214113218.GB6838@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl>
In-Reply-To: <200502140251.00645.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> atyfb: atyfb_set_par
> atyfb:  Set Visible Mode to 640x480-8
> atyfb:  Virtual resolution 640x3225, pixclock_in_ps 39751 (calculated 39751)
> atyfb:  Dot clock:           25 MHz
> atyfb:  Horizontal sync:     31 kHz
> atyfb:  Vertical refresh:    59 Hz

There's the problem right there. This is all wrong for sparc. Should be
something like 1024x768, and atleast 70Hz refresh.

Did someone rip out the sparc stuff from atyfb?


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
