From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 18:46:45 +0000
Subject: Re: [PATCH 3/3 v2] sparc/uapi: Add definition of TIOC[SG]RS485
Message-Id: <20140909.114645.1318455090986185477.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410287879-2368-1-git-send-email-ricardo.ribalda@gmail.com>
In-Reply-To: <1410287879-2368-1-git-send-email-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ricardo.ribalda@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue,  9 Sep 2014 20:37:59 +0200

> Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 (serial/8250: Add
> support for RS485 IOCTLs), adds support for RS485 ioctls for 825_core on
> all the archs. Unfortunaltely the definition of TIOCSRS485 and
> TIOCGRS485 was missing on the ioctls.h file
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
