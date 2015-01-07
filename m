From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 07 Jan 2015 00:29:15 +0000
Subject: Re: [PATCHv2 1/1] vfs: renumber FMODE_NONOTIFY and add to uniqueness check
Message-Id: <20150106162915.7edb5620999641ebdc7a74e6@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1416828199-3414-1-git-send-email-drysdale@google.com>
	<1416828199-3414-2-git-send-email-drysdale@google.com>
In-Reply-To: <1416828199-3414-2-git-send-email-drysdale@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Drysdale <drysdale@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Eric Paris <eparis@redhat.com>, David Miller <davem@davemloft.net>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, 24 Nov 2014 11:23:19 +0000 David Drysdale <drysdale@google.com> wrote:

> Fix clashing values for O_PATH and FMODE_NONOTIFY on sparc.
> The clashing O_PATH value was added in 5229645bdc35f1cc43eb ("vfs: add
> nonconflicting values for O_PATH") but this can't be changed as it
> is user-visible.
> 
> FMODE_NONOTIFY is only used internally in the kernel, but it is in
> the same numbering space as the other O_* flags, as indicated by the
> comment at the top of include/uapi/asm-generic/fcntl.h (and its use
> in fs/notify/fanotify/fanotify_user.c).  So renumber it to avoid
> the clash.
> 
> All of this has happened before (12ed2e36c98aec6c4155, "fanotify:
> FMODE_NONOTIFY and __O_SYNC in sparc conflict"), and all of this
> will happen again -- so update the uniqueness check in fcntl_init()
> to include __FMODE_NONOTIFY.

What are the user-visible runtime effects of the bug?

Please always include this info when fixing bugs, so people can work
out which kernel version(s) need the fix.

