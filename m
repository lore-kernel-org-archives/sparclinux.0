From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 21 Apr 2008 23:25:34 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080421232534.GT27459@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net> <alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org> <20080421231815.GS27459@ZenIV.linux.org.uk>
In-Reply-To: <20080421231815.GS27459@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 22, 2008 at 12:18:15AM +0100, Al Viro wrote:

> FWIW, two things I _really_ want dead and gone are
> 	* timod (or full rewrite of that animal; current one is badly racy
> and plays fast and loose with way too many place in VFS guts)
> 	* altroot (use chroot, damnit, and bind whatever you need in there)

BTW, the part about altroot goes for other architectures too; it's badly
broken and it's one hell of an obstacle to fs/namei.c work of any kind.

As absolute minimum we _must_ lose the "if we hadn't found what we wanted
in that subtree, repeat lookup starting at real root"; that's causing
nightmares in pathname resolution and there's no excuse whatsoever for
that since we have bindings.
