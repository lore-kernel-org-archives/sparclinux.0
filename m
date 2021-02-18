From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 18 Feb 2021 15:28:35 +0000
Subject: RE: [PATCH] sparc: make copy_thread honor pid namespaces
Message-Id: <05247c8b0e31420a9e6e7a43831212ff@AcuMS.aculab.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210217080000.GA25861@altlinux.org>
In-Reply-To: <20210217080000.GA25861@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Dmitry V. Levin'" <ldv@altlinux.org>, "David S. Miller" <davem@davemloft.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>, Anatoly Pugachev <matorola@gmail.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Dmitry V. Levin
> Sent: 17 February 2021 08:00
> 
> On sparc, fork and clone syscalls have an unusual semantics of
> returning the pid of the parent process to the child process.

Isn't that just broken?
The application expects fork() to return 0 in the child.
libc would have to do horrid things to convert the result.

It could be comparing against the saved 'current pid' in
order to save a system call for the first ppid() call.
But that isn't ever going to work if it is possible to
create a child in a different pid namespace.

FWIW the test program ought to use syscall() to get the pid
and ppid - rather than relying on any optimisations in libc.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
