From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 02:25:26 +0000
Subject: Re: [PATCH] sparc: unify ipcbuf.h
Message-Id: <20090102.182526.240281821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081228200418.GA22991@uranus.ravnborg.org>
In-Reply-To: <20081228200418.GA22991@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Dec 2008 21:04:18 +0100

> Looking closer the two structures only differed on the
> size of __kernel_umode_t.
> Add a sparc32 specific padding to cover this difference.
> 
> The other types had same size on sparc32 and sparc64.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I'm not sure this will work.

You've changed the size of the structure on 32-bit.

The last two "unused" members of ipc64_perm are "unsigned long long",
not just plain "unsigned long" in the 32-bit variant.

But you've used plain "unsigned long" in the unified copy.
