From: David Miller <davem@davemloft.net>
Date: Fri, 21 Dec 2018 19:25:14 +0000
Subject: Re: [PATCH] sparc: Set "ARCH: sunxx" information on the same line
Message-Id: <20181221.112514.2125394297623092093.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1544530269-15008-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1544530269-15008-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clabbe@baylibre.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Tue, 11 Dec 2018 12:11:09 +0000

> While checking boot log from SPARC qemu, I saw that the "ARCH: sunxx"
> information was split on two different line.
> This patchs merge both line together.
> In the meantime, thoses information need to be printed via pr_info
> since printk print them by default via the warning loglevel.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied.
