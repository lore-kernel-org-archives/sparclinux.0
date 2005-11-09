From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 09 Nov 2005 20:03:15 +0000
Subject: Re: [PATCH] arch/sparc: Use ARRAY_SIZE macro
Message-Id: <20051109.120315.108937810.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051108201706.GA7935@neon.tklauser.home>
In-Reply-To: <20051108201706.GA7935@neon.tklauser.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>
Date: Tue, 8 Nov 2005 21:17:06 +0100

> Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0]) and remove a
> duplicate of ARRAY_SIZE which is never used anyways.
> 
> Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

Applied, thanks.
