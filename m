From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 09 Nov 2005 20:03:51 +0000
Subject: Re: [PATCH] arch/sparc64: Use ARRAY_SIZE macro
Message-Id: <20051109.120351.18588682.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051108201824.GB7935@neon.tklauser.home>
In-Reply-To: <20051108201824.GB7935@neon.tklauser.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>
Date: Tue, 8 Nov 2005 21:18:24 +0100

> Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0]) and remove a
> duplicate of ARRAY_SIZE which is never used anyways.
> 
> Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

Applied, thanks.
