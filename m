From: David Miller <davem@davemloft.net>
Date: Thu, 28 Sep 2017 04:52:22 +0000
Subject: Re: [PATCH] sbus: char: Move D7S_MINOR to include/linux/miscdevice.h
Message-Id: <20170927.215222.2167373019183174531.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170918181036.30982-1-clabbe.montjoie@gmail.com>
In-Reply-To: <20170918181036.30982-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clabbe.montjoie@gmail.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 18 Sep 2017 20:10:36 +0200

> This patch move the define for D7S_MINOR to include/linux/miscdevice.h.
> It's better that all minor number are in the same place.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Applied.
