From: David Miller <davem@davemloft.net>
Date: Thu, 06 Apr 2017 19:07:15 +0000
Subject: Re: [PATCH v2] sparc: remove unused wp_works_ok macro
Message-Id: <20170406.120715.881409494250596175.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1491420260-32213-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1491420260-32213-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: minipli@googlemail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mathias Krause <minipli@googlemail.com>
Date: Wed,  5 Apr 2017 21:24:20 +0200

> It's unused for ages, used to be required for ksyms.c back in the v1.1
> times.
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Acked-by: David S. Miller <davem@davemloft.net>
> ---
> Hi Dave,
> 
> same patch as v1 but as the tip folks took only the x86 parts, I think,
> this one should go through the SPARC tree.

Ok, applied.
