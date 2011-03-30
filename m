From: David Miller <davem@davemloft.net>
Date: Wed, 30 Mar 2011 11:29:54 +0000
Subject: Re: [PATCH 2/2 v4] sparc32,leon: Fixed APBUART frequency detection
Message-Id: <20110330.042954.149834893.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1301483561-1402-2-git-send-email-daniel@gaisler.com>
In-Reply-To: <1301483561-1402-2-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 30 Mar 2011 13:12:41 +0200

> The UARTs may be located on different APB buses, thus have
> different UART clock frequency. The system frequency is not
> the same (but often) as the UART frequency, rather the APB bus
> frequency that the APBUART is located at has the same
> frequency, so this looks at the "freq" property instead.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

Applied.
