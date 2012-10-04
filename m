From: David Miller <davem@davemloft.net>
Date: Thu, 04 Oct 2012 20:48:30 +0000
Subject: Re: [GIT PULL] Disintegrate UAPI for sparc
Message-Id: <20121004.164830.95335113175840606.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <17438.1349380312@warthog.procyon.org.uk>
In-Reply-To: <17438.1349380312@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dhowells@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 04 Oct 2012 20:51:52 +0100

> Can you merge the following branch into the sparc tree please.
> 
> This is to complete part of the UAPI disintegration for which the preparatory
> patches were pulled recently.
> 
> Note that there are some fixup patches which are at the base of the branch
> aimed at you, plus all arches get the asm-generic branch merged in too.

When I pull the sparc branch, I get c6x and arm64 commits too.

37d11ab8b478ccb7aa2270666603ca2e5ac4c11d
1c1e436269fe840cdbecfaf397b21778dd276f26

I don't want that going in via the sparc tree, it really
doesn't belong there.
