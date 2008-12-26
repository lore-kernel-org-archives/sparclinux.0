From: David Miller <davem@davemloft.net>
Date: Fri, 26 Dec 2008 23:39:22 +0000
Subject: Re: [PATCH] fix array overrun check in of_device_64.c
Message-Id: <20081226.153922.116095040.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49503AA7.0@earthlink.net>
In-Reply-To: <49503AA7.0@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Mon, 22 Dec 2008 20:11:03 -0500

> Do the array length check and fixup before copying the array.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Good catch!  Applied, thanks Robert.
