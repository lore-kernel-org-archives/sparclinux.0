From: David Miller <davem@davemloft.net>
Date: Mon, 22 Jun 2020 22:44:58 +0000
Subject: Re: [PATCH] sparc: piggyback: handle invalid image
Message-Id: <20200622.154458.2067869648476467711.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1591775719-28390-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1591775719-28390-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clabbe@baylibre.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Wed, 10 Jun 2020 07:55:19 +0000

> With an old elftoaout, the generation of tftpboot.img fail with "lseek:
> invalid argument".
> This is due to offset being negative.
> 
> Instead of printing this error message, let's print a better one.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thank you.
