From: David Miller <davem@davemloft.net>
Date: Mon, 01 Jun 2015 05:45:50 +0000
Subject: Re: [PATCH] sparc: kernel: GRPCI2: Remove a useless memset
Message-Id: <20150531.224550.513857798121431185.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1430481939-10268-1-git-send-email-christophe.jaillet@wanadoo.fr>
In-Reply-To: <1430481939-10268-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: christophe.jaillet@wanadoo.fr
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Fri,  1 May 2015 14:05:39 +0200

> grpci2priv is allocated using kzalloc, so there is no need to memset it.
> 
> Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

Applied.
