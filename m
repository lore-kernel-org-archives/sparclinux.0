From: Ben Collins <bcollins@debian.org>
Date: Mon, 12 Jan 2004 21:01:41 +0000
Subject: Re: [2.6.1] still no working keyboard/mouse on ultra-enterprise 2
Message-Id: <20040112210140.GX31486@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040112140940.C4116@pc9391.uni-regensburg.de>
In-Reply-To: <20040112140940.C4116@pc9391.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 12, 2004 at 09:57:54AM -0800, David S. Miller wrote:
> On Mon, 12 Jan 2004 15:46:06 +0000
> Ciaran McCreesh <ciaranm@gentoo.org> wrote:
> 
> > Are you using the 2.4-style KEYMAPs? I don't know how Debian handles
> > this, but in Gentoo it's necessary to comment out the KEYMAP="sunkeymap"
> > line in /etc/rc.conf (or replace it with an x86-style setting if you
> > prefer).
> 
> I bet that's exactly what this person's problem is.
> 
> You cannot load Sun style keymaps any longer, it will result in garbage
> or nothing when you type keys.  You need to use x86 style keymaps on
> all platforms now in 2.6.1

Yeah, either uninstall console-tools entirely, or do

	dpkg-reconfigure console-data

And select an i386 keymap, or have it stick with the kernel keymap.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
