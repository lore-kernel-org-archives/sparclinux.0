From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 06:22:29 +0000
Subject: Re: [PATCH] sparc32: Put back SPARC_BRANCH.
Message-Id: <20120512062229.GA1879@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120512.000320.515901108290483706.davem@davemloft.net>
In-Reply-To: <20120512.000320.515901108290483706.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 12, 2012 at 12:03:20AM -0400, David Miller wrote:
> 
> It's needed for the floppy interrupt trap table patching.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> Tsk tsk, Sam both you and I are naughty for not testing with
> BLK_DEV_FD enabled :-)
Ups - thanks. Dunno how I missed that when I grepped for it.
Will enable BLK_DEV_FD for future builds.

	Sam
