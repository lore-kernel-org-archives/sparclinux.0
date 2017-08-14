From: David Miller <davem@davemloft.net>
Date: Mon, 14 Aug 2017 03:12:43 +0000
Subject: Re: [PATCH 03/11] serial: sunsab: constify uart_ops structures
Message-Id: <20170813.201243.113370942135429593.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
        <1502605310-4314-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1502605310-4314-4-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia.Lawall@lip6.fr
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 13 Aug 2017 08:21:42 +0200

> These uart_ops structures are only stored in the ops field of a
> uart_port structure and this fields is const, so the uart_ops
> structures can also be const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: David S. Miller <davem@davemloft.net>
