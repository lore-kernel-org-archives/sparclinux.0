From: Ben Collins <bcollins@debian.org>
Date: Sat, 05 Jun 2004 13:06:17 +0000
Subject: Re: Take 3: sparc64 CDs work?
Message-Id: <20040605130616.GA7008@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040605001932.GA22926@darjeeling.triplehelix.org>
In-Reply-To: <20040605001932.GA22926@darjeeling.triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jun 04, 2004 at 05:19:32PM -0700, Joshua Kwan wrote:
> Folks,
> 
> Thanks to some surprising sleuth work by Boris Gontar we might have a
> workaround for the dastardly initrd bug affecting certain sparc64
> machines.
> 
> So, without further ado:
> 
> * http://june.voxel.net/~joshk/d-i/images/2004-06-04/cdrom-mini.iso (4.7M)
> * http://gluck.debian.org/cdimage/testing/daily/sparc/current/ (whole
>   shebang, if you're really confident)
> 
> I'm hoping one of these works. If neither do, make sure silo.conf
> includes 'rootfstype=ext2'. I could have screwed up.

I downloaded the cdrom-mini.iso and the silo.conf looks right. I'll test
it on all my machines today.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
