From: David Miller <davem@davemloft.net>
Date: Sun, 05 Oct 2014 20:57:50 +0000
Subject: Re: [PATCH 08/13 linux-next] serial: sunsu: use container_of to resolve uart_sunsu_port from uart_po
Message-Id: <20141005.165750.1917530186306954555.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1412528475-1449-1-git-send-email-fabf@skynet.be>
	<1412528475-1449-9-git-send-email-fabf@skynet.be>
In-Reply-To: <1412528475-1449-9-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fabf@skynet.be
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>
Date: Sun,  5 Oct 2014 19:01:09 +0200

> Use container_of instead of casting first structure member.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Acked-by: David S. Miller <davem@davemloft.net>
