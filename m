From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sun, 24 Sep 2006 07:59:44 +0000
Subject: Re: [PATCH] no SA_NODEFER on sparc?
Message-Id: <Pine.LNX.4.61.0609240958550.28459@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
 <20060923.173924.78710069.davem@davemloft.net>
In-Reply-To: <20060923.173924.78710069.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: samuel.thibault@ens-lyon.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


>> I noticed that the sparc arch misses a definition for SA_NODEFER. Is
>> that on purpose?  If not, here is a patch for fixing this.

BTW, some SA_* constants have been superceded by IRQF_* in the kernel, 
so you might want to check the new ones.


Jan Engelhardt
-- 
