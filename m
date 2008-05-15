From: David Miller <davem@davemloft.net>
Date: Thu, 15 May 2008 21:07:54 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080515.140754.06902962.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18473.60551.911448.98269@alkaid.it.uu.se>
	<20080514.231111.107604885.davem@davemloft.net>
	<18476.33854.71781.133881@harpo.it.uu.se>
In-Reply-To: <18476.33854.71781.133881@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 15 May 2008 20:43:10 +0200

> Thanks Dave. As the dmesg diff below shows, this patch fixed
> my lost RAM issue. I actually have about 8KB more available
> now than I had with 2.6.25.

Don't spend it all in one place :-)

> Tested-by: Mikael Pettersson <mikpe@it.uu.se>

Thanks a lot for all of your help.
