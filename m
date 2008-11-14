From: David Miller <davem@davemloft.net>
Date: Fri, 14 Nov 2008 03:20:12 +0000
Subject: Re: [PATCH] sparc: combine unistd_{32,64}.h
Message-Id: <20081113.192012.63382991.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081114141050.3c2f5828.sfr@canb.auug.org.au>
In-Reply-To: <20081114141050.3c2f5828.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 14 Nov 2008 14:10:50 +1100

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

This is going to conflict with the accept4 patch
Andrew is going to push tomorrow.

So it's a better idea to do this after Linus sucks
that in.

Thanks!
