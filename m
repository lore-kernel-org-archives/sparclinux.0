From: David Miller <davem@davemloft.net>
Date: Mon, 02 Jun 2014 01:52:45 +0000
Subject: Re: [PATCH] arch: sparc: kernel: smp_64.c: Optimization of the Code
Message-Id: <20140601.185245.1776835653575236303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1401659298-18067-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1401659298-18067-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rickard_strandqvist@spectrumdigital.se
Cc: tkhai@yandex.ru, paul.gortmaker@windriver.com, peterz@infradead.org, bhelgaas@google.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun,  1 Jun 2014 23:48:18 +0200

> From what I know, AND is faster then modulo.
> Not sure if this is worth changing though.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

This code came from the IA-64 arch code, so you probably want to
fix either both or neither.

I'd say neither, this is not a performance critical path and the
intent is clearer when expressed as a modulus.
