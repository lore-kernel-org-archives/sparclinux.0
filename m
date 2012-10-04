From: David Howells <dhowells@redhat.com>
Date: Thu, 04 Oct 2012 21:59:21 +0000
Subject: Re: [GIT PULL] Disintegrate UAPI for sparc
Message-Id: <19190.1349387961@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.164830.95335113175840606.davem@davemloft.net> <17438.1349380312@warthog.procyon.org.uk>
In-Reply-To: <20121004.164830.95335113175840606.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> When I pull the sparc branch, I get c6x and arm64 commits too.
> 
> 37d11ab8b478ccb7aa2270666603ca2e5ac4c11d
> 1c1e436269fe840cdbecfaf397b21778dd276f26
> 
> I don't want that going in via the sparc tree, it really
> doesn't belong there.

They're at the base of every branch so that I can test those arches on every
branch.  I suppose I could exclude them from unrelated arch branches, or
perhaps better still if I can get Linus to pull them.

David
