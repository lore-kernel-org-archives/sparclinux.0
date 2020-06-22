From: David Miller <davem@davemloft.net>
Date: Mon, 22 Jun 2020 22:43:28 +0000
Subject: Re: [PATCH][next] sparc64: viohs: Use struct_size() helper
Message-Id: <20200622.154328.664862561349747570.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200620011406.GA3260@embeddedor>
In-Reply-To: <20200620011406.GA3260@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gustavoars@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gustavo@embeddedor.com

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Fri, 19 Jun 2020 20:14:06 -0500

> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> variable _len_.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thank you.
