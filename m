From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 02 Jun 2017 10:04:55 +0000
Subject: Re: [PATCH v2 1/1] tty: add TIOCGPTPEER ioctl
Message-Id: <CAK8P3a2Q5CwofO96fXyjTVqmm23UKZjd+mOopnvKr_TusLxXpQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170602084858.4299-1-asarai@suse.de> <20170602084858.4299-2-asarai@suse.de>
In-Reply-To: <20170602084858.4299-2-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aleksa Sarai <asarai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>

On Fri, Jun 2, 2017 at 10:48 AM, Aleksa Sarai <asarai@suse.de> wrote:
> When opening the slave end of a PTY, it is not possible for userspace to
> safely ensure that /dev/pts/$num is actually a slave (in cases where the
> mount namespace in which devpts was mounted is controlled by an
> untrusted process). In addition, there are several unresolvable
> race conditions if userspace were to attempt to detect attacks through
> stat(2) and other similar methods [in addition it is not clear how
> userspace could detect attacks involving FUSE].
>
> Resolve this by providing an interface for userpace to safely open the
> "peer" end of a PTY file descriptor by using the dentry cached by
> devpts. Since it is not possible to have an open master PTY without
> having its slave exposed in /dev/pts this interface is safe. This
> interface currently does not provide a way to get the master pty (since
> it is not clear whether such an interface is safe or even useful).

This should be added to the compat ioctls as well. There are two ways
of doing this:

a) like the other ioctls handled by pty_unix98_ioctl(), add it to the
list in fs/compat_ioctl.c, and check that the list is still up-to-date with
the current driver (someone else may have missed one)

b) remove all compat handling for ioctls that are specific to
pty_unix98_ioctl() and pty_bsd_ioctl() from fs/compat_ioctl.c
and add compat_ioctl callback pointers to master_pty_ops_bsd
and ptm_unix98_ops, pointing to the respective ioctl handlers.

I would recommend b) as it avoids the problem in the future,
but it is a little more upfront work, and should be done as a
separate preparation patch.
All the ioctls here are compatible between 32-bit and 64-bit
user space, so no special translation is needed.

      Arnd
