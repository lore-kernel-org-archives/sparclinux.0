From: David Miller <davem@davemloft.net>
Date: Mon, 02 Mar 2015 05:35:16 +0000
Subject: Re: [PATCH] arch: sparc: kernel: traps_64.c: Remove some unused functions
Message-Id: <20150302.003516.967998826548879499.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1419078835-31499-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1419078835-31499-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rickard_strandqvist@spectrumdigital.se
Cc: sam@ravnborg.org, bpicco@meloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 20 Dec 2014 13:33:54 +0100

> Removes some functions that are not used anywhere:
> do_fpdis_tl1() do_iae_tl1() do_dae_tl1() do_cee_tl1()
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Applied.
