From: Kjetil Oftedal <oftedal@gmail.com>
Date: Thu, 20 Oct 2011 21:02:14 +0000
Subject: Re: [PATCH 3/3] sparc32: Correct the return value of memcpy.
Message-Id: <Pine.LNX.4.64.1110202253490.25694@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111019.184425.145807140541223467.davem@davemloft.net>
In-Reply-To: <20111019.184425.145807140541223467.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 19 Oct 2011, David Miller wrote:

> 
> Properly return the original destination buffer pointer.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
>

Works great on my test systems. Thanks.

Tested-by: Kjetil Oftedal <oftedal@gmail.com> 
