From: David Miller <davem@davemloft.net>
Date: Fri, 11 May 2007 19:45:29 +0000
Subject: Re: [PATCH] add missing syscalls
Message-Id: <20070511.124529.71090896.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46444B8C.4000000@earthlink.net>
In-Reply-To: <46444B8C.4000000@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 11 May 2007 06:55:08 -0400

> Add some missing syscalls.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

This is not correct, the syscall checker is warning unnecessarily,
I've looked into this one before.

Sparc supported the full 32-bit variants of these syscalls from
the beginning so we don't have to have the old 16-bit versions
in the system call table at all.
