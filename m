From: Ben Collins <bcollins@debian.org>
Date: Mon, 31 May 2004 13:35:17 +0000
Subject: Re: new debian-installer images for sparc
Message-Id: <20040531133517.GB11453@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531034458.GF2384@triplehelix.org>
In-Reply-To: <20040531034458.GF2384@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 30, 2004 at 08:44:58PM -0700, Joshua Kwan wrote:
> Folks,
> 
> Here is a mini-ISO image I cooked up with SILO rolled back to 1.3.2. Tom
> Callaway suggested that I try this because a lot of new stuff related to
> initrds changed in 1.4.x.
> 
> http://june.voxel.net/~joshk/mini.iso

The only way it's going to work is if the kernels are less than 3.4Megs
uncompressed. This is probably fine for cd boots though.

GOod thing is, I have time today for some sparc stuff. Well, that is, if
I don't get my Harley Fatboy today. Even if I do, I will work in some
debug time for this initrd problem :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
