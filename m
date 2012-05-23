From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 23 May 2012 20:36:54 +0000
Subject: Re: [PATCH] sparc: Add full proper error handling to strncpy_from_user().
Message-Id: <20120523203654.GA23962@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120523.033550.676338248066700721.davem@davemloft.net>
In-Reply-To: <20120523.033550.676338248066700721.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, May 23, 2012 at 03:35:50AM -0400, David Miller wrote:
> 
> Linus removed the end-of-address-space hackery from
> fs/namei.c:do_getname() so we really have to validate these edge
> conditions and cannot cheat any more (as x86 used to as well).
> 
> Move to a common C implementation like x86 did.  And if both
> src and dst are sufficiently aligned we'll do word at a time
> copies and checks as well.

Great - I have removed this from my TODO list.

	Sam
