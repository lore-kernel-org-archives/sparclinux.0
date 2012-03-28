From: James Morris <jmorris@namei.org>
Date: Wed, 28 Mar 2012 11:36:21 +0000
Subject: Re: [PATCH 1/9] KEYS: Use the compat keyctl() syscall wrapper on Sparc64 for Sparc32 compat
Message-Id: <alpine.LRH.2.02.1203282233480.30781@tundra.namei.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120328104607.10417.85745.stgit@warthog.procyon.org.uk> <10701.1332931934@redhat.com>
In-Reply-To: <10701.1332931934@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org, keyrings@linux-nfs.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, stable@vger.kernel.org

On Wed, 28 Mar 2012, David Howells wrote:

> 
> Can you push these to Linus in this merge window, please?

Only serious bugs at this point.

Patch #1 seems like the only candidate.  What impact does it have?

If DaveM has patches still to push for Sparc, it could go in those.


- James
-- 
James Morris
<jmorris@namei.org>
