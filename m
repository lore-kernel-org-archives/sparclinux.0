From: David Miller <davem@davemloft.net>
Date: Sun, 15 Jan 2012 19:49:32 +0000
Subject: Re: silo fails to build with recent ext2fs libraries
Message-Id: <20120115.114932.668066562346053443.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120115140938.GA7564@wooyd.org>
In-Reply-To: <20120115140938.GA7564@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 15 Jan 2012 14:09:39 +0000

> Another option would be to start linking against libc to work around
> this problem, but I don't know why it was not done in the first
> place, some size constraints perhaps?

Not only size, but you then have to audit every symbol libext2fs uses
in libc to make sure the code in libc doesn't directly or indirectly
do system calls or other things we can't support in the context of
SILO's execution environment.

That's why I suggest we just keep adding whatever routines libext2fs
wants into SILO.  That way we can audit what it wants, explicitly, and
know that our implementation won't have unwanted dependencies upon
executing in a real userland environment.
