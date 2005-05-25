From: Ben Collins <bcollins@debian.org>
Date: Wed, 25 May 2005 18:50:18 +0000
Subject: Re: Sparc Linux kernel build newbie
Message-Id: <20050525185018.GA11107@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1117037595.3863.8.camel@mayday.localdomain>
In-Reply-To: <1117037595.3863.8.camel@mayday.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, May 25, 2005 at 05:13:15PM +0100, Adrian McMenamin wrote:
> Sorry to be stupid ...but while I can build the (2.4) kernel on my box I
> cannot build the modules (the standard ia32 syntax doesn't seem to work)
> and nor can I do a make install.
> 
> What are the commands for these on Sparc?

"make modules" and "make modules_install" work on sparc.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
