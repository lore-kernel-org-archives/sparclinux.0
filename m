From: David Miller <davem@davemloft.net>
Date: Tue, 26 Feb 2008 21:32:36 +0000
Subject: Re: [BUG] 2.6.25-rc3 hangs in early boot on Sun Ultra5
Message-Id: <20080226.133236.47872026.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18371.10207.58819.188510@alkaid.it.uu.se>
	<18371.54294.748777.976300@harpo.it.uu.se>
In-Reply-To: <18371.54294.748777.976300@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 26 Feb 2008 09:55:50 +0100

> Minor update: rc2-git7 has the slow initial console behaviour,
> but successfully switches to the framebuffer. rc2-git8 however
> hangs in the console handover. So I'll bisect git7->git8 next.

Thanks for doing this research.
