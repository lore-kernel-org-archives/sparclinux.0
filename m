From: David Miller <davem@davemloft.net>
Date: Fri, 21 Nov 2014 22:23:54 +0000
Subject: Re: [PATCH] vfs: renumber FMODE_NONOTIFY and add to uniqueness check
Message-Id: <20141121.172354.1624921151736272847.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1416562882-21190-1-git-send-email-drysdale@google.com>
In-Reply-To: <1416562882-21190-1-git-send-email-drysdale@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: drysdale@google.com
Cc: viro@zeniv.linux.org.uk, eparis@redhat.com, arnd@arndb.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Drysdale <drysdale@google.com>
Date: Fri, 21 Nov 2014 09:41:22 +0000

> Although FMODE_NONOTIFY is only used internally in the kernel it is in
> the same numbering space as the other O_* flags, as indicated by the
> comment at the top of include/uapi/asm-generic/fcntl.h (and its use
> in fs/notify/fanotify/fanotify_user.c).  However, its current value
> clashes with the value of O_PATH on sparc, so renumber it to avoid
> the clash.
> 
> All of this has happened before (12ed2e36c98aec6c4155, "fanotify:
> FMODE_NONOTIFY and __O_SYNC in sparc conflict"), and all of this
> will happen again -- so update the uniqueness check in fcntl_init()
> to include __FMODE_NONOTIFY.
> 
> Signed-off-by: David Drysdale <drysdale@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
