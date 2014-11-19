From: David Miller <davem@davemloft.net>
Date: Wed, 19 Nov 2014 20:30:01 +0000
Subject: Re: sparc: Clashing values for O_PATH and FMODE_NONOTIFY?
Message-Id: <20141119.153001.1273476178846053821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAHse=S_EY3mJ_pdZf+A46joro_uNy=6tXGG1v7Va4NX_YxJu2w@mail.gmail.com>
In-Reply-To: <CAHse=S_EY3mJ_pdZf+A46joro_uNy=6tXGG1v7Va4NX_YxJu2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: drysdale@google.com
Cc: viro@zeniv.linux.org.uk, eparis@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, inux-fsdevel@vger.kernel.org

From: David Drysdale <drysdale@google.com>
Date: Tue, 18 Nov 2014 13:13:51 +0000

> Hi folks,
> 
> It looks like the value for O_PATH on sparc:
> 
>   arch/sparc/include/uapi/asm/fcntl.h:37:#define O_PATH 0x1000000
> 
> clashes with the arch-independent value for __FMODE_NONOTIFY:
> 
>   include/linux/fs.h:137:#define FMODE_NONOTIFY ((__force fmode_t)0x1000000)
>   include/linux/fs.h:2764:#define __FMODE_NONOTIFY ((__force int)
> FMODE_NONOTIFY)
> 
> and they are both in the same numbering space, as indicated by the
> comment at the top of include/uapi/asm-generic/fcntl.h and the use in
> fs/notify/fanotify/fanotify_user.c:715.
> 
> Presumably this could theoretically cause problems (no notifications for
> O_PATH files on SPARC?), so would it be a good idea to renumber
> FMODE_NONOTIFY?  (I *think* that value is entirely kernel-internal.)
> 
> Given that this has happened before (12ed2e36c98aec6c4155 "fanotify:
> FMODE_NONOTIFY and __O_SYNC in sparc conflict") it would probably
> also be a good idea to add __FMODE_NOTIFY to the uniqueness check in
> fs/fcntl.c:fcntl_init().
> 
> Thoughts?

I think you will need to change the internal value, to not clash with
the sparc exported one, for sure.
