From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 09 Nov 2004 23:48:24 +0000
Subject: Re: PATCH to fix smbfs on sparc64
Message-Id: <20041109154824.46de89b4.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041030232157.GA5207@tintin>
In-Reply-To: <20041030232157.GA5207@tintin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 31 Oct 2004 01:28:51 +0200
Nicolas Boullis <nboullis@debian.org> wrote:

> As usual, I stupidly forgot to attach the promised patch. Here it is (if 
> I don't forget again).

I've applied the sparc64 part to my tree, thanks.

You should push the fs/smbfs/ioctl.c bit to the upstream
smbfs maintainer which appears to be listed as:

SMB FILESYSTEM
P:	Urban Widmark
M:	urban@teststation.com
W:	http://samba.org/
L:	samba@samba.org
S:	Maintained
