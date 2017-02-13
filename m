From: David Miller <davem@davemloft.net>
Date: Mon, 13 Feb 2017 02:48:59 +0000
Subject: Re: [PATCH 4/6] sparc: remove unused wp_works_ok macro
Message-Id: <20170212.214859.1422772705417247389.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1486933932-585-1-git-send-email-minipli@googlemail.com>
        <1486933932-585-5-git-send-email-minipli@googlemail.com>
In-Reply-To: <1486933932-585-5-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: minipli@googlemail.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, bp@alien8.de, jesper.nilsson@axis.com, starvik@axis.com, geert@linux-m68k.org, x86@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mathias Krause <minipli@googlemail.com>
Date: Sun, 12 Feb 2017 22:12:10 +0100

> It's unused for ages, used to be required for ksyms.c back in the v1.1
> times.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Mathias Krause <minipli@googlemail.com>

Acked-by: David S. Miller <davem@davemloft.net>
