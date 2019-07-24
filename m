From: David Miller <davem@davemloft.net>
Date: Wed, 24 Jul 2019 20:13:24 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <20190724.131324.1545677795217357026.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190717215956.GA30369@altlinux.org>
	<20190718.141405.1070121094691581998.davem@davemloft.net>
	<CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
In-Reply-To: <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: ldv@altlinux.org, hch@lst.de, khalid.aziz@oracle.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 24 Jul 2019 22:32:17 +0300

> the first test where it was discovered was done on my test LDOM named
> ttip, hardware (hypervisor) is T5-2 server, running under Solaris 11.4
> OS.
> ttip LDOM is debian sparc64 unstable , so with almost all the latest
> software (gcc 8.3.0, binutils 2.32.51.20190707-1, debian GLIBC
> 2.28-10, etc..)
> 
> For another test, i also installed LDOM with oracle sparc linux
> https://oss.oracle.com/projects/linux-sparc/ , but I've to install a
> more fresh version of gcc on it first, since system installed gcc 4.4
> is too old for a git kernel (linux-2.6/Documentation/Changes lists gcc
> 4.6 as a minimal version), so I choose to install gcc-7.4.0 to /opt/
> (leaving system installed gcc 4.4 under /usr/bin). Compiled and
> installed git kernel version, i.e. last tag 5.3.0-rc1 and ran the
> test. Kernel still produced oops.

I suspect, therefore, that we have a miscompile.

Please put your unstripped vmlinux image somewhere so I can take a closer
look.

Thank you.
