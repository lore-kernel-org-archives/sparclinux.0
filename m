From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 18:05:11 +0000
Subject: Re: [PATCH] sparc32: Fix old style declaration GCC warnings
Message-Id: <20161024.140511.1424086857261612375.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161021133903.7608-1-tklauser@distanz.ch>
In-Reply-To: <20161021133903.7608-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri, 21 Oct 2016 15:39:03 +0200

> Fix [-Wold-style-declaration] GCC warnings by moving the inline keyword
> before the return type.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied.
