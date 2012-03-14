From: David Miller <davem@davemloft.net>
Date: Wed, 14 Mar 2012 00:37:41 +0000
Subject: Re: New build failures in sparc.
Message-Id: <20120313.173741.18086192847996966.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAP=VYLpfM0AFWQp7Q=xYHnCd_6vEXKKL1EL5daGcO9gsJZH=7Q@mail.gmail.com>
	<20120313.154848.265971549311147422.davem@davemloft.net>
	<20120314102830.aa7b1139bff158d30ac57505@canb.auug.org.au>
In-Reply-To: <20120314102830.aa7b1139bff158d30ac57505@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-next@vger.kernel.org, tony@bakeyournoodle.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Mar 2012 10:28:30 +1100

> Yeah, we updated our sparc64 toolchain yesterday ... Tony says he
> will try applying the patch(es) from the bugzilla.

Meanwhile I'll add a workaround to the sparc makefiles, and
push that to Linus.  This way it will work no matter what
combination of tools someone has.
