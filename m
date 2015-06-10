From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jun 2015 18:07:38 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150610.110738.1101193887993858245.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Y Knight <jyknight@google.com>
Date: Wed, 10 Jun 2015 10:40:58 -0400

> But separately from the reliability issue, it seems rather
> unfortunate that the 'default' sparcv9 and sparc64 routines aren't
> actually coded to the base sparcv9 standard instruction set. It
> seems like probably the base routines should limit themselves to
> normal LDX/STX or LDDF/STDF instructions, and leave things like
> LDBLOCKF (which the docs mark CPU-specific, and deprecated, and
> potentially to be removed from future chips), for when a specific
> processor is targeted.

All sparc64 cpus support block loads and stores.

There are documents, and then there is reality.

Those instructions cannot be removed without breaking tons of code
out there and the people making changes to the sparc64 cpus are
painfully aware of this.
