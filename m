From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Apr 2008 23:32:32 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <alpine.LFD.1.10.0804211630220.2779@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net> <alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org> <20080421231815.GS27459@ZenIV.linux.org.uk>
In-Reply-To: <20080421231815.GS27459@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On Tue, 22 Apr 2008, Al Viro wrote:
> 
> FWIW, two things I _really_ want dead and gone are
> 	* timod (or full rewrite of that animal; current one is badly racy
> and plays fast and loose with way too many place in VFS guts)
> 	* altroot (use chroot, damnit, and bind whatever you need in there)

I heartily concur about the "altroot" thing. It should die. Removing that 
part from the Solaris/SunOS emulation is probably worthwhile, and then 
eventually when/if we end up having a working unionfs, that (along with 
solaros/sunos-emulation specific mounts) should be able to replace the 
need for altroot.

		Linus
