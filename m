From: Ben Collins <bcollins@debian.org>
Date: Thu, 11 Mar 2004 12:14:03 +0000
Subject: Re: Passing arguments to a kernel image within a tftpboot image
Message-Id: <20040311121403.GD29512@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040311071847.GE29906@triplehelix.org>
In-Reply-To: <20040311071847.GE29906@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Mar 10, 2004 at 11:18:47PM -0800, Joshua Kwan wrote:
> Hello,
> 
> Would it be possible to pass kernel arguments using some sort of small
> bootloader within a tftpboot image to, say, a Linux kernel that is
> within?
> 
> This is currently wanted for the new Debian installer which should
> preferably pass stuff like "DEBCONF_PRIORITY=medium devfs=mount" to the
> kernel in the tftpboot image.

You know that it would have been easier to just send me an email rather
than sending one to this whole list :)

Right now there isn't a way to do this other than compiling the kernel
with such a command line built-in. Let me consider this problem and I'll
see if I can come up with a solution.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
