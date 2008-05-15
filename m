From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 15 May 2008 20:30:39 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <18476.40303.232402.312481@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <20080512.153628.193699676.davem@davemloft.net>
	<20080512.153948.193688062.davem@davemloft.net>
	<18473.60551.911448.98269@alkaid.it.uu.se>
	<20080514.231111.107604885.davem@davemloft.net>
	<18476.33854.71781.133881@harpo.it.uu.se>
In-Reply-To: <18476.33854.71781.133881@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson writes:
 > Thanks Dave. As the dmesg diff below shows, this patch fixed
 > my lost RAM issue. I actually have about 8KB more available

Doh! s/KB/MB/ of course.

 > now than I had with 2.6.25.
