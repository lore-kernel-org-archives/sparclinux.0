From: David Miller <davem@davemloft.net>
Date: Sat, 19 Jul 2008 07:44:46 +0000
Subject: Re: [PATCH] Remove Sparc's asm-offsets for sclow.S
Message-Id: <20080719.004446.137366121.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080710195356.11539.57171.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080710195356.11539.57171.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 10 Jul 2008 20:53:56 +0100

> Remove Sparc's asm-offsets for sclow.S as the (E)UID/(E)GID size and offset
> definitions will cease to be correct if COW credentials are merged.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thanks David.
