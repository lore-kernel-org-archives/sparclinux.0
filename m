From: David Miller <davem@davemloft.net>
Date: Wed, 17 Oct 2012 17:01:34 +0000
Subject: Re: [PATCH 10/10] UAPI: Make arch/sparc/include/uapi/asm/sigcontext.h non-empty
Message-Id: <20121017.130134.248138480938803323.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121017140151.28541.32197.stgit@warthog.procyon.org.uk>
In-Reply-To: <20121017140151.28541.32197.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Wed, 17 Oct 2012 15:01:51 +0100

> arch/sparc/include/uapi/asm/sigcontext.h was emitted by the UAPI disintegration
> script as an empty file because the parent file had no UAPI stuff in it,
> despite being marked with "header-y".
> 
> Unfortunately, the patch program deletes resultant empty files when applying a
> kernel patch.
> 
> So just stick a comment in there as a placeholder.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
