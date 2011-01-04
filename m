From: David Miller <davem@davemloft.net>
Date: Tue, 04 Jan 2011 19:17:16 +0000
Subject: Re: [PATCH 5/7] SPARC/LEON: avoid AMBAPP name duplicates in
Message-Id: <20110104.111716.48503513.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294141295-26584-5-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294141295-26584-5-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue,  4 Jan 2011 12:41:33 +0100

> When the REG property is not available the NODE-ID is used as an unique
> identifier in order to avoid filesystem name duplicates in /proc/openprom
> filesystem
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

Applied.
