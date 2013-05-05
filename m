From: David Miller <davem@davemloft.net>
Date: Sun, 05 May 2013 01:32:14 +0000
Subject: Re: [RFC PATCH] sparc/kernel/vio.c: add put_device() after device_find_child()
Message-Id: <20130504.213214.284834179118895616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1366036972-9240-1-git-send-email-federico.vaga@gmail.com>
In-Reply-To: <1366036972-9240-1-git-send-email-federico.vaga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: federico.vaga@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Federico Vaga <federico.vaga@gmail.com>
Date: Mon, 15 Apr 2013 16:42:52 +0200

> The vio_remove() function uses device_find_child() but it does not drop
> the reference of the retrieved child.
> 
> Signed-off-by: Federico Vaga <federico.vaga@gmail.com>

Applied.
