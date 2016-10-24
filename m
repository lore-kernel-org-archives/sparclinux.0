From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 18:05:05 +0000
Subject: Re: [PATCH] sparc64: Fix old style declaration GCC warnings
Message-Id: <20161024.140505.1575443842870504774.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161021132554.20839-1-tklauser@distanz.ch>
In-Reply-To: <20161021132554.20839-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri, 21 Oct 2016 15:25:54 +0200

> Fix [-Wold-style-declaration] GCC warnings by moving the inline keyword
> before the return type.
> 
> Signed-off-by: Tobias Klnuser <tklauser@distanz.ch>

Applied.
