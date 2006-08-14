From: David Miller <davem@davemloft.net>
Date: Mon, 14 Aug 2006 10:17:17 +0000
Subject: Re: latest 2.4.33 kernel
Message-Id: <20060814.031717.74746508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0601569276@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If memchr() is going to be used by some part of the kernel, a default
implementation should exist in lib/string.c and it's symbol exported.
