From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 31 Oct 2019 01:53:06 +0000
Subject: Re: [PATCH 1/3] arch: ipcbuf.h: make uapi asm/ipcbuf.h self-contained
Message-Id: <20191030185306.a75acc68ed2b911970ccd4b8@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20191030063855.9989-1-yamada.masahiro@socionext.com>
        <CAK7LNASrZpJ0J7N_YvSza2QQ_cQQ+Z04Cf5-Or4ivKMb9UVuMQ@mail.gmail.com>
In-Reply-To: <CAK7LNASrZpJ0J7N_YvSza2QQ_cQQ+Z04Cf5-Or4ivKMb9UVuMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Thu, 31 Oct 2019 10:33:00 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Andrew,
> 
> I think this patch has already been picked up to your tree,
> but I noticed a typo in the commit message just now.
> Please see below.
> 
> ...
>
> > Include <asm/posix_types.h> to make it self-contained, and add it to
> 
> Include <linux/posix_type.h> to make ...
> 
> Could you please fix it up locally?

No probs, done.
