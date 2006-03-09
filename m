From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Mar 2006 21:27:07 +0000
Subject: Re: ESP busted
Message-Id: <20060309.132707.80696443.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060309.131637.114886710.davem@davemloft.net>
In-Reply-To: <20060309.131637.114886710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Thu, 09 Mar 2006 15:19:55 -0600

> Reading specs from /usr/lib/gcc-lib/sparc64-unknown-linux-gnu/3.3.5/specs
> Configured with:
> /var/tmp/portage/gcc-sparc64-3.3.5/work/gcc-sparc64-3.3.5/configure
> --prefix=/usr --disable-shared --disable-multilib
> --target=sparc64-unknown-linux-gnu --enable-languages=c --enable-threads=single
> --host=sparc-unknown-linux-gnu
> Thread model: single
> gcc version 3.3.5  (Gentoo Linux 3.3.5)

Ok, I tested and could not reproduce that inlining behavior with
gcc-3.4.x: gcc-3.4 (GCC) 3.4.6 20060122 (prerelease) (Debian 3.4.5-2)

But I definitely can reproduce it with gcc-3.3.x:
gcc-3.3 (GCC) 3.3.6 (Debian 1:3.3.6-10)

I'll see what I can do...
