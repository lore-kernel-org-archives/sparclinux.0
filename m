From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Thu, 14 Nov 2013 00:12:28 +0000
Subject: Re: [PATCH v3 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <5284156C.3030301@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20131113.021734.528140279553085799.davem@davemloft.net>
In-Reply-To: <20131113.021734.528140279553085799.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/12/2013 11:17 PM, David Miller wrote:
> This incorporates the fixes from Bob and myself for 8MB huge page
> handling.
>
> It is what I intend to send to Linus for the current merge window.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
Tested on T4-1,T4-1 ldom, T4-2, T5-8,athena (sparc-X)
Tested-by: Gurudas Pai <gurudas.pai@oracle.com>
