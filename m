From: David Miller <davem@davemloft.net>
Date: Sun, 05 Aug 2007 03:19:45 +0000
Subject: Re: [PATCH] Fix Sparc32 Build
Message-Id: <20070804.201945.112621178.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0708041525230.24119@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0708041525230.24119@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 4 Aug 2007 15:28:26 +0100 (BST)

> Hi David,
> 
> asm-generic/fcntl.h is needed in asm-sparc/fcntl.h.
> 
> The #defines in asm-generic/fcntl.h are protected with #if's so will not 
> override thoes in asm-sparc/fcntl.h

I'll apply this, thanks Mark.

I thought the sparc32 and sparc64 fcntl.h files were more in
sync than they actually were, sorry :)
