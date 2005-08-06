From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 06 Aug 2005 13:40:23 +0000
Subject: Re: [PATCH] Remove errno declaration in drivers/sbus/char/envctrl.c
Message-Id: <20050806.064023.78715228.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050804134803.GA32109@localhost>
In-Reply-To: <20050804134803.GA32109@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Date: Sat, 06 Aug 2005 00:39:11 -0400

> Thanks for the feedback, what about the following then? It's compiled and
> booted and I've realized than bbc_envctrl.c suffers from the same
> thing, so here you go. Let me know if it makes sense...
> 
> Signed-off-by: Mathieu Chouquet-Stringer <mchouque@free.fr>

Looks good, patch applied, thanks a lot.
