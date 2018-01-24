From: David Miller <davem@davemloft.net>
Date: Wed, 24 Jan 2018 21:50:01 +0000
Subject: Re: [PATCH] sparc64: fix typo in CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64
Message-Id: <20180124.165001.873099042670433590.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1516717994-24407-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1516717994-24407-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clabbe@baylibre.com
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Tue, 23 Jan 2018 14:33:14 +0000

> This patch fixes the typo CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64
> 
> Fixes: 81658ad0d923 ("sparc64: Add CAMELLIA driver making use of the new camellia opcodes.")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thank you.
