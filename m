From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 26 Oct 2004 06:46:30 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041025234630.0c81196e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 26 Oct 2004 02:11:28 -0400
mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:

> Hey -- I can reduce the size, sure but that is besides the point. I want
> to know the details of the size limitations of the kernel image for
> sparc64. You told me last that there was no size limitations, that this
> was fixed in the latest version of silo.

It should be ~8MB these days.

I bet if you just use arch/sparc64/defconfig as your kernel
config the resulting image will work if you have working
compiler tools.

I use just about every 2.6.x release on my Ultra60, SunBlade100
and my SunBlade1000.
