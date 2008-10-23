From: David Miller <davem@davemloft.net>
Date: Thu, 23 Oct 2008 21:08:19 +0000
Subject: Re: [PATCH] sparc64: remove byteshifting from out* helpers
Message-Id: <20081023.140819.11582203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1224701424.6823.2.camel@brick>
In-Reply-To: <1224701424.6823.2.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Wed, 22 Oct 2008 11:50:24 -0700

> __raw_write avoids the need to byteswap twice, as we are reading from a
> host-endian (big) area, just deref the pointers directly, taking care
> of alignment.
> 
> As before, outsw must still be called with a 2-byte aligned pointer.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

Applied, thanks Harvey.
