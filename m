From: David Miller <davem@davemloft.net>
Date: Mon, 14 Dec 2009 03:25:51 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <20091213.192551.189710616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 14 Dec 2009 00:57:08 +0100 (CET)

> It is because arch/sparc/include/stat.h does not define STAT_HAVE_NSEC 
> for 64-bit sparc, even though there's nsec in struct stat64.
> That leads to fs/stat.c not copying the subsecond parts to userspace (in 
> function cp_new_stat).

cp_new_stat() handles "struct stat", not "struct stat64"

cp_new_stat64() does that, and it unconditionally fills in
the nsec parts.
