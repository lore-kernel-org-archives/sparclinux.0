From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:18 +0000
Subject: [PATCH 0/12]: Convert sparc64 to use generic RTC layer.
Message-Id: <20080828.230918.47426996.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Here are 12 patches that build upon Krzysztof's initial work to
convert all RTC support in the sparc64 port over to the generic
RTC layer.

The mini RTC driver gets deleted in the final patch.

These patches are against sparc-next-2.6, but the only fuzzy
conflict you'll get is in the arch/sparc64/Kconfig file and
that is trivial to deal with.

Enjoy.
